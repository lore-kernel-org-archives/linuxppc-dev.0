Date: Mon, 15 May 2000 18:56:58 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Gong Zhuo <gongzhuo@163.net>
cc: linuxppc dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Any compact pci driver for MCP750?
In-Reply-To: <009a01bfbb13$559d2d00$4607a8c0@LocalHost>
Message-ID: <Pine.HPX.4.10.10005151516370.9762-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 11 May 2000, Gong Zhuo wrote:

> > > Hi:
> > >   I am using CPX8216. I want to run linuxppc on the system board MCP750.
> Is
> > > there any device driver which can support DEC21154 (or DEC21554 for
> MCPN750)
> > > so that I can operate the memory on board(MCPN750)  through the compact
> pci
> > > bus?
> >
> > For the MCP750, you should have no problems. But to access MCPN750, the
> > code is not written and even the infrastructure is not (yet) there. some
> > more work to support non transparent PCI<->PCI bridges is necessary.
> >
> > For various reasons (getting a larger PCI memory space being the first one
> > in your case to be able t oaccess several MCPN750 in a single backplane),
> > you might be interested in my prepboot loader which reorganizes Raven or
> > Hawk bridges in CHRP mode rather than PreP mode
> > (ftp:://vlab1.iram.es/linux-2.2/mvme*patch*).
> >
> In fact , I am moving from VME bus to CompactPCI bus . I have used your VME
> bus drivers for MVME2600 and it is very good . Thank you very much. Does you
> meaning there is  a similar driver for DEC21154(MCP750) so that 'open'
> 'close' 'mmap' and so on can be done on C-PCI just like your VME bus
> drivers?

Thanks for the comments on my VME driver. It's always good to have
feedback, especially positive feedback :-)

This can be done simply by opening /dev/mem and using mmap, but it does
not take into account the offsets in the bridges. This you have to know
in your application level code (the VME driver does it for you because
it's needed anyway to abstract this for kernel drivers and the amount of
code needed to expose it as a user interface is small).

There are othehr problems is if you want to access I/O space which can be
at any HW address on PPC and this problem has been raised several times
for various reasons (most notably X servers). When combined with non
transparent bridges, it can IMHO only be solved cleanly and generically by
an extension of the current resource tree framework (at least for kernel
code which wants to access a device and memory on a CPCI system with
multiple CPUs, then a way to expose it to application code has to be
found).

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
