Message-ID: <3B532E16.A26A9BA9@mvista.com>
Date: Mon, 16 Jul 2001 11:10:31 -0700
From: Cal Erickson <cal_erickson@mvista.com>
Reply-To: cal_erickson@mvista.com
MIME-Version: 1.0
To: Adam Wozniak <adam.wozniak@comdev.cc>
Cc: Dan Malek <dan@mvista.com>,
	James F Dougherty <jfd@GigabitNetworks.COM>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: mmu problems
References: <3B4F412F.99A14D9E@comdev.cc> <3B4F5BE9.6258498B@mvista.com> <3B530F09.E93C0B8D@comdev.cc> <3B531CC8.8212165C@comdev.cc>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Adam,
Here is one method to use to get C code interspersed with assembly.
'-Wa,'-ahls=test.lst''   THe file test.lst is the file which will have the
assembly and the c source in it. It also helps to have -g as an option
on the compiler line as well. Remember to use the single quotes as
this tells the compiler to ass this through to the assembler phase.

Cal

Adam Wozniak wrote:

> Adam Wozniak wrote:
> >
> > I'll try today to get more (and better) error dumps from it.
>
> Here are two more dumps.  Both were created (separate runs)
> by doing several (between 4 and 10)
> ls -laR &
> from a shell prompt.
>
> Is there any way I can get gcc to annotate the assembly listing with the
> C source
> code?  I feel it would help pinpoint what is going on...
>
> ====
> (note: the "closest to" lines were produced by a perl script which pulls
> stuff from the System.map file.  "plus 96 of 760" means the given
> address
> is 96 bytes higher than the start of the function, and the next function
> is 760 higher than the start of the function)
> ====
>
> Oops: kernel access of bad area, sig: 11
> NIP: C000FA60 XER: 00000000 LR: 00000000 SP: C3E97DE0 REGS: c3e97d30
> TRAP: 0300
> MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: 00000000, DSISR: 20000000
> TASK = c3e96000[18] 'sh' Last syscall: 2
> last math c3e96000 last altivec 00000000
> GPR00: 00000000 C3E97DE0 C3E96000 00000000 C33FE000 00000000 C3400540
> 00000000
> GPR08: 00000000 C3400040 C3400000 00000001 24448880 1004BE90 03FDE000
> 007FFF00
> GPR16: 00000000 007FFF00 007FFEB0 03FD71A8 00009032 03E97E80 00000000
> C3E97E90
> GPR24: 7FFFFD60 C3E97E18 FFFFFFF4 C33FE000 C368C160 00000000 C33FE000
> C3D932A0
> Call backtrace:
> C368C320 C00105FC C0006A4C C0003B5C 00000002 1001B6BC 1001BC20
> 10027B64 100277E0 0FEDC068 00000000
>
> closest to c000fa60 :: c000fa00 t copy_mm                (plus 96 of
> 760)
> closest to c368c320 :: NOT FOUND
> closest to c00105fc :: c00100f8 T do_fork                (plus 1284 of
> 1952)
> closest to c0006a4c :: c0006a2c T sys_fork               (plus 32 of 48)
> closest to c0003b5c :: c0003b5c T ret_from_syscall_1     (plus 0 of 180)
>
> Machine check in kernel mode.
> Caused by (from SRR1=41000): Transfer error ack signal
> Oops: machine check, sig: 7
> NIP: 00000908 XER: 00000000 LR: C000CF9C SP: C3E81BF0 REGS: c3e81b40
> TRAP: 0200
> MSR: 00041000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
> TASK = c3e80000[19] 'ls' Last syscall: 3
> last math c3442000 last altivec 00000000
> GPR00: 7D665B78 C3E81BF0 C3E80000 C33FF800 00000080 00000081 C33FF000
> 00000001
> GPR08: 00000000 000000C8 C027B060 8299A487 44444824 1004BE90 03FDE000
> 007FFF00
> GPR16: 00000000 007FFF00 007FFEB0 C0023424 00009032 03E81D20 00000000
> C0003DC4
> GPR24: C000BE90 02000000 00030002 C3E74064 C3E74064 C3681CE0 C36831A0
> C0247FE4
> Call backtrace:
> C3681CE0 C001F714 C001F7F0 C001F99C C000C020 C0003DC4 C350DCC0
> C0023068 C0023520 C0031FC0 C0003B5C 0FF31FD0 0FF307F0 0FF32040
> 0FF31EB4 0FF26DF0 0FF26C48 0FF2FDD0 0FE8E6D8 0FE8EB00 0FF6553C
> 0FF64EF4 10029794 10012B64 10012648 10012718 10012764 10012764
> 10012764 100133C8 10027B64 100277E0 0FEDC068
>
> closest to c001f714 :: c001f674 t do_anonymous_page     (plus 160 of
> 296)
> closest to c001f7f0 :: c001f79c t do_no_page     (plus 84 of 396)
> closest to c001f99c :: c001f928 T handle_mm_fault     (plus 116 of 300)
> closest to c000c020 :: c000be90 T do_page_fault     (plus 400 of 904)
> closest to c0003dc4 :: c0003dc4 T ret_from_except     (plus 0 of 40)
> closest to c350dcc0 :: NOT FOUND
> closest to c0023068 :: c0022e14 T do_generic_file_read     (plus 596 of
> 1552)
> closest to c0023520 :: c00234b8 T generic_file_read     (plus 104 of
> 160)
> closest to c0031fc0 :: c0031ef8 T sys_read     (plus 200 of 276)
> closest to c0003b5c :: c0003b5c T ret_from_syscall_1     (plus 0 of 180)
>
> --
> Adam Wozniak (KG6GZR)   COM DEV Wireless - Digital and Software Systems
> awozniak@comdev.cc      3450 Broad St. 107, San Luis Obispo, CA 93401
>                        http://www.comdev.cc
>                         Voice: (805) 544-1089       Fax: (805) 544-2055
>

--
===========================================================================
Cal Erickson                 MontaVista Software Inc.
Linux Consultant             1237 E. Arques Ave.
Phone (408) 328-0304         Sunnyvale CA 94085
Fax   (408) 328-9204         web http://www.mvista.com
eCode: http://cal@work.com.ecode.com
===========================================================================

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
