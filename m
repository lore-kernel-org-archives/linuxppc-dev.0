Return-Path: <morten.banzon@axxessit.no>
Received: from pt20-qms-01.ptn.no (pt20-qms-01.ptn.no [64.28.25.138])
	by ozlabs.org (Postfix) with SMTP id 686AD2BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Nov 2004 02:07:48 +1100 (EST)
To: "Rune Torgersen" <runet@innovsys.com>
MIME-Version: 1.0
Message-ID: <OF0F461522.C7376199-ONC1256F4E.00528030-C1256F4E.00531697@axxessit.no>
From: morten.banzon@axxessit.no
Date: Tue, 16 Nov 2004 16:07:33 +0100
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: MPC82xx -- DPRAM1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

OK, I get i now.
The first 128 bytes of dpram1 contains  pointers to the smc buffer 
descriptor table, which again points to the buffer descriptor bases.
It is the SMC1_BASE@0x87FC(dpram2)  and the SMC2_BASE@0x88FC(dpram2) which 

points to these addresses.
This is configured in include/asm-ppc/cpm2.h with the two constants 
PROFF_SMC1 and PROFF_SMC2.

I will try to move all smc related data out of the dpram1 regions that I 
need for mcc and see if I can avoid killing the smc.

Does anyone know if there is any trouble movig the smc around within 
drpam1 ?
I guess it must have been done by several users of linux on mpc82xx.

-- Morten






"Rune Torgersen" <runet@innovsys.com>
16.11.2004 15:58

 
        To:     <morten.banzon@axxessit.no>
        cc:     <linuxppc-embedded@ozlabs.org>
        Subject:        RE: MPC82xx -- DPRAM1


Check the drivers/serial/cpm_uart stuff.
In older kernels (before the uart move, ie 2.6.7) the start of dpram was
taken by the initial SCC/SMC driver for initial console output before
the full CPM drivers were initialized. The addresses were hardcoded
because the driver was initialized before the dpalloc functions were
initailized.

There might be some left over from that. Look for anything getting set
to cpm2_immr->im_dprambase[0]


> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org 
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of 
> morten.banzon@axxessit.no
> Sent: Tuesday, November 16, 2004 05:17
> To: Mark Chambers
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: MPC82xx -- DPRAM1
> 
> 
> I am not sure if I understand you. The CPM must have been 
> told somehow 
> that there is something for its peripherals in this 
> particular region of 
> the dpram1 or no ? I wild guess could be that the bootloader 
> (in this case 
> u-boot) has configured this area of dpram1 behind the back of 
> the kernel. 
> I assume that is not the case. Would not that be rather ugly ?
> 
> The mcc driver I am trying to get running on linux-2.6.9 is a 
> driver I 
> wrote for pSos a few years ago, and it is running fine on 
> that platform. Therefore, I am sure that there is nothing i 
> the processor or the cpm that 
> prevents me from putting mcc related parameters at offset zero in the 
> dpram1.
> I am still trying to figure out what piece of code in the 
> kernel that I 
> have to manipulate to get this driver working. 
> 
> Thanks for any advise,
> Morten
