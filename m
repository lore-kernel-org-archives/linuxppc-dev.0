Message-ID: <XFMail.000219021754.jeremy@goop.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <B0CAE42C9EE0D311AAAD00500422FC6302CD71@iis000.microdata.fr>
Date: Sat, 19 Feb 2000 02:17:54 -0800 (PST)
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Patrick Lerda <Lerda@microprocess.com>
Subject: RE: PowerPC in little endian mode
Cc: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
        linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 17-Feb-00 Patrick Lerda wrote:
>       PowerPC 603, 740, 750 don't have a true little endian support, but
> some bridge like MPC106
>       seems to be able to translate munged data to true little-endian mode
> between CPU and PCI bridge, this
>       is enough to have a working  full little-endian system.
>
>       And so be able to get all the software from linux i386 working world
> without headache.

It would cause an absolutely gigantic problem in the PPC world.  Nobody uses
PPC in little-endian mode because its simply broken; the 106 may do some stuff
to twiddle PCI endianness, but I don't think it can twiddle memory endianness.

PCI is pretty much inherently little-endian, so all the PPC drivers just have
to deal with that; any driver which assumes that the CPU endianness is the same
as PCI endianness is just broken.  If you did a twiddle to make those drivers
work, you'd break everything else.

Making the PPC appear little endian so that general software which assumes
little endian mode can work would break everything else as well.  You'd need to
rewrite all the big-endian assember, implement little-endianness in the
compiler, recompile the world, change the kernel API (and don't even think of
suggesting per-process endianness).

So, no, I don't think its a good idea.

        J

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
