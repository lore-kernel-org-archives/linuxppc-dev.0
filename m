Subject: Re: userspace testing an ati fb driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: random <eger-temp_addy-1071049257.71afe9@theboonies.us>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.50L0.0312030435240.3077-100000@rosencrantz.pok.ibm.com>
References: 
	 <Pine.LNX.4.50L0.0312030435240.3077-100000@rosencrantz.pok.ibm.com>
Content-Type: multipart/mixed; boundary="=-bqIrYqwt3hkdlGVO1fsy"
Message-Id: <1070496406.3672.19.camel@gaston>
Mime-Version: 1.0
Date: Thu, 04 Dec 2003 11:06:46 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-bqIrYqwt3hkdlGVO1fsy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2003-12-03 at 20:44, random wrote:
> On my Powerbook, /proc/iomem lists 0xb0000000-0xb000ffff as the location
> of the programming registers for my ATI Radeon R250 Lf.
>
> This seems to be the same spot XFree86 finds in its log:
> (II) RADEON(0): MMIO registers at 0xb0000000
>
> I've been trying to mimic the XFree86 fb accel code to make a Linux 2.6 fb
> port, but i've had little luck. To try to pare down the new code, I've
> written a userspace program which will open "/dev/mem" and then mmap in
> this file starting at '0xb0000000' going for 0x10000 bytes.  Poking at the
> "registers" there seems to have no effect; reading from these "registers"
> (for example, to verify the engine idling) indicates that I'm perhaps
> reading from the wrong place in memory, i.e. the engine never indicates
> that it's idle.  Any ideas?

That should work, make sure you are using proper memory barriers for
your IO accesses though (eieio instructions)

Enclosed is an example of a little program I use to dump the radeon
registers

Ben.



--=-bqIrYqwt3hkdlGVO1fsy
Content-Disposition: attachment; filename=radeondump.c
Content-Type: text/x-c; name=radeondump.c; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <unistd.h>
#include <byteswap.h>

void * mmio;

//#define RADEON_RBASE	0xe3000000
//#define RADEON_RBASE	0xb0000000
#define RADEON_RBASE	0x90000000
//#define RADEON_RBASE	0x90080000

static  unsigned char regr8(volatile void *base, const unsigned long offset=
)
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


static  void regw8(volatile void *base, const unsigned long offset,
			const unsigned char val)
{
	__asm__ __volatile__ ("stbx %1,%2,%3\n\t"
				"eieio"
                        : "=3Dm" (*((volatile unsigned char *)base+offset))
                        : "r" (val), "b" (base), "r" (offset));
}


static  unsigned int regr(volatile void *base, const unsigned long offset)
{
	unsigned int val;

	__asm__ __volatile__ ("lwbrx %0,%1,%2\n\t"
				"eieio"
				: "=3Dr" (val)
				: "b" (base), "r"(offset),
				"m" (*((volatile unsigned char *)base+offset)));
	return val;
}

static  void regw(volatile void *base, const unsigned long offset,
				const unsigned int val)
{
	__asm__ __volatile__ ("stwbrx %1,%2,%3\n\t"
				"eieio"
				: "=3Dm" (*((volatile unsigned char *)base+offset))
				: "r"(val), "b"(base), "r"(offset));
}

static  unsigned int pllr(volatile void *base, const unsigned long index)
{
	unsigned int val;

	regw8(base, 0x8, index & 0x3f);
	return regr(base, 0xc);
}


unsigned long regs[0x800];
unsigned long pllregs[0x40];

int main() {
	int fd, i;
=09
	fd =3D open("/dev/mem", O_RDWR);

	mmio =3D (void *)mmap(0, 0x80000, PROT_READ|PROT_WRITE,
			MAP_SHARED, fd, RADEON_RBASE);

	for (i=3D0; i<0x800; i++)
		regs[i] =3D regr(mmio, i*4);
	for (i=3D0; i<0x40; i++)
		pllregs[i] =3D pllr(mmio, i);

	printf("Radeon MMIO registers:\n");
	for (i=3D0; i<0x800; i++) {
		if (regs[i] !=3D 0)
			printf("%04x : %08x\n", i*4, regs[i]);
	}
	printf("\nRadeon PLL registers:\n");
	for (i=3D0; i<0x40; i++) {
		if (pllregs[i] !=3D 0)
			printf("  %02x : %08x\n", i, pllregs[i]);
	}
	printf("\n");
}

--=-bqIrYqwt3hkdlGVO1fsy--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
