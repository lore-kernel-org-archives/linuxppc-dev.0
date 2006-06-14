Return-Path: <titof3000@hotmail.com>
Received: from hotmail.com (bay109-f30.bay109.hotmail.com [64.4.19.40])
	by ozlabs.org (Postfix) with ESMTP id 61CCD67A79
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 21:44:01 +1000 (EST)
Message-ID: <BAY109-F30823DA7AB0F9132888482AC8D0@phx.gbl>
In-Reply-To: <1149827915.12687.55.camel@localhost.localdomain>
From: "Christophe Simon" <titof3000@hotmail.com>
To: benh@kernel.crashing.org
Subject: Re: Linux kernel 2.6 on IBM RS/6000 7025-F40
Date: Wed, 14 Jun 2006 11:43:55 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Sorry, I was long. I tried to boot my 7025-F40 with this kernel 
http://www.solinno.co.uk/7043-140/files/2.6.9-rc2/ (the novga version) but 
the I have a kernel panic while booting. Here's what is printed out on my 
terminal :

********************************************************************
loaded at:     01000400 0116BF4C
relocated to:  00800000 0096BB4C
zimage at:     00805A30 009623BC
avail ram:     00400000 00800000

Linux/PPC load: console=tty0 console=ttyS0 root=/dev/sda3
Uncompressing Linux...done.
Now booting the kernel
Total memory = 384MB; using 1024kB for hash table (at c0400000)
Linux version 2.6.9-rc2 (leigh@george) (gcc version 3.3.2) #5 Wed Sep 15 
14:43:1
9 BST 2004
PReP architecture
IBM planar ID: ff
MPIC at 0xdffc0000 (0x1ffc0000), length 0x00040000 mapped to 0xeffbf000
Built 1 zonelists
Kernel command line: console=tty0 console=ttyS0 root=/dev/sda3
OpenPIC Version 1.0 (4 CPUs and 16 IRQ sources) at effbf000
OpenPIC timer frequency is 4.166666 MHz
PID hash table entries: 2048 (order: 11, 32768 bytes)
time_init: decrementer frequency = 16.662524 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 385024k available (2240k kernel code, 1004k data, 164k init, 0k 
highmem)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
NET: Registered protocol family 16
PCI: Probing PCI hardware
Machine check in kernel mode.
Caused by (from SRR1=c9030): Unknown values in msr
Oops: machine check, sig: 7 [#1]
NIP: C001AA28 LR: C02F8734 SP: C03F1F70 REGS: c03f1ec0 TRAP: 0200    Not 
tainted
MSR: 000c9030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c082dba0[1] 'swapper' THREAD: c03f0000Last syscall: 120
GPR00: C02F8720 C03F1F70 C082DBA0 C0252DF8 C0252D7C C0330000 C0340000 
448FE150
GPR08: C0330000 C0330000 00000005 80800864 24000028 00000000 00000000 
00000000
GPR16: 00000000 00000000 00000000 00000000 A5040113 00000000 00000000 
00000000
GPR24: 00000000 00C1AA00 40000000 2F646576 00000000 C0330000 00000001 
00000000
Call trace: [c02f378c]  [c02ee690]  [c0003b8c]  [c000a96c]
Kernel panic - not syncing: Attempted to kill init!
<0>Rebooting in 180 seconds..
********************************************************************

After that I tried with a stock 2.6.16.19 kernel thinking that perhaps this 
machine was integrated, but noting appears on the terminal (not even the 
"Linux/PPC load:" statement...) and the server reboots, and reboots again...

Is it from any help ?

Is there something to do to have a working 2.6 kernel on an 7025-F40 ?

Thanks a lot

Christophe SIMON




>From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>To: Christophe Simon <titof3000@hotmail.com>
>CC: linuxppc-dev@ozlabs.org
>Subject: Re: Linux kernel 2.6 on IBM RS/6000 7025-F40
>Date: Fri, 09 Jun 2006 14:38:35 +1000
>
>On Wed, 2006-06-07 at 15:30 +0000, Christophe Simon wrote:
> > Hi there,
> >
> > Did someone succeeded in compiling a running 2.6 kernel on an IBM 
>RS/6000
> > 7025-F40 (PReP arch) ? I have one of these machines, and it runs with a
> > 2.4.22 kernel built using the instructions gathered on
> > http://www.solinno.co.uk/7043-140/
> >
> > It seems that this machine is quite problematic.
> >
> > I tried to compile my own kernel with a stock 2.6.16.19, and after that
> > 2.6.7 patched with the files I found for the 2.6.7 (at
> > http://www.solinno.co.uk/7043-140/files/2.6.7/), but the system refuses 
>to
> > boot with those twoo kernels  (the machine reboots or freezes before 
>writing
> > any piece of information on the console...).
> >
> > The site seems not to move anymore, and I'd like to have a 2.6 kernel
> > running because of his better performances ans extended functionalities, 
>and
> > I'd like not to be stalled on 2.4.22 kernel...
> >
> > I crawled the web hours and hours (Google is my friend, but it didn't 
>help
> > me...) and I didn't find anything...
>
>I've successfully booted a 43p, I don't know about F40 though. What is
>the last message on the console when you try to boot the kernel ?
>
>Ben.
>
>

_________________________________________________________________
MSN Hotmail sur i-mode™ : envoyez et recevez des e-mails depuis votre 
téléphone portable ! http://www.msn.fr/hotmailimode/
