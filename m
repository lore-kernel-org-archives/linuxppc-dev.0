Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5EA3C1007E1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 Nov 2009 04:37:31 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nAJHbR2e025538 for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 Nov 2009 10:37:27 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id nAJHfliP019878
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 Nov 2009 11:41:47 -0600 (CST)
Date: Thu, 19 Nov 2009 11:37:25 -0600
From: Scott Wood <scottwood@freescale.com>
To: Ming Lei <mlei@Brocade.COM>
Subject: Re: watchdog exception on 8548CDS during cpu_idle
Message-ID: <20091119173725.GA6845@b07421-ec1.am.freescale.net>
References: <7301F255FCB62048851F165FFAAF9BD106E9B3F0E5@HQ-EXCH-7.corp.brocade.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7301F255FCB62048851F165FFAAF9BD106E9B3F0E5@HQ-EXCH-7.corp.brocade.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 18, 2009 at 03:53:27PM -0800, Ming Lei wrote:
> 
> I used the vanilla linux 2.6.30 and compiled with mpc85xx_defconfig(enable CONFIG_BOOK_WDT) and then ran on 8548CDS and soon after I saw the prompt I hit this watchdog.
>  
> bash-2.04# PowerPC Book-E Watchdog Exception
> NIP: c000b740 LR: c00088dc CTR: c000b6b0
> REGS: cfffbf10 TRAP: 3202   Not tainted  (2.6.30)
> MSR: 00029000 <EE,ME,CE>  CR: 28028048  XER: 20000000
> TASK = c04f4458[0] 'swapper' THREAD: c052c000
> GPR00: c000b6b0 c052df90 c04f4458 00800000 80804080 0000001d c053af48 00069000 
> GPR08: ffffffff 00000000 08954400 00000000 002167ee 7f652f31 0ffad800 0fff0000 
> GPR16: 00000000 00000000 00000000 00000000 00000000 f30a620b 0ff50450 00000000 
> GPR24: 00000000 00000000 c053506c c0534fa0 c0534fa0 c052c034 00000008 c052c000 
> NIP [c000b740] e500_idle+0x90/0x94
> LR [c00088dc] cpu_idle+0x98/0xec
> Call Trace:
> [c052df90] [c000889c] cpu_idle+0x58/0xec (unreliable)
> [c052dfb0] [c00023ec] rest_init+0x5c/0x70
> [c052dfc0] [c04c16f4] start_kernel+0x22c/0x290
> [c052dff0] [c0000398] skpinv+0x2b0/0x2ec
> Instruction dump:
> 7c90faa6 548402ce 7c841b78 4c00012c 7c90fba6 4c00012c 7ce000a6 64e70004 
> 60e78000 7c0004ac 7ce00124 4c00012c <48000000> 812b00a0 912b0090 39600000 
> 
> Have anyone seen this before? Why the EE bit is on in the stack trace?
> I put show_regs in watchdog exception handler in traps.c. I verified
> that EE is off when entering the watchdog exception handler. Can I
> trust this stack trace?

EE is there because it was set in the context that got interrupted, just
as all the other state is for the interrupted context.

-Scott
