Return-Path: <bob@acdstar.com>
Received: from mail.acdstar.com (mail.acdstar.com [209.98.244.9])
	by ozlabs.org (Postfix) with ESMTP id E144668162
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Sep 2005 00:20:32 +1000 (EST)
Message-Id: <6.2.3.4.1.20050908091250.01eea878@mail.int.acdstar.com>
Date: Thu, 08 Sep 2005 09:18:28 -0500
To: Frank Beesley <frank.beesley@aeroflex.com>, linuxppc-embedded@ozlabs.org
From: Bob Peterson <bob@acdstar.com>
In-Reply-To: <431F6CDC.7030908@aeroflex.com>
References: <431F6CDC.7030908@aeroflex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Cc: frank.beesley@aeroflex.com
Subject: Re: MPC5200 Linux Init Problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Frank,

I recommend you first try to boot using tftp to get your kernel and nfs to get
your root filesystem.  Once that boots, you can play with MTD to make sure
your flash chips have full addressability and all, and you can mount your
jffs partition manually and look at it from the client.

Also, it would be interesting to see what u-boot messages you receive at
power-on.  You may also want to do a printenv command in u-boot and
post what your u-boot settings are.

Regards,

Bob Peterson
Advanced Communication Design

At 05:42 PM 9/7/2005, Frank Beesley wrote:
>I am bringing up a custom board using the MPC5200 and based on the 
>Lite5200. We changed from SDR to 128MB of DDR SDRAM and the flash 
>interface is now a 32MB, 32-bit wide bus using 2 Strata flash parts. 
>I have u-boot-1.1.3 up and running just fine. I have three 
>partitions on the flash: 0-uboot, 1-kernel image, 2-jffs file 
>system. The linux kernel (DENX based 2.4.25) starts with all the 
>normal messages plus some that I added for debugging. It should then 
>start running /sbin/init (busybox-1.00, dynamically linked)  but 
>instead I get the following Oops:
>
>VFS: Mounted root (jffs filesystem) 
>readonly.
>Freeing unused kernel memory: 60k 
>init
>init 
>filename=/sbin/init
>Oops: kernel access of bad area, sig: 
>11
>NIP: C0011030 XER: 00000000 LR: C00112AC SP: C03BBEB0 REGS: c03bbe00 
>TRAP: 0300d
>MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 
>11
>DAR: 80820000, DSISR: 
>20000000
>TASK = c03ba000[1] '    nit' Last syscall: 
>11
>last math 00000000 last altivec 
>00000000
>GPR00: 80820000 C03BBEB0 C03BA000 C01780A0 00001032 0000000B 
>C0160BA4 00000000 GPR08: 0000001B 80820000 C0160968 C013D954 
>00000000 00000000 00000000 00000000 GPR16: 00000000 00000000 
>00000000 00000000 C0170000 C0190000 C0160000 C0160000 GPR24: 
>C000E8CC 00000000 00000000 00000000 C03BA000 C016F920 00000000 
>C03BBEB0 Call 
>backtrace:
>00000000 C0005D04 
>00000000
>Kernel panic: Attempted to kill 
>init!
><0>Rebooting in 180 seconds..
>
>
>When I change busybox to statically linked I get the following 
>(notice some of my debug messages from within busybox showing up now):
>VFS: Mounted root (jffs filesystem) 
>readonly.
>Freeing unused kernel memory: 60k 
>init
>init 
>filename=/sbin/init
>init started:  BusyBox v1.00 (2005.09.07-14:56+0000) multi-call 
>binary
>Machine check in kernel 
>mode.
>Caused by (from SRR1=41030): Transfer error ack 
>signal
>Oops: machine check, sig: 
>7
>NIP: C0010FD0 XER: 00000000 LR: C0010F34 SP: C03BBE40 REGS: c03bbd90 
>TRAP: 0200d
>MSR: 00041030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 
>11
>TASK = c03ba000[1] '    nit' Last syscall: 
>162
>last math 00000000 last altivec 
>00000000
>GPR00: 7C691B78 C03BBE40 C03BA000 C01790A0 00001032 00000000 
>C0160BA4 00000000 GPR08: 00000017 4BFFFFAC C001BF1C 80620464 
>100823E4 1010D01C 00000000 00000000 GPR16: 00000000 00000000 
>00000000 00000000 C0170000 C0190000 C0160000 C0160000 GPR24: 
>C0005A40 00000001 100D3E28 C0180000 C7E38000 C016F920 00000000 
>C03BBE40 Call 
>backtrace:
>C000EA78 C0010E3C C001C0EC C0005A9C 10082408 10027000 
>10000960
>10000338 10051284 
>00000000
>Kernel panic: Attempted to kill 
>init!
><0>Rebooting in 180 seconds..
>
>
>1) Why am i getting machine check message - also see the task name 
>is messed up.
>
>2) Why are dynamic linking not working, is this a problem with my 
>library loader.
>
>3) Why is my init failing to load. this is the same binary and 
>config files that was used on a Lite5200 and worked fine.
>
>Any clues to help debug this would be greatly appreciated. I have 
>built several different kernel and busybox images with different 
>debug prints to help figure this out and I am at a loss. Please CC 
>me as I am not on the mailing list OR directly email me and we can 
>post the solution back to the list.
>
>Thanks
>Frank
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
