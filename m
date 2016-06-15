Return-Path: <Yuri.Norov@caviumnetworks.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0098.outbound.protection.outlook.com [65.55.169.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVK1x03kxzDqlJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 07:11:16 +1000 (AEST)
Date: Thu, 16 Jun 2016 00:11:04 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Borislav Petkov <bp@suse.de>, David Ahern <dsahern@gmail.com>, George Spelvin
 <linux@horizon.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim
 <namhyung@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Wang Nan
 <wangnan0@huawei.com>, Yury Norov <yury.norov@gmail.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Subject: Re: [PATCH] tools/perf: fix the word selected in find_*_bit
Message-ID: <20160615211104.GA6978@yury-N73SV>
References: <1465990973-31483-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20160615195127.GA6039@yury-N73SV>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20160615195127.GA6039@yury-N73SV>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 15, 2016 at 10:51:27PM +0300, Yury Norov wrote:
> Hi Madhavan,
> 
> On Wed, Jun 15, 2016 at 05:12:53PM +0530, Madhavan Srinivasan wrote:
> > When decoding the perf_regs mask in regs_dump__printf(),
> > we loop through the mask using find_first_bit and find_next_bit functions.
> > And mask is of type "u64". But "u64" is send as a "unsigned long *" to
> > lib functions along with sizeof().
> > 
> > While the exisitng code works fine in most of the case, when using a 32bit perf
> > on a 64bit kernel (Big Endian), we end reading the wrong word. In find_first_bit(),
> > one word at a time (based on BITS_PER_LONG) is loaded and
> > checked for any bit set. In 32bit BE userspace,
> > BITS_PER_LONG turns out to be 32, and for a mask value of
> > "0x00000000000000ff", find_first_bit will return 32, instead of 0.
> > Reason for this is that, value in the word0 is all zeros and value
> > in word1 is 0xff. Ideally, second word in the mask should be loaded
> > and searched. Patch swaps the word to look incase of 32bit BE.
> 
> I think this is not a problem of find_bit() at all. You have wrong
> typecast as the source of problem (tools/perf/util/session.c"):
> 
> 940 static void regs_dump__printf(u64 mask, u64 *regs)
> 941 {
> 942         unsigned rid, i = 0;
> 943 
> 944         for_each_set_bit(rid, (unsigned long *) &mask, sizeof(mask) * 8) {
>                                           ^^^^ Here ^^^^
> 945                 u64 val = regs[i++];
> 946 
> 947                 printf(".... %-5s 0x%" PRIx64 "\n",
> 948                        perf_reg_name(rid), val);
> 949         }
> 950 }
> 
> But for some reason you change correct find_bit()...
> 
> Though proper fix is like this for me:
> 
> static void regs_dump__printf(u64 mask, u64 *regs)
> {
>         unsigned rid, i = 0;
>         unsigned long _mask[sizeof(mask)/sizeof(unsigned long)];
> 
>         _mask[0] = mask & ULONG_MAX;
>         if (sizeof(mask) > sizeof(unsigned long))
>                 _mask[1] = mask >> BITS_PER_LONG;
> 
>         for_each_set_bit(rid, _mask, sizeof(mask) * BITS_PER_BYTE) {
>                 u64 val = regs[i++];
> 
>                 printf(".... %-5s 0x%" PRIx64 "\n",
>                        perf_reg_name(rid), val);
>         }
> }
> 
> Maybe there already is some macro doing the conversion for you...

yes it is, cpu_to_le64() is what you want

> 
> Yury.
> 
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Borislav Petkov <bp@suse.de>
> > Cc: David Ahern <dsahern@gmail.com>
> > Cc: George Spelvin <linux@horizon.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Cc: Wang Nan <wangnan0@huawei.com>
> > Cc: Yury Norov <yury.norov@gmail.com>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> > ---
> >  tools/lib/find_bit.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/tools/lib/find_bit.c b/tools/lib/find_bit.c
> > index 9122a9e80046..996b3e04324f 100644
> > --- a/tools/lib/find_bit.c
> > +++ b/tools/lib/find_bit.c
> > @@ -37,7 +37,12 @@ static unsigned long _find_next_bit(const unsigned long *addr,
> >  	if (!nbits || start >= nbits)
> >  		return nbits;
> > 
> > +#if (__BYTE_ORDER == __BIG_ENDIAN) && (BITS_PER_LONG != 64)
> > +	tmp = addr[(((nbits - 1)/BITS_PER_LONG) - (start / BITS_PER_LONG))]
> > +								^ invert;
> > +#else
> >  	tmp = addr[start / BITS_PER_LONG] ^ invert;
> > +#endif
> > 
> >  	/* Handle 1st word. */
> >  	tmp &= BITMAP_FIRST_WORD_MASK(start);
> > @@ -48,7 +53,12 @@ static unsigned long _find_next_bit(const unsigned long *addr,
> >  		if (start >= nbits)
> >  			return nbits;
> > 
> > +#if (__BYTE_ORDER == __BIG_ENDIAN) && (BITS_PER_LONG != 64)
> > +		tmp = addr[(((nbits - 1)/BITS_PER_LONG) - (start / BITS_PER_LONG))]
> > +								^ invert;
> > +#else
> >  		tmp = addr[start / BITS_PER_LONG] ^ invert;
> > +#endif
> >  	}
> > 
> >  	return min(start + __ffs(tmp), nbits);
> > @@ -75,8 +85,15 @@ unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
> >  	unsigned long idx;
> > 
> >  	for (idx = 0; idx * BITS_PER_LONG < size; idx++) {
> > +#if (__BYTE_ORDER == __BIG_ENDIAN) && (BITS_PER_LONG != 64)
> > +		if (addr[(((size-1)/BITS_PER_LONG) - idx)])
> > +			return min(idx * BITS_PER_LONG +
> > +				__ffs(addr[(((size-1)/BITS_PER_LONG) - idx)]),
> > +									size);
> > +#else
> >  		if (addr[idx])
> >  			return min(idx * BITS_PER_LONG + __ffs(addr[idx]), size);
> > +#endif
> >  	}
> > 
> >  	return size;
> > --
> > 1.9.1
