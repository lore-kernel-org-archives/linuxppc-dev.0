Return-Path: <rdunlap@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41NtBJ2LrJzDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2018 01:47:00 +1000 (AEST)
Subject: Re: powerpc: 32BIT vs. 64BIT (PPC32 vs. PPC64)
To: Michael Ellerman <mpe@ellerman.id.au>,
 linux-kbuild <linux-kbuild@vger.kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 linuxppc-dev@lists.ozlabs.org
References: <3f906b03-98ff-c081-4e19-b490f0b35c51@infradead.org>
 <87sh4uj675.fsf@concordia.ellerman.id.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d5935c67-ac6d-2904-ae2a-134ba85a706d@infradead.org>
Date: Sun, 8 Jul 2018 08:46:52 -0700
MIME-Version: 1.0
In-Reply-To: <87sh4uj675.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/08/2018 04:51 AM, Michael Ellerman wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
>> Hi,
>>
>> Is there a good way (or a shortcut) to do something like:
> 
> The best I know of is:
> 
>> $ make ARCH=powerpc O=PPC32 [other_options] allmodconfig
>>   to get a PPC32/32BIT allmodconfig
> 
> $ echo CONFIG_PPC64=n > allmod.config
> $ KCONFIG_ALLCONFIG=1 make allmodconfig
> $ grep PPC32 .config
> CONFIG_PPC32=y
> 
> Which is still a bit clunky.
> 

That's close to what I already do.  And it's very script-able.

> 
> I looked at this a while back and the problem we have is that the 32-bit
> kernel is not a single thing. There are multiple 32-bit platforms which
> are mutually exclusive.
> 
> eg, from menuconfig:
> 
>  - 512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx
>  - Freescale 85xx
>  - Freescale 8xx
>  - AMCC 40x
>  - AMCC 44x, 46x or 47x
>  - Freescale e200
> 
> 
> So we could have a 32-bit allmodconfig, but we'd need to chose one of
> the above, and we'd still only be testing some of the code.
> 
> Having said that you're the 2nd person to ask about this, so we should
> clearly do something to make a 32-bit allmodconfig easier, even if it's
> not perfect.

Thanks.

-- 
~Randy
