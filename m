Message-Id: <v03110700b39bed3e38b4@[209.183.130.98]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 27 Jun 1999 11:08:06 -0400
To: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org,
        "Conrad M. Hirano" <placebo2@pobox.com>
From: "Kevin B. Hendricks" <kbhend@business.wm.edu>
Subject: Re: Machine Check in Kernel Mode with Paul's 2.2.10 on B+W G3,
 workaround
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

>>  hda: hda timeout waiting for DMA

>>Machine check in kernel mode
>>Caused by (from msr): regs c01a4c18 Unknown values in msr

>>Here are some register values:
>>   NIP: C00BDE58  LR: C00BDE14  MSR: 00009030  Trap: 0200
>>Task= c01a2f58[0] 'swapper' mm->pgd
>>Last syscall: 112

>>Backtrace: C00BDE14 COO13C04 C001C850 C0003B68 C001F460 C00069F4 ...

>>There does not seem to be anything unusual until the DMA timeout message
>>waiting for hda.

>From reading the comp.os.linux newsgroups, I found some more information
about this problem and a workaround that may help some people.

First the workaround:

In BootX in the extra kernel arguments field put the following:

hda=none hdb=none


That stops the kernel from doing the partion check on the hda device (from
seeing the device at all?) and thus the timeout error.

As for why this is happening:

- it seems some newer IBM drives BIOS says the drive is capable of UDMA
(ultra DMA) which seems to be messing things up somewhat for both x86 and
ppc recent kernels.  One post attributed the bug to insuffiecient memory
being available for the DMA buffers in the kernel that results in a kernel
stack overflow (this is the error message you get with the Yellowdog 2.2.6
and blue/g3 kernels).

So the problem occurs with later kernels and newer Maxtor and IBM drives
which say they support UDMA.

I will keep digging.

Thanks,

Kevin





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
