Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 45253DDDF6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Jan 2007 00:07:17 +1100 (EST)
Message-ID: <45ACC0E6.5020607@cambridgebroadband.com>
Date: Tue, 16 Jan 2007 12:11:18 +0000
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: onetarget@sina.com
Subject: Re: Boot Linux 2.4.25 on MPC8270 board errors.
References: <20070112040015.72172.qmail@mail3-101.sinamail.sina.com.cn>
In-Reply-To: <20070112040015.72172.qmail@mail3-101.sinamail.sina.com.cn>
Content-Type: text/plain; charset=GB2312
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

onetarget@sina.com wrote:
> Dear all,
>     I am now using ELDK 3.1.1 to build Linux-2.4.25 for an MPC8270 
> board. The board has 128MB SDRAM, and in fcc_enet.c
>     I configured the followings,
> #define FCC_ENET_RX_PAGES    32 /*16 */
> #define FCC_ENET_RX_FRSIZE    2048
> #define FCC_ENET_RX_FRPPG    (PAGE_SIZE / FCC_ENET_RX_FRSIZE)
> #define RX_RING_SIZE        (FCC_ENET_RX_FRPPG * FCC_ENET_RX_PAGES)
> #define TX_RING_SIZE        128 /*16    /* Must be power of two */
> #define TX_RING_MOD_MASK    127 /*15    /*   for this to work */
> 
>     but when boot the image, I got following errors.
>   
> 
> 
> Register rtc driver 1.0 successfully!
> eth0: FCC1 ENET Version 0.4, 00:08:02:06:00:00
> eth0: Phy @ 0x10, type LXT971 (0x001378e2)
> Oops: kernel access of bad area, sig: 11
> NIP: C01E93B8 XER: 00000000 LR: C01E9288 SP: C03BDED0 REGS: c03bde20 
> TRAP: 0300    Not tainted
> MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: 00000000, DSISR: 22000000
> TASK = c03bc000[1] 'swapper' Last syscall: 120
> last math 00000000 last altivec 00000000
> GPR00: 00000000 C03BDED0 C03BC000 F000B0C0 88888888 00000000 F000B0DC 
> 00000000
> GPR08: 00000200 00000000 00000000 000005F0 84004044 10052210 07FE2000 
> 007FFF10
> GPR16: 00000001 00000000 007FFF00 FFFFFFFF 003FF000 00000000 07F7FBF8 
> C00A1BA0
> GPR24: C01F2C2C C01D0B5C F00119C0 C7FCB000 C03BE600 00000000 FFFFFFFF 
> F0008500
> Call backtrace:
> C01A78C0 C01E8DD8 C01E77E8 C01E7824 C01E9BC4 C01E73A4 C01E0624
> C00039D0 C00081B8
> Kernel panic: Attempted to kill init!
> 
>     My question is, what should I set the above values??
>     Thank you and regards,
> 
>     W.Target

Leave these defines at the values in the original source code.  Use ksymoops to
examine the oops text and determine where the bad access occurred.

Alex
