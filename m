Subject: Re: 2.6 kernel on Sandpoint
From: Adrian Cox <adrian@humboldt.co.uk>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <4051D5EF.7040709@embeddededge.com>
References: <1079084120.691.16.camel@newt>
	 <4051D5EF.7040709@embeddededge.com>
Content-Type: text/plain
Message-Id: <1079112788.691.64.camel@newt>
Mime-Version: 1.0
Date: Fri, 12 Mar 2004 17:33:09 +0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2004-03-12 at 15:23, Dan Malek wrote:
> Adrian Cox wrote:

> > I've got a Sandpoint X2.  I've ported linuxppc_2_4_devel to run on it,
> Care to send out the patch?  I'll try to get it into the latest
> 2.4 tree.

Step 1 is this - needed for X3 to compile in the current Bitkeeper tree:

--- a/arch/ppc/platforms/sandpoint_setup.c	Fri Mar 12 17:27:42 2004
+++ b/arch/ppc/platforms/sandpoint_setup.c	Fri Mar 12 17:27:42 2004
@@ -141,7 +141,7 @@
 	serial_req.line = 0;
 	serial_req.port = 0;
 	serial_req.irq = 4;
-	serial_req.flags = STD_COM_FLAGS;
+	serial_req.flags = ASYNC_BOOT_AUTOCONF;
 	serial_req.io_type = SERIAL_IO_MEM;
 	serial_req.iomem_base = (u_char *)SANDPOINT_SERIAL_0;
 	serial_req.iomem_reg_shift = 0;

I'm just checking whether my patch works on the current
linuxppc_2_4_devel Bitkeeper. It should follow soon.

> > This should be the same on both X2 and X3 Sandpoints, leaving me curious
> > as to whether the X3 works with the current tree.
>
> Errr, not really.  The OpenPIC configuration for the two are quite
> different.  Something may have been lost in translation.  My X3 has been
> placed into active duty as the firewall/server, so I can help experiemnt
> with the X2 if you jump start with a patch :-)

The major difference is that the i8259 cascade is on IRQ 17 on the X2,
and 16 on the X3. My suspicion is that something in the i8259 setup has
broken.

> What processor are you running on the Sandpoint?

750.

- Adrian Cox
http://www.humboldt.co.uk/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
