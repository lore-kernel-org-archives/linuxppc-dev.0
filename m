Date: Tue, 4 Jul 2000 10:30:26 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Michel Lanners <mlan@cpu.lu>
cc: k_fukui@highway.ne.jp, linuxppc-dev@lists.linuxppc.org
Subject: Re: still CMD646 IDE problem in kernel-2.4.0-test3
In-Reply-To: <200007040557.HAA00792@piglet.grunz.lu>
Message-ID: <Pine.HPX.4.10.10007041025290.21326-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 4 Jul 2000, Michel Lanners wrote:

>
> Hi all,
>
> On   4 Jul, this message from Kaoru Fukui echoed through cyberspace:
> > I have the problem in kernel-2.4.0-test3.
> > My machine is BWG3Version2.
> > it has fast ide drive which is CDD646.
> > It doesnot work still on develop kernel.
>
> I'm having similar problems with my Promise U/66 IDE card. Panics the
> same way right when accessing the partitions.
>
> > Partition check:
> >  hda:Machine check in kernel mode.
> > Caused by (from SRR1=41030): Transfer erre ack signal
> > NIP: C00D5AF4 XER: 00000000 LR:C00D5A94 REGS: c022fd60 TRAP: 0200
>        ^^^^^^^^                  ^^^^^^^^
> Could you have a look at your System.map and tell us in what function
> these adresses are? For me it panics in the interrupt handler.
>
> > MSR: 00041030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
> > TASK = c022e030[0] 'swapper' Last syscall: 120
> > last math 00000000 last altivec 00000000
> > GPR00: 000000FF C022FE10 C022E030 00000000 00001032 00000000 00000000 00000000
> > GPR08: C02DB1AC FE000000 FE000000 C0250000 00000001 003030AC 00000000 00000000
> > GPR16: 00000000 C02B0000 C02B0000 C02C0000 C0230000 C02BA694 C02BA690 C00050EB
> > GPR24: C0006644 C022D3E0 C022D3E0 C022D3E0 C02DB1AC C03E5260 C00E0CC4 C02DB214
>
> Are you sure this is the complete panic message? There should be a few
> more lines after this one, with a backtrace and a few more details on
> what happened...
>
> What I hate the most about this panic is that it should indicate a
> hardware problem, according to the PPC docs. 'Transfer error ack' should
> be raised by the memory controller on parity errors and the such. I
> wonder how this signal is actually wired in macs.....

It can also be caused by an error on the PCI bus when you access an
address where no device answers (which results in no DEVSEL signal being
asserted). This becomes a master abort in PCI terminology, many bridges
have a control bit to tell whether this should be translated to an error
on the CPU bus (maachine check) or simply ignored.

There are other kinds of PCI errors which can produce the same result
(Target abort/Parity error) but the master abort is by far the most
frequent in my experience.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
