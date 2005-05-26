Return-Path: <dan@embeddededge.com>
In-Reply-To: <20050526062057.GA25579@gate.ebshome.net>
References: <1117000809.6395.92.camel@gaston>
	<0015d371e12596fecdefd971b4fb1e5a@freescale.com>
	<1117004659.6395.103.camel@gaston>
	<b9ca52306a8b84cc1e03ac72c65316cf@embeddededge.com>
	<1117057460.5076.19.camel@gaston>
	<80f48eb53b0f876138cde07a997791b6@embeddededge.com>
	<20050526062057.GA25579@gate.ebshome.net>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fb2cb3a9f4b80b8fc6392698036b9f6a@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 26 May 2005 15:00:48 -0400
To: Eugene Surovegin <ebs@ebshome.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linuxppc-embedded@ozlabs.org
Subject: Re: RFC: Deprecating io_block_mapping
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 26, 2005, at 2:20 AM, Eugene Surovegin wrote:

> Dan, you must be kidding. 44x ioremaps PCI IO space, 40x uses
> io_block_mapping for that, but this is just brain-damaged and should
> be fixed.

Anyone that uses assumptions of mapping from io_block_mapping()
should be fixed, unless it is absolutely necessary, like to get an
early serial port for debugging.  I've been guilty of this as well,
but everyone should be calling ioremap().

> What is so special about PCI IO space that it must be "wired" ?

My point was someone needs to set up BATs or CAMs for that
space and further configure it so the in/out macros work.  Drivers
don't call ioremap for such space (although I think they should).
Assuming mappings exist, whether by calling ioremap() or
otherwise, is Linux legacy and shouldn't be done.

> Wow, this is something new for me. So you are saying that
> io_block_mapping() was supposed to be used with ioremap()?

Except in rare circumstances, it's the way I've always used
it to set up IO mapping on embedded boards.

> Could you point me to the port which actually does this?

I don't see any of them in the 2.6 right now, but the EP and STx ports
I did should do this.  I certainly plan to use it on all of the 85xx 
ports
so we get the advantage of CAM mapping for various IO spaces.

> So far I only saw io_block_mapping() used as a short-cut way _NOT_ to
> ioremap and get hard-coded v:p mapping and then use this knowledge to
> access physical address directly without ever calling ioremap(). And
> this is major source of problems.

That's just wrong.  The only "acceptable" io_block_mapping without
an ioremap has usually been the PCI IO space.  It gets abused for
early serial ports, but that's a hack no matter how you look at it :-)

> Also, by this logic, if platform doesn't have BAT or CAMs or whatever,
> which effectively prevents creating this "efficient mapping" and
> hence stated purpose of io_block_mapping cannot be achieved,
> io_block_mapping() should be eliminated on this platform, right?

Depends.  If you need early ioremap() prior to VM initialized so
a vmalloc will work, you have to do this even if you do call ioremap().
The 8xx ports usually do this, and ioremap() for these boards should
know to not try to allocate VM space if this was done.  Most of the 8xx
ports still skip the ioremap() because the associated code changes
to ioremap() never stuck in the code.

The problem with ioremap() if you don't wire some spaces is it will try 
to
allocate VM space prior to the Linux VM being initialized.  We all want
to write drivers so they use the proper ioremap() interfaces, but many
drivers call this too early if you haven't made the provisions for 
ioremap()
to find the "efficient" map and just return the associated address.

Thanks.


	-- Dan
