Subject: Re: ibook G4 Status Report
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Costantino Pistagna <valvoline@tiscalinet.it>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <015F12CA-5CC6-11D8-B40D-000A95B30208@tiscalinet.it>
References: <27203D60-5B28-11D8-A96D-000A95B30208@vrlteam.org>
	 <1076361029.763.13.camel@gaston>
	 <015F12CA-5CC6-11D8-B40D-000A95B30208@tiscalinet.it>
Content-Type: multipart/mixed; boundary="=-tb0cPItHkaclWEua//+8"
Message-Id: <1076537923.866.133.camel@gaston>
Mime-Version: 1.0
Date: Thu, 12 Feb 2004 09:18:44 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-tb0cPItHkaclWEua//+8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


>
> I've noticed this problem. the only way to get XFree working properly,
> is
> to use the UseFBDev directive into XF86Config. Unfortunately, this
> directive
> seems to get in troubles with dualhead XF86Config (i've used the one
> that i'm
> using in my desktop, equipped with a Rage128): the panels are waiting
> for
> something with a black screen. If it's usefull, i'm using an XFree
> 4.3.0 binary
> merged with gentoo/ppc.

Ok, you need to use XFree without UseFBDev. This cause some flicker on
your LCD, and then run the enclosed hack which should fix the flicker. Let
me know if that helps. XFree without UseFBDev will also screw up switching
back to console unfortunately, I have a hack for that (remove all the vgaXXX
calls in XFree) locally.

I expect to have full support of dual head in radeonfb not too far from
now, though there will be some work needed for XFree to be able to "use"
it... I hope that work could easily be included in Michel's packages at
least :)

Note that if the enclosed lcd_hack.c doesn't work, try adding that line
to it at the end:

OUTPLL(3,0xc);

Let me know.

Ben.

--=-tb0cPItHkaclWEua//+8
Content-Disposition: attachment; filename=lcd_hack.c
Content-Type: text/x-c; name=lcd_hack.c; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <unistd.h>
#include <byteswap.h>
#include <linux/fb.h>
#include <errno.h>
#include "radeon.h"

void * mmio;

#define RADEON_RBASE	0xb0000000
//#define RADEON_RBASE	0x90000000

static inline unsigned char regr8(void *base, const unsigned long offset)
{
        unsigned char val;=20
        __asm__ __volatile__(
                        "lbzx %0,%1,%2\n\t"
                        "eieio"
                        : "=3Dr" (val)
                        : "b" (base), "r" (offset),
                        "m" (*((volatile unsigned char *)base+offset)));
        return(val);
}


static inline void regw8(void *base, const unsigned long offset,
			const unsigned char val)
{
	__asm__ __volatile__ ("stbx %1,%2,%3\n\t"
				"eieio"
                        : "=3Dm" (*((volatile unsigned char *)base+offset))
                        : "r" (val), "b" (base), "r" (offset));
}


static inline unsigned int regr(void *base, const unsigned long offset)
{
	unsigned int val;

	__asm__ __volatile__ ("lwbrx %0,%1,%2\n\t"
				"eieio"
				: "=3Dr" (val)
				: "b" (base), "r"(offset),
				"m" (*((volatile unsigned char *)base+offset)));
	return val;
}

static inline void regw(void *base, const unsigned long offset,
				const unsigned int val)
{
	__asm__ __volatile__ ("stwbrx %1,%2,%3\n\t"
				"eieio"
				: "=3Dm" (*((volatile unsigned char *)base+offset))
				: "r"(val), "b"(base), "r"(offset));
}

static inline unsigned int pllr(void *base, const unsigned long index)
{
	unsigned int val;

	regw8(base, 0x8, index & 0x3f);
	return regr(base, 0xc);
}

#define INREG(r)	regr(mmio, (r))
#define OUTREG(r, v)	regw(mmio, (r), (v))
#define INREG8(r)	regr8(mmio, (r))
#define OUTREG8(r, v)	regw8(mmio, (r), (v))

#define OUTPLL(addr,val)	\
	do {	\
		OUTREG8(CLOCK_CNTL_INDEX, (addr & 0x0000003f) | 0x00000080); \
		OUTREG(CLOCK_CNTL_DATA, val); \
	} while(0)

static inline unsigned long _INPLL(unsigned long addr)
{
	OUTREG8(CLOCK_CNTL_INDEX, addr & 0x0000003f);
	return (INREG(CLOCK_CNTL_DATA));
}

#define INPLL(addr)		_INPLL(addr)


int main() {
	int fd, fbfd, i;
	unsigned int cci;
	struct fb_fix_screeninfo fix;
=09
	fbfd =3D open("/dev/fb0", O_RDWR);
	if (fbfd =3D=3D -1) {
		perror("cannot open framebuffer\n");
		return ENODEV;
	}
	if (ioctl(fbfd, FBIOGET_FSCREENINFO, &fix)) {
		perror("cannot get sceen info\n");
		return ENODEV;
	}
	if (fix.accel !=3D FB_ACCEL_ATI_RADEON) {
		fprintf(stderr, "not a radeon !\n");
		return ENODEV;
	}
	fd =3D open("/dev/mem", O_RDWR);
	if (fd =3D=3D -1) {
		perror("cannot open /dev/mem\n");
		return ENODEV;
	}
	mmio =3D (void *)mmap(0, 0x80000, PROT_READ|PROT_WRITE,
			MAP_SHARED, fd, fix.mmio_start);
	/* Force switch to PLL0 */
	printf("Frobbing radeon PLL...\n");
	cci =3D INREG(8);
	OUTREG(8, cci & ~0x00000300);
}

--=-tb0cPItHkaclWEua//+8--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
