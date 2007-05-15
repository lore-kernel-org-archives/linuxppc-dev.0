Return-Path: <miroslaw.dach@psi.ch>
Received: from MAILSEND01.psi.ch (mailsend01.psi.ch [129.129.191.53])
	by ozlabs.org (Postfix) with ESMTP id 62FF3DDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 May 2007 04:49:46 +1000 (EST)
Date: Tue, 15 May 2007 20:49:44 +0200 (CEST)
From: Miroslaw Dach <miroslaw.dach@psi.ch>
To: Andrei Konovalov <akonovalov@ru.mvista.com>
Subject: Re: zImage.elf loads but does not start
In-Reply-To: <4649F6FF.7060003@ru.mvista.com>
Message-ID: <Pine.LNX.4.44.0705152027280.16487-100000@slslc02.psi.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

> Hmm...
> IIRC TEMAC is configured in FIFO mode.
> And I thought the problem could be due to small FIFOs. So that the default
> NFS reply of 4kbytes could not fit into the receive FIFO, and the CPU is not
> fast enough to read the reply out of the FIFO before it overflows.
> But your observations don't seem to confirm this is the case.
> 
> Anyway, you could try adding
>    nfsroot=,rsize=1024,wsize=1024
> to your cmdline just in case...

Thanks for the suggestions. I will try it tomorrow. I have the feeling 
however that it might be the kernel configuration which might be not 
correct.

My board has 32 Mbytes of RAM. I have configured kernel as follows: 

* Initial RAM filesystem and RAM disk (initramfs/initrd) suppor 
*RAM disk support 
1 Default number of RAM disks 
8192 Default RAM disk size (kbytes) 
(1024) Default RAM disk block size (bytes) 


I do not know however if the stack is properly configured since I did not 
see any parameter in kernel which refers to the stack or heap. 

My bsp i.e xparameteres_ml403.h contains two macros:
#define XPAR_DDR_SDRAM_1_MEM0_BASEADDR 0x00000000
#define XPAR_DDR_SDRAM_1_MEM0_HIGHADDR 0x01FFFFFF

I have the feeling that they are ignored because I did not find anywhere 
in the kernel source those names. 

When kernel boots it prints at the beginning:
loaded at:     00400000 004F9138 
board data at: 004F7120 004F7138 
relocated to:  00404064 0040407C 
zimage at:     00404DF1 004F6BBB 
avail ram:     004FA000 04000000 

According to my understanding kernel first copies "init" to RAM and  
executes it there. Maybe init and/or related libraries are copied to the 
memory location beyond RAM ? This is what comes to my mind right now.

Best Regards

Mirek
