Message-ID: <000a01c18857$ae010800$1a11efcb@industrialDiv.hanasys.co.kr>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <BE684E2C997AD51199530002A56B207906623B@MCHH2A1E>
Subject: Re: MPC755 Porting Problem
Date: Wed, 19 Dec 2001 15:37:50 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you for response.

I solved the problem.
After the RFI, MMU begins to work.
I tried to access the phiscal address in serial_hello().
While the address is mapped to another area by BAT.

I think, It's something like the uncertainty theory.
We cannot watch a phenominan precisely, because the action of watching affects the phenominan.

Any way, I encountered another problem.
I'm porting linux on my MPC755 board.
It is the dump message of xmon after the kernel was crashed during initialization.

vector: 400 at pc = 20002024, lr = 20002024
msr = 40001032, sp = c0130320 [c0130270]
current = c012e420, pid = 0, comm = swapper
mon>

The point where it happens was  in __alloc_bootmem_core.
After the following function.
      memset(ret, 0, size);
where
      ret = 0xC01D9000
      size = 0x200040

Where can I start to debug this.

Thanks in advance.
- Sangmoon Kim -

----- Original Message -----
From: "Babic Stefano" <Stefano.Babic@icn.siemens.de>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, December 19, 2001 1:36 AM
Subject: AW: MPC755 Porting Problem


>
> Hi,
>
> we have already ported linux on our board based on MPC 755. The kernel is set at 0xc0000000, as you can see on arch/ppc/Makefile (KERNELLOAD=0xc0000000). We did not want to change it, because it is quite a standard value for external tools.
> We are using the boot loader in mbx directory (or mbxboot, depending on version you are using), so we are using really the head_8260.S file instead of head.S.
> From the sources of the loader it seems necessary to load the kernel in high memory range (physical address), in any case greater as 0x400000 (which address is not important). Then the loader remapped it to 0xc0000000.
> For us it is not a problem to load the kernel at a higher address and in this way the loader can correctly start the kernel.
>
> I hope it could be help.
>
> stefano babic
>
> -----Ursprungliche Nachricht-----
> Von: Sangmoon Kim [mailto:dogoil@etinsys.com]
> Gesendet: Samstag, 15. Dezember 2001 07:24
> An: linuxppc-embedded@lists.linuxppc.org
> Betreff: MPC755 Porting Problem
>
>
>
> Hi?
> I'm porting linux for a MPC755 board which I designed,
> and having some trouble with arch/ppc/kernel/head.S
> I load the kernel at phiscal address 0x00000000
> and head.S seams to relocate it to 0xc0000000
> The code is like this
>
>         mfmsr   r0 /* Inst and data addr translations are disabled */
>         ori     r0,r0,MSR_DR|MSR_IR /* enable Inst and data addr translation */
>         mtspr   SRR1,r0
>         lis     r0,start_here@h
>         ori     r0,r0,start_here@l
>         mtspr   SRR0,r0
>         SYNC
>         RFI /* jump to SRR0 */
>
> start_here:
>         /* Call setup_cpu for CPU 0 */
>         li      r3,0            /* data offset */
>         li      r24,0           /* cpu# */
>         bl      call_setup_cpu
>
> It is running at base address 0x00000000.
> start_here is at address 0xc000369c.
> And the IBAT0, and DBAT0 is C0001FFE-00000002.
> So after RFI it should go to start_here.
>
> But If I insert some code like 'bl serial_hello',
> which prints hello? to serial console after start_here.
> It never prints a message. It works before the RFI.
>
> Where can I start to debug it?
>
> serial_hello is like this.
>
> void
> serial_hello()
> {
>         serial_putc(SCC_A_ADDRESS,'h');
>         serial_putc(SCC_A_ADDRESS,'e');
>         serial_putc(SCC_A_ADDRESS,'l');
>         serial_putc(SCC_A_ADDRESS,'l');
>         serial_putc(SCC_A_ADDRESS,'o');
>         serial_putc(SCC_A_ADDRESS,'?');
>         serial_putc(SCC_A_ADDRESS,'\n');
>         serial_putc(SCC_A_ADDRESS,'\r');
> }
> Thanks in advance.
> - Sangmoon Kim -
>
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
