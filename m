Message-ID: <2F67A63DFFB1D31185D90090278CBB2D014ECF08@apmail6.chn.agilent.com>
From: "ZHANG,HAI-TAO (Non-A-China,ex1)" <hai-tao_zhang@non.agilent.com>
To: Alex Shnitman <alexsh@hectic.net>, linuxppc-embedded@lists.linuxppc.org
Subject: RE: Sandpoint & random crashes?
Date: Mon, 11 Sep 2000 09:32:00 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I met the same problem while using the 2.4 kernel from MontaVista Area51.
The kernel just crashes when executing init.

Here is the oops:
NIP: 00000300 XER: 20000000 LR: C004DD7C REGS: c01fda80 TRAP: 0700
MSR: 00081000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK = c01fc000[1] 'init' Last syscall: 11
last math 00000000 last altivec 00000000
GPR00: 00000000 C01FDB30 C01FC000 00000000 00000CD8 00000000 30026324
00000000
GPR08: C0100000 C00D0000 C00F0000 C01FDA70 24848024 00000000 10017218
10016F10
GPR16: 10000000 C01FDC4C 00000060 00000001 C1FC1640 00000003 C1FBC160
300268F4
GPR24: 30000000 30026328 000236E0 C01FDBD8 00000812 30023000 30026328
00000CD8
Call backtrace:
C004DD40 C004E3F0 C004EC84 C003F4B0 C003F720 C0006B88 C0004880
C0003974 C0008FE0
Kernel panic: Exception in kernel pc 300 signal 4

And I use the ksymoops to see where it crashes:
>>NIP; 00000300 Before first symbol   <=====
Trace; c004dd40 <padzero+3c/a0>
Trace; c004e3f0 <load_elf_interp+29c/2f4>
Trace; c004ec84 <load_elf_binary+6e8/950>
Trace; c003f4b0 <search_binary_handler+5c/160>
Trace; c003f720 <do_execve+16c/1fc>
Trace; c0006b88 <sys_execve+5c/dc>
Trace; c0004880 <ret_from_syscall_1+0/a0>
Trace; c0003974 <init+18/1a8>
Trace; c0008fe0 <kernel_thread+2c/38>

It is in the fs/binfmt_elf.c:
static void padzero(unsigned long elf_bss)
{
	unsigned long nbyte;

	nbyte = ELF_PAGEOFFSET(elf_bss);
	if (nbyte) {  <----------------- the kernel crashes here with
instruction "cmpwi r31,0"
		nbyte = ELF_EXEC_PAGESIZE - nbyte;
		clear_user((void *) elf_bss, nbyte);
	}
}

But I cannot figure out what is wrong with that line.

Any suggestios?

Thanks,
Haitao Zhang



> -----Original Message-----
> From: Alex Shnitman [mailto:alexsh@hectic.net]
> Sent: Monday, September 11, 2000 3:50 AM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Sandpoint & random crashes?
>
>
>
> Hi,
>
> I can't seem to find the problem with the init not working on the
> Sandpoint. Here are some more details.
>
> In a nutshell, when the kernel gets to the point of running init, it
> gets stuck. The console works, and it responds to pings, but it
> doesn't proceed running init. Usually.
>
> Once, it did run init for me (that actually was sash). I didn't do
> anything different that time so I don't know how that happened. In any
> case, it crashed after a minute of work, when I did the following:
>
> bash-2.03# cat tty/driver
> NIP: C0032854 XER: 20000000 LR: C00327E0 REGS: c1e23d60 TRAP: 0600
> MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = c1e22000[41] 'cat' Last syscall: 5
> last math c1e22000 last altivec 00000000
> GPR00: BD3D2722 C1E23E10 C1E22000 C013D760 00000000 00000000
> C013D7BC 0C44D0B7
> GPR08: C0140000 BD3D2712 00000000 00000000 84262422 0184A4DC
> 00000000 00000000
> GPR16: 00000001 7FFFFE54 7FFFFD30 00000002 00009032 01E23E80
> 00000000 C0004F1C
> GPR24: C0004C6C 00000000 00001000 FFFFFFE9 C1E69B80 C02EBDE0
> C1DFE400 C013D760
> Call backtrace:
> C00327E0 C00327AC C0032BB8 C0004CC0 01800724 018014AC 0170C75C
> 00000000
> Kernel panic: kernel access of bad area pc c0032854 lr
> c00327e0 address BD3D2721
> Rebooting in 180 seconds..
>
> Another time, it died right after (or during) mounting the
> NFS filesystem:
>
> NIP: C005F72C XER: 20000000 LR: C00CA164 REGS: c02e3d00 TRAP: 0300
> MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = c02e2000[5] 'rpciod' Last syscall: 36
> last math 00000000 last altivec 00000000
> GPR00: C00CA164 C02E3DB0 C02E2000 00000001 C02F7A6C C0136F48
> C01141C0 00000000
> GPR08: 00000000 00000000 C0177320 00000000 0D860800 00000000
> 00000000 00000000
> GPR16: C02E81C0 C02E814C 00000000 00000000 C02F7A68 C0100000
> C0140000 C01023E0
> GPR24: C0100000 C01145F0 C0110000 C0110000 C02E814C C005F6E0
> C0136F48 00000000
> Call backtrace:
> C02E3E60 C00CA164 C00CD87C C00CDE88 C00CE96C C00094FC
> Kernel panic: kernel access of bad area pc c005f72c lr
> c00ca164 address 20 tsk 5
> Rebooting in 180 seconds..
>
> I think there were a few more crashes like this, during different
> stages of trying to run init.. Usually in different places, but always
> with the message "kernel access of bad area". I don't have the
> backtraces here, but they were prefectly normal, and since crashes
> always happened to me at different places, I suppose it's not very
> important.
>
> What does this "bad area" thing mean? How do we get rid of it?
>
>
> --
> Alex Shnitman                            | http://www.debian.org
> alexsh@hectic.net, alexsh@linux.org.il   +-----------------------
> http://alexsh.hectic.net    UIN 188956    PGP key on web page
>        E1 F2 7B 6C A0 31 80 28  63 B8 02 BA 65 C7 8B BA
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
