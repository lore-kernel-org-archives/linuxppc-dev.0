Message-Id: <v03130300b3f1774818a8@[192.168.1.1]>
In-Reply-To: <37CB8D07.FE7D3D62@wanadoo.fr>
References: <v03130301b3f116a864e2@[192.168.1.1]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 31 Aug 1999 07:16:34 -0500
To: Martin Costabel <costabel@wanadoo.fr>
From: "David D. Kilzer" <ddkilzer@computer.org>
Subject: Re: SMP support for Daystar 604e 200MHz dual-processor card
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Martin Costabel wrote:

>I'd look into your serial driver config options. There are some that
>don't work on the PPC.

Hmm...okay, thanks.  I didn't look real closely when I made that.

>And if you run the oops message through ksymoops (to be found in
>/usr/src/linux/scripts/ksymoops/), you get more meaningful addresses.


% ./scripts/ksymoops/ksymoops -K -L -O -v vmlinux-2.2.12-19990829-1 -m System.map-2.2.12-19990829-1 < OOPS-2.2.12-19990829-1.txt 
WARNING: This version of ksymoops is obsolete.
WARNING: The current version can be obtained from ftp://ftp.ocs.com.au/pub/ksymoops
Options used: -v vmlinux-2.2.12-19990829-1 (specified)
              -O (specified)
              -K (specified)
              -L (specified)
              -m System.map-2.2.12-19990829-1 (specified)
              -c 1 (default)

NIP: C00E8818 XER: 00000000 LR: C00E87C0 REGS: c01fbcf0 TRAP: 0200
MSR: 00001030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c01fa000[1] 'swapper' mm->pgd c015b000 Last syscall: 120
last math 00000000 CPU: 0 last CPU: 255
GPR00: 000000FF C01FBDA0 C01FA000 000000FF C01A1068 C01A1068 00000020 C1080000
GPR08: FFFFFFFF 000003F9 F2000000 F2000000 C0180000 001EB0A4 C00E822C C00E79F4
GPR16: C00E704C C00E7B14 C00E496C C00E48FC C00E7660 C00E65AC C00E6680 C00E65E4
GPR24: C01BE77C 00000000 C0171EAC 00000000 00000000 00000001 C0171EAC C01FBDA8
Call backtrace:
C00E87C0 C018C9E8 C018BAF0 C018BB64 C018A028 C017C97C C00043C0
C000A274
Kernel panic: machine check
Warning, Code line not seen, dumping what data is available

>>NIP: c00e8818 <autoconfig+ac/490>
Trace: c00e87c0 <autoconfig+54/490>
Trace: c018c9e8 <rs_init+3a8/494>
Trace: c018baf0 <tty_init+1a4/1c8>
Trace: c018bb64 <chr_dev_init+50/6c>
Trace: c018a028 <device_setup+1c/198>
Trace: c017c97c <do_basic_setup+d8/1e4>
Trace: c00043c0 <init+3c/1f0>
Trace: c000a274 <kernel_thread+2c/38>


3 warnings issued.  Results may not be reliable.


I'll try the cold boot trick first to see if I can 'unstick' processor 1,
and rerun 'make config' to look at the serial options more closely.

Also, I tried the borg.mit.edu 2.2.10 multiprocessor kernel with no luck.
It just stopped after "booting..." on the inital screen.

Dave


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
