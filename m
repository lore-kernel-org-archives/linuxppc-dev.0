Return-Path: <DaveLiu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 4D7EA67BC6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Nov 2006 19:48:51 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	kAHAAOFd022101 for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Nov 2006 03:10:24 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id kAH8mjBC002346
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Nov 2006 02:48:47 -0600 (CST)
Subject: Re: memory corruption after MMU turned on
From: Dave Liu <r63238@freescale.com>
To: Lei Sun <leisun124@gmail.com>
In-Reply-To: <f9a7e7a80611160744t7071ff6clf5e1d42cfaa2c856@mail.gmail.com>
References: <f9a7e7a80611160744t7071ff6clf5e1d42cfaa2c856@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 16:48:44 +0800
Message-Id: <1163753324.3655.18.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Thu, 2006-11-16 at 10:44 -0500, Lei Sun wrote:
> Hi all:
>    I am trying to bring up customized board based on MPC8270, the
> kernel version is 2.4.30, it works fine on one of the Eval board
> (PQ2FADS-VR, which use MPC8275).
>    The kernel hangs after uncompressing is done, further debug shows
> that it hangs right after "rfi " instruction of the turn_on_mmu:
> function in head.S
> 
>  turn_on_mmu:
>     240     mfmsr   r0
>     241     ori r0,r0,MSR_DR|MSR_IR
>     242     mtspr   SRR1,r0
>     243     lis r0,start_here@h
>     244     ori r0,r0,start_here@l
>     245     mtspr   SRR0,r0
>     246     SYNC
>     247     RFI             /* enables MMU */
> 
> After i step over the RFI instruction, the PC points to C000XXX , but
> all memory content is 0 by then.
> my BATU0 is 0xC000FFE0  BATL0 is 0x00000002, I have 128MB RAM. The
> u-boot works fine, without MMU turned on. We do have some hardware
> problem, such that i have to lower the bus frequency to make the SDRAM
> stable. What physical parameter could cause the board not working with
> MMU on?

When MMU turn on, the kernel memory should be cacheable, so the
processor will burst read instructions from memory to i-cache. Did you
do the burst read/write memory test in u-boot? As you said, you did not
do the test.

-Dave
