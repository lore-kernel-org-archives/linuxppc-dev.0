Message-ID: <3A643283.A20200E8@raleigh.ibm.com>
Date: Tue, 16 Jan 2001 06:37:39 -0500
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
To: frowand@mvista.com
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: kernel mapping
References: <3A63840E.4C724E03@mvista.com> <3A63BAFB.80E3980C@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------239A656DB394CD1678244028"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------239A656DB394CD1678244028
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Why do we need simulated bat registers.

Chip

Frank Rowand wrote:
>
> Dan Malek wrote:
> >
> > How come we don't use iopa() and friends for all kernel mapping
> > information?  It is only defined for CONFIG_APUS, but is the right
> > thing to use on 8xx and 4xx, and probably all processors.  The
> > virt_to_bus/bus_to_virt contain the quickie arithmetic hack with
> > KERNELBASE, but that isn't the right thing to do for any kmalloc()
> > or valloc() space or if you don't have BAT mapping.
> >
> > I am considering making these functions more generic, removing the
> > #ifdefs, and implementing "simulated" BAT mapping for processors
> > like the 8xx and 4xx that don't have BATs (not for 2.4, of course :-).
> >
> > Why shouldn't I do this?
> >
> >         -- Dan
>
> For the 405 I had to use iopa() for virt_to_bus() because there are
> cases where I create a virtual address for IO buffers that is
> uncached, and that virtual address is not (physical address + KERNELBASE).
> I also have the beginnings of simulated BAT mapping for the 405
> (not quite there, but part way).
>
> -Frank
> --
> Frank Rowand <frank_rowand@mvista.com>
> MontaVista Software, Inc
>
--------------239A656DB394CD1678244028
Content-Type: text/x-vcard; charset=us-ascii;
 name="rcblach.vcf"
Content-Description: Card for Ralph Blach
Content-Disposition: attachment;
 filename="rcblach.vcf"
Content-Transfer-Encoding: 7bit

begin:vcard
n:Blach;Ralph
tel;work:919-543-1207
x-mozilla-html:TRUE
url:www.ibm.com
org:IBM MicroElectronics
adr:;;3039 Cornwallis		;RTP;NC;27709;USA
version:2.1
email;internet:rcblach@raleigh.ibm.com
x-mozilla-cpt:;15936
fn:Ralph Blach
end:vcard

--------------239A656DB394CD1678244028--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
