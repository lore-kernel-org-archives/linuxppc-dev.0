From: Ole.Reinartz@nokia.com
Message-ID: <A914533BF4B9D2118D980008C7894C0A014D54F0@dueis01nok>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Kernel Math Emulation again
Date: Fri, 3 Dec 1999 11:03:41 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


With soft-float your code generally gets bigger but potentially faster,
because in the case of soft-float the µP can execute the jump instr. to the
math- emulation routines out of line (or the compiler can even inline them).
In the case of kernel math emulation the µP has to handle an exception
everytime a fp- instr. is executed.
On the other hand with kernel math emulation you can potentially run any
pmac- compiled program on your mpc8xx without recompilation. You could even
run a pmac- netscape on it (anyone tried that yet?).
In general you should avoid doing heavy fp- calculation on a µP without HW
support for it. I once tried to run an mpeg3- player on an mpc860@50MHz
(compiled with -msoft-float) to decode a 1:30 song, but after 30 minutes I
ran out of patience... :-)

Ole

BTW: I put math-emu into kernel v.2.2.5 after Neil's hint (thank you Neil!)



> -----Original Message-----
> From: EXT Ralf HECKHAUSEN [mailto:RHeckhau@frequentis.com]
> Sent: Freitag, 3. Dezember 1999 9:46
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: Kernel Math Emulation again
> 
> 
> 
> Question: 
> Is there any significant difference in execution speed or 
> program size in either of the two solutions (compiling with 
> soft-float or using the kernel math emulation)?
> 
> Ralf
> 
> >>> Bill Roman <roman@alerton.com> 12/02 11:32 pm >>>
> 
> Neil Blackwood wrote:
> > 
> > There is some kernel maths emulation stuff in 2.3.18.
> > You will need to copy it over to which ever version you are 
> using. It works.
> > Look for directories math-emu.
> > You will need to change config files and make files as 
> well. Its fairly
> > easy. Even I managed it.
> 
> Thanks, Neil!  I had been very optimistic when I found this 
> code in 2.3.18, and
> was disappointed when it turned out it wouldn't compile in 
> that context.
> Without your hint, I don't think I would have guessed that 
> transplanting it
> into a 2.2 kernel would have worked.
> 
> To save everyone else a few hours of grepping and tweaking, here are
> instructions and a patch file to add math emulation to the 
> 2.2.13 kernel
> sources from linuxppc.cs.nmt.edu.
> 
> 1.  Obtain mpc8xx-2.2.13.tgz and linux-2.3.18.tgz from
> ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded/.  Untar them into two
> separate source trees.  (Note: all that's needed from 2.3.18 is the
> math emulator; does anyone know whether that's available separately,
> or could someone split it out and put it on the FTP site?)
> 
> 2.  Copy the arch/ppc/mathemu directory from the 2.3.18 tree to the
> 2.2.13 tree.
> 
> 3.  Apply the patch (below).  Note that I am building for an 
> MBX, so that's
> what .config gets patched for.
> 
> 4.  make symlinks config dep clean zImage.
> 
> The following is the patch.
> --------------------------------------------------------------
> --------------
> diff -ur linux-mpc8xx-2.2.13/.config linux/.config
> --- linux-mpc8xx-2.2.13/.config	Fri Oct 22 16:08:42 1999
> +++ linux/.config	Wed Dec  1 17:10:01 1999
> @@ -10,9 +10,9 @@
>  # CONFIG_PPC64 is not set
>  CONFIG_8xx=y
>  # CONFIG_MPC821 is not set
> -CONFIG_MPC823=y
> +# CONFIG_MPC823 is not set
>  # CONFIG_MPC850 is not set
> -# CONFIG_MPC860 is not set
> +CONFIG_MPC860=y
>  # CONFIG_MPC860T is not set
>  CONFIG_SERIAL_CONSOLE=y
>  # CONFIG_PMAC is not set
> @@ -20,12 +20,13 @@
>  # CONFIG_CHRP is not set
>  # CONFIG_ALL_PPC is not set
>  # CONFIG_APUS is not set
> -# CONFIG_MBX is not set
> +CONFIG_MBX=y
>  # CONFIG_RPXLITE is not set
>  # CONFIG_RPXCLASSIC is not set
> -CONFIG_BSEIP=y
> +# CONFIG_BSEIP is not set
>  # CONFIG_SMP is not set
>  CONFIG_MACH_SPECIFIC=y
> +CONFIG_MATH_EMULATION=y
>  
>  #
>  # General setup
> @@ -297,8 +298,7 @@
>  # MPC8xx CPM Options
>  #
>  CONFIG_SCC_ENET=y
> -# CONFIG_SCC1_ENET is not set
> -CONFIG_SCC2_ENET=y
> +CONFIG_SCC1_ENET=y
>  # CONFIG_FEC_ENET is not set
>  # CONFIG_CPM_IIC is not set
>  # CONFIG_UCODE_PATCH is not set
> diff -ur linux-mpc8xx-2.2.13/arch/ppc/Makefile linux/arch/ppc/Makefile
> --- linux-mpc8xx-2.2.13/arch/ppc/Makefile	Wed Oct 20 15:33:30 1999
> +++ linux/arch/ppc/Makefile	Wed Dec  1 16:16:45 1999
> @@ -41,6 +41,12 @@
>  ARCHIVES := arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o 
> arch/ppc/lib/lib.o $(ARCHIVES)
>  CORE_FILES := arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o 
> arch/ppc/lib/lib.o $(CORE_FILES)
>  
> +ifdef CONFIG_MATH_EMULATION
> +SUBDIRS += arch/ppc/math-emu
> +ARCHIVES += arch/ppc/math-emu/math-emu.o
> +CORE_FILES += arch/ppc/math-emu/math-emu.o
> +endif
> +
>  ifdef CONFIG_XMON
>  SUBDIRS += arch/ppc/xmon
>  CORE_FILES += arch/ppc/xmon/x.o
> diff -ur linux-mpc8xx-2.2.13/arch/ppc/config.in 
> linux/arch/ppc/config.in
> --- linux-mpc8xx-2.2.13/arch/ppc/config.in	Fri Oct 22 14:56:10 1999
> +++ linux/arch/ppc/config.in	Wed Dec  1 16:29:14 1999
> @@ -37,6 +37,15 @@
>  if [ "$CONFIG_ALL_PPC" != "y" ];then
>    define_bool CONFIG_MACH_SPECIFIC y
>  fi
> +
> +if [ "$CONFIG_8xx" = "y" ]; then
> +  bool 'Math emulation' CONFIG_MATH_EMULATION
> +else
> +  if [ "$CONFIG_PPC64" != "y" ];then
> +    define_bool CONFIG_6xx y
> +  fi
> +fi
> +
>  endmenu
>  
>  mainmenu_option next_comment
> diff -ur linux-mpc8xx-2.2.13/arch/ppc/kernel/Makefile 
> linux/arch/ppc/kernel/Makefile
> --- linux-mpc8xx-2.2.13/arch/ppc/kernel/Makefile	Fri Oct 
> 22 15:21:39 1999
> +++ linux/arch/ppc/kernel/Makefile	Thu Dec  2 10:34:19 1999
> @@ -30,7 +30,7 @@
>  endif
>  
>  ifeq ($(CONFIG_8xx),y)
> -O_OBJS += m8xx_setup.o softemu8xx.o ppc8xx_pic.o
> +O_OBJS += m8xx_setup.o  ppc8xx_pic.o
>  ifdef CONFIG_PCI
>  O_OBJS += qspan_pci.o
>  endif
> diff -ur linux-mpc8xx-2.2.13/arch/ppc/kernel/traps.c 
> linux/arch/ppc/kernel/traps.c
> --- linux-mpc8xx-2.2.13/arch/ppc/kernel/traps.c	Fri Oct 
> 22 14:04:09 1999
> +++ linux/arch/ppc/kernel/traps.c	Thu Dec  2 10:32:22 1999
> @@ -230,12 +230,12 @@
>  SoftwareEmulation(struct pt_regs *regs)
>  {
>  	int	errcode;
> -	extern int	Soft_emulate_8xx (struct pt_regs *regs);
> +	extern int	do_mathemu(struct pt_regs *regs);
>  	extern void print_8xx_pte(struct mm_struct *, unsigned long);	
>  
>  	if (user_mode(regs))
>  	{
> -		if ((errcode = Soft_emulate_8xx(regs))) {
> +		if ((errcode = do_mathemu(regs))) {
>  printk("Software Emulation %s/%d NIP: %lx *NIP: 0x%x code: %x",
>         current->comm,current->pid,
>         regs->nip, *((uint *)regs->nip), errcode);
> diff -ur linux-mpc8xx-2.2.13/include/asm-ppc/processor.h 
> linux/include/asm-ppc/processor.h
> --- linux-mpc8xx-2.2.13/include/asm-ppc/processor.h	Fri Oct 
> 22 16:10:02 1999
> +++ linux/include/asm-ppc/processor.h	Wed Dec  1 16:56:20 1999
> @@ -57,8 +57,33 @@
>  #define HID0_BTCD	(1<<1)		/* Branch target cache 
> disable */
>  
>  /* fpscr settings */
> -#define FPSCR_FX        (1<<31)
> -#define FPSCR_FEX       (1<<30)
> +#define FPSCR_FX        0x80000000      /* FPU exception summary */
> +#define FPSCR_FEX       0x40000000      /* FPU enabled 
> exception summary */
> +#define FPSCR_VX        0x20000000      /* Invalid operation 
> summary */
> +#define FPSCR_OX        0x10000000      /* Overflow 
> exception summary */
> +#define FPSCR_UX        0x08000000      /* Underflow 
> exception summary */
> +#define FPSCR_ZX        0x04000000      /* Zero-devide 
> exception summary */
> +#define FPSCR_XX        0x02000000      /* Inexact exception 
> summary */
> +#define FPSCR_VXSNAN    0x01000000      /* Invalid op for SNaN */
> +#define FPSCR_VXISI     0x00800000      /* Invalid op for 
> Inv - Inv */
> +#define FPSCR_VXIDI     0x00400000      /* Invalid op for 
> Inv / Inv */
> +#define FPSCR_VXZDZ     0x00200000      /* Invalid op for 
> Zero / Zero */
> +#define FPSCR_VXIMZ     0x00100000      /* Invalid op for 
> Inv * Zero */
> +#define FPSCR_VXVC      0x00080000      /* Invalid op for Compare */
> +#define FPSCR_FR        0x00040000      /* Fraction rounded */
> +#define FPSCR_FI        0x00020000      /* Fraction inexact */
> +#define FPSCR_FPRF      0x0001f000      /* FPU Result Flags */
> +#define FPSCR_FPCC      0x0000f000      /* FPU Condition Codes */
> +#define FPSCR_VXSOFT    0x00000400      /* Invalid op for 
> software request */
> +#define FPSCR_VXSQRT    0x00000200      /* Invalid op for 
> square root */
> +#define FPSCR_VXCVI     0x00000100      /* Invalid op for 
> integer convert */
> +#define FPSCR_VE        0x00000080      /* Invalid op 
> exception enable */
> +#define FPSCR_OE        0x00000040      /* IEEE overflow 
> exception enable */
> +#define FPSCR_UE        0x00000020      /* IEEE underflow 
> exception enable */
> +#define FPSCR_ZE        0x00000010      /* IEEE zero divide 
> exception enable */
> +#define FPSCR_XE        0x00000008      /* FP inexact 
> exception enable */
> +#define FPSCR_NI        0x00000004      /* FPU non IEEE-Mode */
> +#define FPSCR_RN        0x00000003      /* FPU rounding control */
>  
>  #define _MACH_prep     1
>  #define _MACH_Pmac     2  /* pmac or pmac clone (non-chrp) */
> 

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
