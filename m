Date: Tue, 28 May 2002 10:36:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: shaowei dai <dshaowei@rfnetech.com>
Cc: Sangmoon Kim <dogoil@etinsys.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: map iomem in linux_2_4_dev
Message-ID: <20020528003604.GN16537@zax>
References: <003801c20543$b90a4180$e1a8459b@ntu.edu.sg> <20020527063451.GL16537@zax> <005c01c2054a$e3fb2100$e1a8459b@ntu.edu.sg> <00fe01c20556$614567a0$1a11efcb@industrialDiv.hanasys.co.kr> <008501c20556$544612c0$e1a8459b@ntu.edu.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <008501c20556$544612c0$e1a8459b@ntu.edu.sg>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, May 27, 2002 at 04:13:05PM +0800, shaowei dai wrote:
>
> Hi, Sangmoon:
>
> Thanks. I got it. We've to use io_block_mapping() followed by ioremap() to
> map the physical address.

No, that's rubbish.  Use one or the other. ioremap() takes a physical
address and returns the virtual address at which it mapped it.

> From: "Sangmoon Kim" <dogoil@etinsys.com>
> To: "shaowei dai" <dshaowei@rfnetech.com>;
> <linuxppc-embedded@lists.linuxppc.org>
> Sent: Monday, May 27, 2002 4:13 PM
> Subject: Re: map iomem in linux_2_4_dev
>
>
> > Hi, Shaowei:
> >
> > The parameter addr of ioremap is not a virtual address
> > but a kind of physical address.
> >
> > Let us have a device at 0x78000000.
> > We can change the address to 0xf0000000 by...
> >  io_block_mapping(0xf0000000, 0x78000000, 0x08000000, _PAGE_IO);
> > Than what is the return value of ioremap(0x78000000, 0x08000000)?
> > That is 0xf0000000.
> >
> > The system changes the addresses of devices for various reason.
> > We only know the original address.
> > Than we can use the ioremap to get the changed address.
> >
> > -Sangmoon Kim-

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
