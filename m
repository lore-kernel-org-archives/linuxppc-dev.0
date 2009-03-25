Return-Path: <guangye.tian@gmail.com>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.187])
	by ozlabs.org (Postfix) with ESMTP id 3A4B8DDD1B
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 03:01:34 +1100 (EST)
Received: by ti-out-0910.google.com with SMTP id j2so68990tid.13
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 09:01:31 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 25 Mar 2009 17:01:31 +0100
Message-ID: <2a3c3b490903250901l65f46cdbv3c6f93f853b56bbf@mail.gmail.com>
Subject: FSL driver for powerpc linux2.6 (xilinx ML403)
From: Guangye Tian <guangye.tian@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I am working with the xilinx ML403 evaluation board which has a
Virtex4 FPGA and one powerpc405 processor is integrated.

I am trying to develop a linux driver for FSL link for powerpc405. I
developed one first version (with the referce of the microblaze fsl
driver developped by Mr. John Williams for uClinux) as a loadable
module, and loaded it after Linux is booted. But when I run some
testing function like "cat /dev/fslfifo", it crashes the kernel.

I suppose that it is because FSL operations (like nget, nput, etc. )
are not part of the ppc instruction set and are realized by APU
instruction extension. For the processor to execute the extended
instructions correctly, the MSR register should be set accordingly to
enable APU. (XREG_MSR_APU_AVAILABLE + XREG_MSR_APU_ENABLE). Before I
worked with ppc without os, and the management of special purpose
registers are rather straight forward and it concerns only some
assembly language at the beginning of the main() function. But with
os, I have no experience dealing explicitely with special purpose
registers. So I tried the following:

I set the MSR at the initialisation phase by

mtmsr(XREG_MSR_APU_AVAILABLE | XREG_MSR_APU_ENABLE | mfmsr())

However, when I set the MSR at the initialization function, and test
afterwards, the MSR value is set back to some default value. I don't
know where it happened neighter do I know if I am using the correct
measure to change the MSR value.

Does anybody have any suggestions?

Thank you,

Guangye
