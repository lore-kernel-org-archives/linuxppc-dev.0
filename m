Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CC294B6F00
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Nov 2009 08:08:44 +1100 (EST)
Message-ID: <4B046248.7060101@freescale.com>
Date: Wed, 18 Nov 2009 15:08:24 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH 00/10] Fix 8xx MMU/TLB
References: <1258304977-11760-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091116210009.GA5113@loki.buserror.net>
	<20091116212741.GA10968@loki.buserror.net>
	<OF8A8D1539.83855DA3-ONC1257670.007D4AD1-C1257670.007DC74A@transmode.se>
	<4B01F0EB.70707@freescale.com>
	<OF735CB2F5.65B4E3F3-ONC1257671.002BB41C-C1257671.002C5E4F@transmode.se>
In-Reply-To: <OF735CB2F5.65B4E3F3-ONC1257671.002BB41C-C1257671.002C5E4F@transmode.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joakim Tjernlund wrote:
> Scott Wood <scottwood@freescale.com> wrote on 17/11/2009 01:40:11:
>> No...  I only meant that the ITLB pinning got rid of the boot hang.
>>
>> When I mentioned the EFAULTs before you said, "No surprise as the it
>> seems like the DAR decoding is broken."  I thought you meant you'd found
>> a bug and fixed it in this respin.
> 
> Oh, there seems to be a misunderstanding here :)
> Lets go back a bit, you said some time ago:
> /Quote
>>> +3:   lwz   r11, 0(r11)		 /* Get the level 1 entry */
>>>       DO_8xx_CPU6(0x3b80, r3)
>>>       mtspr SPRN_MD_TWC, r11		 /* Load pte table base address */
>>>       mfspr r11, SPRN_MD_TWC		 /* ....and get the pte address */
>>>       lwz   r11, 0(r11)		 /* Get the pte */
>>>       /* concat physical page address(r11) and page offset(r10) */
>>>       rlwimi      r11, r10, 0, 20, 31
>> But r10 here contains SRR0 from above, and this is a data TLB error.
> 
> Never mind that last one, forgot that you'd be wanting to load the
> instruction. :-P
> 
> But the rlwimi is what's causing the machine checks.  I replaced it with:
> rlwinm		 r11, r11, 0, 0x3ffff000
> rlwimi		 r11, r10, 22, 0xffc
> 
> and things seem to work.  You could probably replace the rlwinm by
> subtracting PAGE_OFFSET from swapper_pg_dir instead.
> /End Quote
> 
> I read this as now everything is working, but I guess I misunderstood?
> You still have EFAULT here?

Ah, that one -- I don't recall whether it was fully working back then, or 
whether I just didn't notice the EFAULTs and was commenting more on the machine 
checks going away.

In the current patchset, it's "8xx: start using dcbX instructions in various 
copy routines" that introduces the problem.

-Scott
