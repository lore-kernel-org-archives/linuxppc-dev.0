Date: Wed, 11 Aug 1999 10:23:46 +1000
Message-Id: <199908110023.KAA23996@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: Jes.Sorensen@cern.ch
CC: Geert.Uytterhoeven@cs.kuleuven.ac.be, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu
In-reply-to: <d34si8xfwi.fsf@lxp03.cern.ch> (message from Jes Sorensen on 10
	Aug 1999 09:18:21 +0200)
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.4.10.9908091008460.25523-100000@mercator.cs.kuleuven.ac.be> <199908100100.LAA28784@tango.anu.edu.au> <d34si8xfwi.fsf@lxp03.cern.ch>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jes Sorensen <Jes.Sorensen@cern.ch> wrote:

> This is quite easily solved by putting in mb()'s in the right
> places. This is how it is done for other drivers that are supposed to
> work on the Alpha.

No, this is not an acceptable solution.

On ultrasparc at least, there is a "side-effect" bit in each PTE.  If
that bit is set, it tells the cpu not to reorder accesses to that
page.  I don't know whether alpha has the same facility, do you?

Anyway, it's hard enough educating device driver writers about the
need for byte-swapping on data in memory that is accessed by DMA.
Trying to get people to scatter mb()'s around their drivers would be a
herculean task (a bit like cleaning out the Augean stables, actually
:-).

Finally, mb() is actually a much stronger constraint than we need in a
device driver, and will slow things down unnecessarily.  mb() implies
a strong ordering on all loads and stores to all memory.  On the PPC,
mb() translates into the sync instruction, which is much slower than
eieio.  For a sync, the cpu actually has to stop and wait for all bus
activity to complete, whereas for an eieio, it just puts a special
kind of entry in the stream of accesses going out to the memory bus.

> Having mb()'s explicitly put into the driver in the right places also
> makes sure that a driver will work on other architectures. Right now a
> driver that is written for the PPC is likely not to work on the Alpha
> if the author expects readl/writel to guarantee write ordering.

Well, if alpha is actually like that, then IMO it is broken.

I did some experiments this morning to test whether having eieio in
readl/writel is actually going to slow you down.  The bottom line is
that the eieio introduces *no* measurable reduction in performance.  I
used the little program that I have appended below (mtest.c and
mtm.S).

I ran it on my 7600 like this:

mtest 94000000 b420 e1480 200 400 2304 100
mtestn 94000000 b420 e1480 200 400 2304 100

This was with the screen at 1152x870, 16bpp.  mtestn is just a symlink
to mtest.  The results for 10 runs were:

   with eieio:	       mean 2.825s, s.d. 0.007s
   without eieio:      mean 2.824s, s.d. 0.027s

I also tried it on my iMac (81000000 a000 b8350 200 400 2048 100) and
got 4.76s both with and without eieio.

So, unless and until you can show me some numbers that show an actual
performance degradation from having the eieio in readl/writel, the
eieio stays.

Paul.

mtest.c:

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>

extern void move_eieio(int *src, int *dst, int nx, int ny, int pitch);
extern void move_no_eieio(int *src, int *dst, int nx, int ny, int pitch);

main(int ac, char **av)
{
	int fd;
	unsigned long base, sof, dof;
	int nx, ny, pitch;
	long ptr;
	int nrpt;
	int use_eieio;

	if (ac < 7) {
		fprintf(stderr, "Usage: %s base sof dof nx ny pitch\n", av[0]);
		exit(1);
	}
	base = strtoul(av[1], 0, 16);
	sof = strtoul(av[2], 0, 16);
	dof = strtoul(av[3], 0, 16);
	nx = atoi(av[4]);
	ny = atoi(av[5]);
	pitch = atoi(av[6]);
	nrpt = (ac > 7)? atoi(av[7]): 1;
	if ((fd = open("/dev/mem", 2)) < 0) {
		perror("/dev/mem");
		exit(1);
	}
	use_eieio = strchr(av[0], 'n') == 0;
	printf("%seieio\n", use_eieio? "": "no ");
	ptr = mmap(0, 0x200000, PROT_READ|PROT_WRITE, MAP_SHARED, fd, base);
	if (ptr == -1) {
		perror("mmap");
		exit(1);
	}
	if (use_eieio) {
		do {
			move_eieio((int *)(ptr + sof), (int *)(ptr + dof),
				   nx, ny, pitch);
			dof += 4;
		} while (--nrpt > 0);
	} else {
		do {
			move_no_eieio((int *)(ptr + sof), (int *)(ptr + dof),
				      nx, ny, pitch);
			dof += 4;
		} while (--nrpt > 0);
	}
	exit(0);
}

mtm.S:

/* move_eieio(int *src, int *dst, int nx, int ny, int pitch) */
	.globl	move_eieio
move_eieio:
	mtctr	5
	li	8,0
2:	lwbrx	0,3,8
	eieio
	stwbrx	0,4,8
	eieio
	addi	8,8,4
	bdnz	2b
	addic.	6,6,-1
	blelr
	add	3,3,7
	add	4,4,7
	b	move_no_eieio

/* move_no_eieio(int *src, int *dst, int nx, int ny, int pitch) */
	.globl	move_no_eieio
move_no_eieio:
	mtctr	5
	li	8,0
2:	lwbrx	0,3,8
	stwbrx	0,4,8
	addi	8,8,4
	bdnz	2b
	addic.	6,6,-1
	blelr
	add	3,3,7
	add	4,4,7
	b	move_no_eieio

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
