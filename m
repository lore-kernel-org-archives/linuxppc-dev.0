From: "Calum Selkirk" <cselkirk@xs4all.nl>
Date: Sat, 26 Jul 2003 16:39:45 +0200
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: firewire in 2.4.21-ben2
Message-ID: <20030726143945.GJ24614@xs4all.nl>
Reply-To: Calum Selkirk <cselkirk@xs4all.nl>
References: <Pine.LNX.4.56.0307141313050.1861@daronin.digimerc.com> <1058261452.628.36.camel@gaston> <20030717101149.GA2393@xs4all.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="QKdGvSO+nmPlgiQ/"
In-Reply-To: <20030717101149.GA2393@xs4all.nl>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Calum Selkirk [cselkirk@xs4all.nl] [2003-07-17 12:11 +0200]:

> * Benjamin Herrenschmidt [benh@kernel.crashing.org] [2003-07-15 11:30 +0200]:
>
> [snip]
> > >   After I reboot back in 2.4.20-ben10 everything works fine...
> >
> > That's a change in the firewire layer, you have to trigger a scsi
> > probe yourself now. Either using the rescan-scsi-bus.sh script, or the
> > scsiadd command for example
>
> just FYI, I have had the kernel oops on one occasion when rescaning the
> scsi bus this way (with a 2.4.21-ben2). Sorry, wasn't able to get a
> backtrace, though I will attempt to if it happens again.

OK .. attatched is a backtrace (hopefully accuratly transcribed) and
snippit from /var/log/messages.

As i said previously I haven't been able to reproduce this, it's only
happened to me on one occassion (the above backtrace is from another
user/machine). Might this be related to the other ieee1394 bug, where
unloading ohci1394 after sleep will oops?

best

cal

--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=kernel-oops

scsi singledevice 0 0 1 0
scsi singledevice 0 0 2 0
scsi singledevice 0 0 3 0
scsi singledevice 0 0 4 0
scsi singledevice 0 0 5 0
scsi singledevice 0 0 6 0
scsi singledevice 0 0 7 0
scsi singledevice 0 0 0 0
blk: queue cf131c14, I/O limit 4095Mb (mask 0xffffffff)
Machine check in kernel mode.
Caused by (from SRR1=41030): Transfer error ack signal
Oops: machine check, sig: 7
NIP: D2025104 XER: 20000000 LR: D20250D0 SP: CB499AE0 REGS: cb499a30 TRAP: 0200    Not tainted
MSR: 00041030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = cb498000[2407] 'rescan-scsi-bus' Last syscall: 4
last math cb498000 last altivec 00000000
GPR00: FFFFFFFF CB499AE0 CB498000 CFDB3BD4 CFDB3D10 CF8B40C0 00000008 D202C000
GPR08: CFDB3D3C 0000001F 00000180 D202C180 00000008 100D6E90 100D0000 00000000
GPR16: 00000000 00000001 00000000 00000001 00009032 CB499EA4 C0230940 CF131C34
GPR24: CF131C14 00000000 00000003 00000001 00000000 CFDB3BD4 CFDB3D44 CFDB3D10
Call backtrace:
D2025214 D2318F04 D202FF90 D20300B0 D20306FC D230266C D230A61C
D2309AC8 D2309B58 D2302968 D230288C D230CA38 D230C7A0 D23035D8
C005F894 C003BA1C C0005D3C 4822282C 0FEF8CCC 0FEF8C50 0FEF9794
0FEFAF34 0FEF5528 10061734 100294F4 10027C98 10027524 10024514
10025374 100247DC 10025320 100247DC 10025320
ieee1394: sbp2: aborting sbp2 command
Inquiry 00 00 00 ff 00
Machine check in kernel mode.
Caused by (from SRR1=41030): Transfer error ack signal
Oops: machine check, sig: 7
NIP: D2025104 XER: 00000000 LR: D20250D0 SP: CB559EC0 REGS: cb559e10 TRAP: 0200    Not tainted
MSR: 00041030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = cb558000[2008] 'scsi_eh_0' Last syscall: -1
last math 00000000 last altivec 00000000
GPR00: FFFFFFFF CB559EC0 CB558000 CFDB3BD4 CFDB3D10 CF8B411C 00000000 D202C000
GPR08: CF8B40C8 0000001E 00000180 D202C180 84224428 1001FFB8 0FFED250 00000000
GPR16: 00000001 00000003 10030000 10030000 00009032 0B53FF40 00000000 CB53FEA8
GPR24: CB558000 D2310000 00000002 00000002 00000000 CFDB3BD4 CFDB3D44 CFDB3D10
Call backtrace:
D2025214 D2318F04 D202FA44 D2030A5C D23079BC D2308674 D2308894
C0008748

--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=backtrace-rescan-scsi

100258d0
10024704
100258d0
10024704
100258d0
10024704
10024874
100299f0
10027db8
10027524
10024514
100258d0
10024704
10028ac0
1001660c
100141b4
0fea0d44
00000000
mon>
d23035d8
c005f894
c003ba1c
exception:c00 [cb499f50] ff5641c
0fef8ccc
0fef8c50
0fef9794
0fefaf34
0fef5528
10061734
100294f4
10027c98
10027524
10024514
10025374
100247dc
10025320
100247dc
10025320
100247dc
10025320
100247dc
10026a0c
1002478c
10025374
100247dc
10025320
100247dc

--QKdGvSO+nmPlgiQ/--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
