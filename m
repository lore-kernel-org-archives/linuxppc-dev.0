Subject: Calling testers for another Dead Function Optimisation update
To: linux-kernel@vger.rutgers.edu, linux-m68k@lists.linux-m68k.org,
        linux-alpha@vger.rutgers.edu, linux-mips@fnet.fr,
        sparclinux@vger.rutgers.edu, linuxppc-dev@lists.linuxppc.org,
        linux-embedded@waste.org
Date: Thu, 11 May 2000 13:41:05 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000511034105.0046250B7F@brixi.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Gang,

I've made yet another update to my dead function optimisation patch to the
2.2.x series kernel, and I'd really appreciate anyone who could take a little
while to try it on their platform. It's generally useful to everyone for
reducing kernel size, and is particularly handy for emdedded systems people.

This update fixes the following problems I missed in the last one:

- Ralf Baechle pointed out that get_wchan relied on function ordering, and
  hence was broken by my patch due to the linker section-reordering bug. I
  changed the mechanism used to identify scheduler functions so it no longer
  relies on function ordering.

- I had neglected to patch the arm/vmlinux*.lds files

- I had neglected to include .rodata.* sections for static const data

- I had neglected to change a .text.lock to .lock.text
  in arch/i386/kernel/head.S

See the patch header for all the gory details.

The updated patch is available at:
    http://members.xoom.com/greyhams/linux/patches/2.2/funcsect.patch

I think/hope we're getting close to something that could be accepted into the
official kernel now. Once again, any feedback is most welcome!

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
