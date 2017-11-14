Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ybhkP5BtYzDqb4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 20:18:05 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal Hocko <mhocko@kernel.org>
Cc: Joel Stanley <joel@jms.id.au>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Ralf Baechle <ralf@linux-mips.org>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 "David S. Miller" <davem@davemloft.net>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org
Subject: Re: linux-next: Tree for Nov 7
In-Reply-To: <20171113160637.jhekbdyfpccme3be@dhcp22.suse.cz>
References: <CACPK8Xfd4nqkf=Lk3n6+TNHAAi327r0dkUfGypZ3TpR0LqfS4Q@mail.gmail.com>
 <20171108142050.7w3yliulxjeco3b7@dhcp22.suse.cz>
 <20171110123054.5pnefm3mczsfv7bz@dhcp22.suse.cz>
 <CACPK8Xe5uUKEytkRiszdX511b_cYTD-z3X=ZsMcNJ-NOYnXfuQ@mail.gmail.com>
 <20171113092006.cjw2njjukt6limvb@dhcp22.suse.cz>
 <20171113094203.aofz2e7kueitk55y@dhcp22.suse.cz>
 <87lgjawgx1.fsf@concordia.ellerman.id.au>
 <20171113120057.555mvrs4fjq5tyng@dhcp22.suse.cz>
 <20171113151641.yfqrecpcxllpn5mq@dhcp22.suse.cz>
 <20171113154939.6ui2fmpokpm7g4oj@dhcp22.suse.cz>
 <20171113160637.jhekbdyfpccme3be@dhcp22.suse.cz>
Date: Tue, 14 Nov 2017 20:18:04 +1100
Message-ID: <87a7zpw75f.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michal Hocko <mhocko@kernel.org> writes:

> [Sorry for spamming, this one is the last attempt hopefully]
>
> On Mon 13-11-17 16:49:39, Michal Hocko wrote:
>> On Mon 13-11-17 16:16:41, Michal Hocko wrote:
>> > On Mon 13-11-17 13:00:57, Michal Hocko wrote:
>> > [...]
>> > > Yes, I have mentioned that in the previous email but the amount of code
>> > > would be even larger. Basically every arch which reimplements
>> > > arch_get_unmapped_area would have to special case new MAP_FIXED flag to
>> > > do vma lookup.
>> > 
>> > It turned out that this might be much more easier than I thought after
>> > all. It seems we can really handle that in the common code. This would
>> > mean that we are exposing a new functionality to the userspace though.
>> > Myabe this would be useful on its own though. Just a quick draft (not
>> > even compile tested) whether this makes sense in general. I would be
>> > worried about unexpected behavior when somebody set other bit without a
>> > good reason and we might fail with ENOMEM for such a call now.
>> 
>> Hmm, the bigger problem would be the backward compatibility actually. We
>> would get silent corruptions which is exactly what the flag is trying
>> fix. mmap flags handling really sucks. So I guess we would have to make
>> the flag internal only :/
>
> OK, so this one should take care of the backward compatibility while
> still not touching the arch code

I'm not sure I understand your worries about backward compatibility?

If we add a new mmap flag which is currently unused then what is the
problem? Are you worried about user code that accidentally passes that
flag already?

> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index 203268f9231e..03c518777f83 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -25,6 +25,8 @@
>  # define MAP_UNINITIALIZED 0x0		/* Don't support this flag */
>  #endif
>  
> +#define MAP_FIXED_SAFE 0x2000000	/* MAP_FIXED which doesn't unmap underlying mapping */
> +

As I said in my other mail I think this should be a modifier to
MAP_FIXED. That way all the existing code that checks for MAP_FIXED (in
the kernel) works exactly as it currently does - like the check Khalid
pointed out.

And I think MAP_NO_CLOBBER would be a better name.

cheers
