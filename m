Date: Tue, 26 Sep 2000 20:18:35 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: gongzhuo <gongzhuo@163.net>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Does anyone know the memory mapping rules of linuxppc for mvme2600
 ?
In-Reply-To: <39C029EB.23243@bjsmtp3.163.net>
Message-ID: <Pine.HPX.4.10.10009261919440.24555-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 14 Sep 2000, gongzhuo wrote:

>
> Hi:
>   I'm sorry for the copies of my last mail . It seems to be the problem of my ISP.
>   Does anyone know the memory mapping rules for linuxppc on MVME2600?
>   If I want to write lkm to add some mappings in the kernel space for my hacking, what functions can I use for memory mapping ?

It depends on whether you use the standard kernel with PreP mappings or my
kernel which reprograms the PCI bridge Raven to get CHRP like mappings:
in both mode the first gigabyte is reserved for system RAM but is not
fully populated (unless you've got 1 Gig of RAM which is not my case).

For higher addresses in PreP mode (if I remember well but it may depend
on the exact version of PPCBUG and OF configured it differently so take
it with a grain of salt):
0x40000000-0x7fffffff: not mapped (was mapped to PCI memory space with OF)
0x80000000-0xbf7fffff: ISA/PCI I/O space, bus addresses 0 to 0x3fffffff
0xbf800000-0xbfffffff: not mapped, don't ask me why
0xc0000000-0xfcffffff: ISA/PCI memory space, bus addresses 0 to 0x3cffffff
0xfd000000-0xfdffffff: ISA memory space (again!, bus addresses 0 to 0xffffff)
0xfe000000-0xfe7fffff: ISA/PCI I/O space (again!, bus addresses 0 to 0x7fffff)
0xfe800000-0xfef7ffff: not mapped
0xfef80000-0xfeffffff: Raven and Falcon registers with holes, see the doc for details
0xff000000-0xffffffff: two banks of Flash ROM with some holes, top 1MB aliased to bottom
			of either bank depending on jumpers, see the doc for details

If you use my kernels, they almost follow the MPC106 in CHRP mode:
0x40000000-0xfcffffff: PCI memory space, no offset
0xfd000000-0xfdffffff: ISA memory space, bus addresses 0 to 0xffffff
0xfe000000-0xfebfffff: PCI/ISA I/O space, bus addresses 0 to 0xbfffff
0xfec00000-0xffffffff: same as PreP mode...

For DMA accesses, the offset is 0x80000000 in PreP mode. It is 0 with my
kernels, the lowest 16 Mb can also be accssed from bus addresses
0xfd??????, like the Grackle. This is only a problem if you want to access
the lowest megabyte of RAM which is not seen from the bus because of VGA
aliasing issues. But since the kernel code lies there is is hardly ever a
problem.

	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
