Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BB1F9B7088
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 07:22:04 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n9EKLwJb029364
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2009 13:22:01 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n9EKOUvl007676
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2009 15:24:30 -0500 (CDT)
Message-ID: <4AD63301.6090307@freescale.com>
Date: Wed, 14 Oct 2009 15:22:25 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH 4/8] 8xx: Fixup DAR from buggy dcbX instructions.
References: <1255278912-8042-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-5-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091014172003.GD21215@loki.buserror.net>
	<OF64D89B73.6073827F-ONC125764F.00687BC4-C125764F.0068D4DC@transmode.se>
	<4AD62516.6090301@freescale.com>
	<OF22DCA2B2.1ADC3BC0-ONC125764F.006DE50F-C125764F.006E305A@transmode.se>
In-Reply-To: <OF22DCA2B2.1ADC3BC0-ONC125764F.006DE50F-C125764F.006E305A@transmode.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Rex Feany <RFeany@mrv.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joakim Tjernlund wrote:
> Scott Wood <scottwood@freescale.com> wrote on 14/10/2009 21:23:02:
>> Joakim Tjernlund wrote:
>>> BTW, you could add a test and printk in do_page_fault on address 0x000000f0.
>>> if that ever hits there is a problem with dcbX fixup.
>> It doesn't get any 0xf0 faults.
>>
>> FWIW, I'm not seeing the segfault any more, but I still get the lockup.
> 
> Have you reverted
>  8xx: start using dcbX instructions in various copy routines ?
> 
> After that you could stick a
>  b DataAccess
> 
>  directly in the DTLB error handler to skip and dcbX fixups.

With that, I don't see the hard lockup, but things get stuck during 
bootup with everything idle.  I see this even if I revert everything but 
the "invalidate non present TLBs" patch, and I was seeing similar things 
sometimes with the other tlbil_va hacks.

I think there's something else going on in the 2.6 8xx code that needs 
to be fixed before we can tell what the impact of these patches is. 
I'll look into it.

-Scott
