Return-Path: <mpn@google.com>
Received: from mail-wg0-x22b.google.com (mail-wg0-x22b.google.com
 [IPv6:2a00:1450:400c:c00::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BC3991A02B9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 18:55:39 +1000 (EST)
Received: by mail-wg0-f43.google.com with SMTP id b13so888667wgh.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 01:55:35 -0700 (PDT)
Sender: Michal Nazarewicz <mpn@google.com>
From: Michal Nazarewicz <mina86@mina86.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 01/10] DMA, CMA: clean-up log message
In-Reply-To: <20140612055358.GA30128@js1304-P5Q-DELUXE>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-2-git-send-email-iamjoonsoo.kim@lge.com>
 <87y4x2pwnk.fsf@linux.vnet.ibm.com>
 <20140612055358.GA30128@js1304-P5Q-DELUXE>
Date: Thu, 12 Jun 2014 10:55:32 +0200
Message-ID: <xa1toaxyjym3.fsf@mina86.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, kvm@vger.kernel.org,
 linux-mm@kvack.org, Gleb Natapov <gleb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> Joonsoo Kim <iamjoonsoo.kim@lge.com> writes:
>>=20
>> > We don't need explicit 'CMA:' prefix, since we already define prefix
>> > 'cma:' in pr_fmt. So remove it.
>> >
>> > And, some logs print function name and others doesn't. This looks
>> > bad to me, so I unify log format to print function name consistently.
>> >
>> > Lastly, I add one more debug log on cma_activate_area().
>> >
>> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>> >
>> > diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguo=
us.c
>> > index 83969f8..bd0bb81 100644
>> > --- a/drivers/base/dma-contiguous.c
>> > +++ b/drivers/base/dma-contiguous.c
>> > @@ -144,7 +144,7 @@ void __init dma_contiguous_reserve(phys_addr_t lim=
it)
>> >  	}
>> >
>> >  	if (selected_size && !dma_contiguous_default_area) {
>> > -		pr_debug("%s: reserving %ld MiB for global area\n", __func__,
>> > +		pr_debug("%s(): reserving %ld MiB for global area\n", __func__,
>> >  			 (unsigned long)selected_size / SZ_1M);

> On Thu, Jun 12, 2014 at 10:11:19AM +0530, Aneesh Kumar K.V wrote:
>> Do we need to do function(), or just function:. I have seen the later
>> usage in other parts of the kernel.

On Thu, Jun 12 2014, Joonsoo Kim <iamjoonsoo.kim@lge.com> wrote:
> I also haven't seen this format in other kernel code, but, in cma, they u=
se
> this format as following.
>
> function(arg1, arg2, ...): some message
>
> If we all dislike this format, we can change it after merging this
> patchset. Until then, it seems better to me to leave it as is.

I used =E2=80=9Cfunction(arg1, arg2, =E2=80=A6)=E2=80=9D at the *beginning*=
 of functions when
the arguments passed to the function were included in the message.  In
all other cases I left it at just =E2=80=9Cfunction:=E2=80=9D (or just no a=
dditional
prefix).  IMO that's a reasonable strategy.

--=20
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=3D./ `o
..o | Computer Science,  Micha=C5=82 =E2=80=9Cmina86=E2=80=9D Nazarewicz   =
 (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
