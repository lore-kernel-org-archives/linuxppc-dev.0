Date: Wed, 7 Mar 2001 02:15:11 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Brad Parker <brad@parker.boston.ma.us>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: asm/io.h; why does writel() write an le32 on ppc? 
In-Reply-To: <200103062328.SAA01824@p2.parker.boston.ma.us>
Message-ID: <Pine.HPX.4.10.10103070209260.3942-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 6 Mar 2001, Brad Parker wrote:

>
> Gabriel Paubert wrote:
> >On Tue, 6 Mar 2001, Brad Parker wrote:
> ...
> >> in asm/io.h it uses out_le32, unless the machine is an APUS, in which
> >> case it just writes big endian...
> >>
> >> (is PCI defined as little endian?)
> >
> >Sadly, yes.
>
> Ok, so the APUS pci bridge must be doing byte swapping.  I assume the
> ppc macintosh pci bridges do not byte swap...

Nor any other PPC bridge that I know (unless you put it in little-endian
mode because of the address munging that the processor does, but the
munging is not dependant on the size of the transfer). Byte
swapping bridges are painful to handle when you try to move structures as
a block across the bridges (the way the byte lanes are connected between
both sides of the bridges changes depending on the size of the transfer).
I prefer very much byte address preserving bridges, like PMAC/PreP/CHRP.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
