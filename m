Date: Sat, 8 Mar 2003 03:04:40 -0500
From: Bill Fink <billfink@mindspring.com>
To: Hollis Blanchard <hollis@austin.ibm.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Runtime Altivec detection
Message-Id: <20030308030440.39fcdc90.billfink@mindspring.com>
In-Reply-To: <200303072011.54069.hollis@austin.ibm.com>
References: <20030307210257.7b094f55.billfink@mindspring.com>
	<200303072011.54069.hollis@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Hollis,

On Fri, 7 Mar 2003, Hollis Blanchard wrote:

> On Friday 07 March 2003 08:02 pm, Bill Fink wrote:
> >
> > Here is the code xine uses to do run time Altivec detection
> > (from xine-utils/cpu_accel.c):
> >
> > #if defined (ARCH_PPC) && defined (ENABLE_ALTIVEC)
> > static sigjmp_buf jmpbuf;
> > static volatile sig_atomic_t canjump = 0;
> >
> > static void sigill_handler (int sig)
> [snip]
>
> Compared to testing the CPU feature bits supplied by the kernel (for a long
> time now; Ben could tell you exactly how long) this method seems *extremely*
> messy. Please see my other posts (and Ben's) in this thread for details.

OK, here's a sample program that uses the auxiliary vector table to
get the user visible CPU features.

--------------------------------------------------------------------------------
#include <stdio.h>
#include <linux/elf.h>

typedef struct {
	int	a_type;
	union {
		long	a_val;
		void	*a_ptr;
		void	(*a_fcn)();
	} a_un;
} auxv_t;

main(int argc, char *argv[], char *env[], auxv_t aux_table[])
{
	int has_altivec = 0;

	while (aux_table[0].a_type != AT_NULL) {
		fprintf(stdout, "a_type = %2d", aux_table[0].a_type);
		fprintf(stdout, " a_val = 0x%X\n", aux_table[0].a_un.a_val);
		if ((aux_table[0].a_type == AT_HWCAP) &&
		    (aux_table[0].a_un.a_val & PPC_FEATURE_HAS_ALTIVEC))
			has_altivec++;
		aux_table++;
	}

	fprintf(stdout, "CPU %s have Altivec\n",
			has_altivec ? "does" : "doesn't");
	exit(0);
}
--------------------------------------------------------------------------------

And it seems to work.  Here's a run on my home dual 500 MHz G4:

a_type = 22 a_val = 0x16
a_type = 22 a_val = 0x16
a_type = 19 a_val = 0x20
a_type = 20 a_val = 0x20
a_type = 21 a_val = 0x0
a_type = 16 a_val = 0x9C000000
a_type =  6 a_val = 0x1000
a_type = 17 a_val = 0x64
a_type =  3 a_val = 0x10000034
a_type =  4 a_val = 0x20
a_type =  5 a_val = 0x6
a_type =  7 a_val = 0x30000000
a_type =  8 a_val = 0x0
a_type =  9 a_val = 0x10000350
a_type = 11 a_val = 0x130
a_type = 12 a_val = 0x130
a_type = 13 a_val = 0xA
a_type = 14 a_val = 0xA
CPU does have Altivec

a_type = 16 (AT_HWCAP) holds the "arch dependent hints at CPU capabilities".
Here are the CPU features as defined by asm/cputable.h:

#define PPC_FEATURE_32                  0x80000000
#define PPC_FEATURE_64                  0x40000000
#define PPC_FEATURE_601_INSTR           0x20000000
#define PPC_FEATURE_HAS_ALTIVEC         0x10000000
#define PPC_FEATURE_HAS_FPU             0x08000000
#define PPC_FEATURE_HAS_MMU             0x04000000
#define PPC_FEATURE_HAS_4xxMAC          0x02000000
#define PPC_FEATURE_UNIFIED_CACHE       0x01000000

So for my home dual 500 MHz G4, 0x9C000000 translates to the following
features:

	32, HAS_ALTIVEC, HAS_FPU, HAS_MMU

That seems to be a good sanity check on the code.

I then did a run on a 300 MHz G3:

a_type = 22 a_val = 0x16
a_type = 22 a_val = 0x16
a_type = 19 a_val = 0x20
a_type = 20 a_val = 0x20
a_type = 21 a_val = 0x0
a_type = 16 a_val = 0x8C000000
a_type =  6 a_val = 0x1000
a_type = 17 a_val = 0x64
a_type =  3 a_val = 0x10000034
a_type =  4 a_val = 0x20
a_type =  5 a_val = 0x6
a_type =  7 a_val = 0x30000000
a_type =  8 a_val = 0x0
a_type =  9 a_val = 0x1000039C
a_type = 11 a_val = 0x130
a_type = 12 a_val = 0x130
a_type = 13 a_val = 0xA
a_type = 14 a_val = 0xA
CPU doesn't have Altivec

One thing I'm not sure about is if the auxv_t typedef needs to be
different for PPC64.

There's also a practical consideration.  For example, in the xine case,
the test for Altivec support is done in the xine library package, whereas
the main() program is in a separate package, namely the xine UI, of which
there are actually several available UIs.  Now if there was a getaux
function similar to the getenv function, this would make matters a lot
simpler.

So while the current xine code may be somewhat ugly, it does work and
is pretty easy to implement within a library.

						-Bill

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
