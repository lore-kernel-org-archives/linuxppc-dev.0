Date: Thu, 17 Feb 2000 12:18:13 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Patrick Lerda <Lerda@microprocess.com>
cc: linuxppc-dev@lists.linuxppc.org,
        "'debian-powerpc@lists.debian.org'" <debian-powerpc@lists.debian.org>
Subject: Re: PowerPC in little endian mode
In-Reply-To: <B0CAE42C9EE0D311AAAD00500422FC6302CD71@iis000.microdata.fr>
Message-ID: <Pine.HPX.4.10.10002171151480.2120-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 17 Feb 2000, Patrick Lerda wrote:

>
> 	Most of the trouble I have on my PowerPC platform came from the fact
> that
> 	Linux work in big-endian mode, this break some drivers like last USB
> developement,

The the drivre is badly written, that's all. Since all the infrastructure
is here to write endian independant drivers.

> 	and other PCI boards that work fine on i386 linux. Designing a
> driver working on
> 	different little-endian processors is quite easy the only
> differences between these
> 	systems is the PCI bus mapping that is different, but upgrading a
> driver is quite easy.
>
> 	Some applications are broken too, and from a user space point of
> view, the only difference
> 	between i386 and PowerPC linux is endianess.

Then the applications are badly written, but this is not the only
difference, see below. People are also using Linux on Sparc and 68k which
are big endian only. Besides older PPCs do not work well in little endian
mode (lots of alignment traps), and several instructions
(lmw/stmw/lswi/stswi/lswx/stswx) do not work at all, although this is not
a very serious limitation.

>
> 	PowerPC 603, 740, 750 don't have a true little endian support, but
> some bridge like MPC106
> 	seems to be able to translate munged data to true little-endian mode
> between CPU and PCI bridge, this
> 	is enough to have a working  full little-endian system.

Indeed, but setting the bridges up is a mess (and very dependant on each
bridge). I'm not even sure than all PMac bridges can be used in little
endian mode. I suspect little endian support in PPC is a vestige of trying
to get Microsoft porting NT to windows since they did not want to make the
effort to make it endian-independant. Another great Microsoft achievement
since now NT is architecture independant provided the architecture is x86
but don't get me started on that.

> 	And so be able to get all the software from linux i386 working world
> without headache.

No, there will still be problems, did you hear about iopl(), ioperm(),
sys_ldt(), embedded x86 assembly in X servers performing in and out
instructions or even disabling hardware interrupts with no checks in the
source code of the architecture it is being compiled for ?

Actually, these are probably more severe than endianness issues.

Besides that I'll stop using Linux/PPC the day it runs in little endian
mode. Big endian is the only right way. Actually God meant bit 0 to be the
most significant bit, not the other way around which leads to systematic
inconsistencies.

".naidne-elttil dnats t'nac I"

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
