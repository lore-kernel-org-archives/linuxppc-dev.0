Message-ID: <39BD4215.6FD9B56F@mvista.com>
Date: Mon, 11 Sep 2000 13:35:33 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: "ZHANG,HAI-TAO (Non-A-China,ex1)" <hai-tao_zhang@non.agilent.com>
CC: Alex Shnitman <alexsh@hectic.net>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Sandpoint & random crashes?
References: <2F67A63DFFB1D31185D90090278CBB2D014ECF08@apmail6.chn.agilent.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Guys, I'm trying to recreate what you're seeing but I can't.  Definitely seems
like something is amiss.  The NIP: 00000300 one is definitely interesting.

I'm on an 8240 and i can't make it crash.  Correct me if I'm wrong, Alex
you're using a 7400 with a 107; Hai-Tao (is that correct?) you're using a 750
with a 107, right??  Any other info on your systems/processor boards that may
be useful for me to know?

It sounds like this is happening during boot up.  Is that correct?  If you get
up, what sequence of cmds cause it to fail?  I need help recreating it here.

You're both using the toolchain and root filesystem from the MontaVista 1.2
CDK, right?  I use the root filesystem in
/opt/hardhat/devkit/ppc/82xx/target.  What are you using?

I boot fine over NFS and with the above root filesystem on an IDE drive.  Are
both of you using NFS?  If so, make sure that you have the "IP: BOOTP support"
selected under the "Networking options" menu item and the "Root file system on
NFS" on under "File systems/Network File Systems" menu item.


Thanks,

Mark
--


"ZHANG,HAI-TAO (Non-A-China,ex1)" wrote:

> Hi,
>
> I met the same problem while using the 2.4 kernel from MontaVista Area51.
> The kernel just crashes when executing init.
>
> Here is the oops:
> NIP: 00000300 XER: 20000000 LR: C004DD7C REGS: c01fda80 TRAP: 0700
> MSR: 00081000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
> TASK = c01fc000[1] 'init' Last syscall: 11
> last math 00000000 last altivec 00000000
> GPR00: 00000000 C01FDB30 C01FC000 00000000 00000CD8 00000000 30026324
> 00000000
> GPR08: C0100000 C00D0000 C00F0000 C01FDA70 24848024 00000000 10017218
> 10016F10
> GPR16: 10000000 C01FDC4C 00000060 00000001 C1FC1640 00000003 C1FBC160
> 300268F4
> GPR24: 30000000 30026328 000236E0 C01FDBD8 00000812 30023000 30026328
> 00000CD8
> Call backtrace:
> C004DD40 C004E3F0 C004EC84 C003F4B0 C003F720 C0006B88 C0004880
> C0003974 C0008FE0
> Kernel panic: Exception in kernel pc 300 signal 4
>
> And I use the ksymoops to see where it crashes:
> >>NIP; 00000300 Before first symbol   <=====
> Trace; c004dd40 <padzero+3c/a0>
> Trace; c004e3f0 <load_elf_interp+29c/2f4>
> Trace; c004ec84 <load_elf_binary+6e8/950>
> Trace; c003f4b0 <search_binary_handler+5c/160>
> Trace; c003f720 <do_execve+16c/1fc>
> Trace; c0006b88 <sys_execve+5c/dc>
> Trace; c0004880 <ret_from_syscall_1+0/a0>
> Trace; c0003974 <init+18/1a8>
> Trace; c0008fe0 <kernel_thread+2c/38>
>
> It is in the fs/binfmt_elf.c:
> static void padzero(unsigned long elf_bss)
> {
>         unsigned long nbyte;
>
>         nbyte = ELF_PAGEOFFSET(elf_bss);
>         if (nbyte) {  <----------------- the kernel crashes here with
> instruction "cmpwi r31,0"
>                 nbyte = ELF_EXEC_PAGESIZE - nbyte;
>                 clear_user((void *) elf_bss, nbyte);
>         }
> }
>
> But I cannot figure out what is wrong with that line.
>
> Any suggestios?
>
> Thanks,
> Haitao Zhang
>
> > -----Original Message-----
> > From: Alex Shnitman [mailto:alexsh@hectic.net]
> > Sent: Monday, September 11, 2000 3:50 AM
> > To: linuxppc-embedded@lists.linuxppc.org
> > Subject: Sandpoint & random crashes?
> >
> >
> >
> > Hi,
> >
> > I can't seem to find the problem with the init not working on the
> > Sandpoint. Here are some more details.
> >
> > In a nutshell, when the kernel gets to the point of running init, it
> > gets stuck. The console works, and it responds to pings, but it
> > doesn't proceed running init. Usually.
> >
> > Once, it did run init for me (that actually was sash). I didn't do
> > anything different that time so I don't know how that happened. In any
> > case, it crashed after a minute of work, when I did the following:
> >
> > bash-2.03# cat tty/driver
> > NIP: C0032854 XER: 20000000 LR: C00327E0 REGS: c1e23d60 TRAP: 0600
> > MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> > TASK = c1e22000[41] 'cat' Last syscall: 5
> > last math c1e22000 last altivec 00000000
> > GPR00: BD3D2722 C1E23E10 C1E22000 C013D760 00000000 00000000
> > C013D7BC 0C44D0B7
> > GPR08: C0140000 BD3D2712 00000000 00000000 84262422 0184A4DC
> > 00000000 00000000
> > GPR16: 00000001 7FFFFE54 7FFFFD30 00000002 00009032 01E23E80
> > 00000000 C0004F1C
> > GPR24: C0004C6C 00000000 00001000 FFFFFFE9 C1E69B80 C02EBDE0
> > C1DFE400 C013D760
> > Call backtrace:
> > C00327E0 C00327AC C0032BB8 C0004CC0 01800724 018014AC 0170C75C
> > 00000000
> > Kernel panic: kernel access of bad area pc c0032854 lr
> > c00327e0 address BD3D2721
> > Rebooting in 180 seconds..
> >
> > Another time, it died right after (or during) mounting the
> > NFS filesystem:
> >
> > NIP: C005F72C XER: 20000000 LR: C00CA164 REGS: c02e3d00 TRAP: 0300
> > MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> > TASK = c02e2000[5] 'rpciod' Last syscall: 36
> > last math 00000000 last altivec 00000000
> > GPR00: C00CA164 C02E3DB0 C02E2000 00000001 C02F7A6C C0136F48
> > C01141C0 00000000
> > GPR08: 00000000 00000000 C0177320 00000000 0D860800 00000000
> > 00000000 00000000
> > GPR16: C02E81C0 C02E814C 00000000 00000000 C02F7A68 C0100000
> > C0140000 C01023E0
> > GPR24: C0100000 C01145F0 C0110000 C0110000 C02E814C C005F6E0
> > C0136F48 00000000
> > Call backtrace:
> > C02E3E60 C00CA164 C00CD87C C00CDE88 C00CE96C C00094FC
> > Kernel panic: kernel access of bad area pc c005f72c lr
> > c00ca164 address 20 tsk 5
> > Rebooting in 180 seconds..
> >
> > I think there were a few more crashes like this, during different
> > stages of trying to run init.. Usually in different places, but always
> > with the message "kernel access of bad area". I don't have the
> > backtraces here, but they were prefectly normal, and since crashes
> > always happened to me at different places, I suppose it's not very
> > important.
> >
> > What does this "bad area" thing mean? How do we get rid of it?
> >
> >
> > --
> > Alex Shnitman                            | http://www.debian.org
> > alexsh@hectic.net, alexsh@linux.org.il   +-----------------------
> > http://alexsh.hectic.net    UIN 188956    PGP key on web page
> >        E1 F2 7B 6C A0 31 80 28  63 B8 02 BA 65 C7 8B BA
> >
>

--
Mark A. Greer (mgreer@mvista.com; 480-517-0287)
MontaVista Software, Inc.
2141 E. Broadway Road, Suite 108
Tempe, AZ  85282


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
