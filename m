Return-Path: <kumar.gala@freescale.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id 618772BF08
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  1 Nov 2004 16:43:56 +1100 (EST)
Received: from il06exr04.mot.com (il06exr04.mot.com [129.188.137.134])
	by motgate8.mot.com (Motorola/Motgate8) with ESMTP id iA15jLnQ019210
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 31 Oct 2004 22:45:21 -0700 (MST)
In-Reply-To: <642F8D42-2A11-11D9-A860-000393C30512@freescale.com>
References: <642F8D42-2A11-11D9-A860-000393C30512@freescale.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0329659A-2BC9-11D9-A949-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Sun, 31 Oct 2004 23:43:52 -0600
To: "Fleming Andy-afleming" <afleming@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: RFC: performance monitor/oprofile support for e500
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andy,

Some feedback:

* Any reason to get ride of the 604 code now,w/o replacing it with 
something?
* Why have you introduce two CPU features (CPU_FTR_CAN_USE_PMON_INTR & 
CPU_FTR_FSL_BOOKE_PMON) you dont use ?
* In the PerformanceMonitor can't you use regs->nip for the same 
purpose of regs->sia?
* Does arch/ppc/kernel/perfmon.c really need all the headers you are 
including?
* Does perfmon.c make more sense as perfmon_fsl_booke.c
* op_ppc32_setup, I'd prefer the saving & restoring of the perf_irq 
like arch/ppc64/oprofile/common.c does
* a number of issues related to SMP
* any reason get_kernel is a function?
* Do ctr_read & ctr_write really belong in op_impl.h, especially since 
different implementations will be needed for classic ppc.


I sent a note to Paul M. about putting num_counters into cpu_specs 
table.

- kumar

On Oct 29, 2004, at 8:16 PM, Fleming Andy-afleming wrote:

> This patch:
>  * Adds support for using the performance monitor counters and the
> associated interrupt, but only enables it currently for e500
>  * Removes the old 604 performance monitor code, suggested by various
> people on IRC
> * Adds oprofile support for the e500, with potential for expansion to
> support other ppc32 processors
>
> Andy Fleming
>  NCSG Open Source Team
>  Freescale Semiconductor, Inc
> <oprofile-kernel-patch><ATT2027925.txt>
