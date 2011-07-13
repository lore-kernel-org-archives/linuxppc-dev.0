Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 944D5B6F6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Jul 2011 21:18:08 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p6DArvW5006211
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2011 06:53:57 -0400
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p6DBI1xl090740
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2011 07:18:04 -0400
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p6DBNTcn008689
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2011 05:23:30 -0600
Date: Wed, 13 Jul 2011 07:18:22 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc32: Kexec support for PPC440X chipsets
Message-ID: <20110713111822.GE4203@zod.rchland.ibm.com>
References: <20110712064356.28567.48722.stgit@suzukikp.in.ibm.com>
	<BE0C6BFF-E55A-4860-A05C-CA5313012FCC@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BE0C6BFF-E55A-4860-A05C-CA5313012FCC@kernel.crashing.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	kexec <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>,
	"Suzuki K. Poulose" <suzuki@in.ibm.com>, Paul Mackerras <paulus@samba.org>,
	linux ppc dev <linuxppc-dev@lists.ozlabs.org>,
	Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 13, 2011 at 12:28:36AM -0500, Kumar Gala wrote:
>
>On Jul 12, 2011, at 1:44 AM, Suzuki K. Poulose wrote:
>
>> Changes from V1: Uses a tmp mapping in the other address space to setup
>> 		 the 1:1 mapping (suggested by Sebastian Andrzej Siewior).
>> 
>> Note: Should we do the same for kernel entry code for PPC44x ?
>> 
>> This patch adds kexec support for PPC440 based chipsets.This work is based
>> on the KEXEC patches for FSL BookE.
>> 
>> The FSL BookE patch and the code flow could be found at the link below:
>> 
>> 	http://patchwork.ozlabs.org/patch/49359/
>> 
>> Steps:
>> 
>> 1) Invalidate all the TLB entries except the one this code is run from
>> 2) Create a tmp mapping for our code in the other address space and jump to it
>> 3) Invalidate the entry we used
>> 4) Create a 1:1 mapping for 0-2GiB in blocks of 256M
>> 5) Jump to the new 1:1 mapping and invalidate the tmp mapping
>> 
>> I have tested this patches on Ebony, Sequoia boards and Virtex on QEMU.
>> It would be great if somebody could test this on the other boards.
>> 
>> Signed-off-by: 	Suzuki Poulose <suzuki@in.ibm.com>
>> Cc:	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> ---
>> 
>> arch/powerpc/Kconfig             |    2 
>> arch/powerpc/include/asm/kexec.h |    2 
>> arch/powerpc/kernel/misc_32.S    |  170 ++++++++++++++++++++++++++++++++++++++
>> 3 files changed, 172 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 423145a6..d04fae0 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -349,7 +349,7 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
>> 
>> config KEXEC
>> 	bool "kexec system call (EXPERIMENTAL)"
>> -	depends on (PPC_BOOK3S || FSL_BOOKE) && EXPERIMENTAL
>> +	depends on (PPC_BOOK3S || FSL_BOOKE || (44x && !SMP && !47x)) && EXPERIMENTAL
>
>Is there something special about 47x that its not supported?

It's a different MMU type (again), that is similar to 44x but not exact.
We can't run a single kernel image on both yet, for example.

Also, they aren't widely available so testing on them is difficult.

josh
