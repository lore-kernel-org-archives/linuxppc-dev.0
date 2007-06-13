Return-Path: <stern@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id DD8D8DDE2B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jun 2007 02:38:19 +1000 (EST)
Date: Wed, 13 Jun 2007 12:38:15 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [linux-usb-devel] [PATCH 6/6] [C67x00] Merge c67x00-hub.c into
	c67x00-hcd.c
In-Reply-To: <fa686aa40706130919u602498aw319cff16452079bc@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.0706131233220.3607-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Korsgaard <jacmet@sunsite.dk>, linux-usb-devel@lists.sourceforge.net,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 13 Jun 2007, Grant Likely wrote:

> I think we're crossing wires here.  In this particular case, I think
> the hub support code is sufficiently small that it doesn't need to be
> split off into a separate file.  (It's only 180 lines)  I'm not
> suggesting that the hub support stuff be moved to a .h file.
> 
> If the code was larger, I argue that c67x00-hub.c should be compiled
> separately from c67x00-hcd.c and that 'c67x00-hub.c' be added to
> 'c67x00-$(CONFIG_USB_C67X00_HCD)' in the Makefile.

> Heh, 'polluted' is too loaded a term, and it suggests something I
> didn't mean.  When the driver is built into the kernel, there are a
> number of c67x00_* symbols which are exported.  These symbols are not
> used anywhere other than in the c67x00 driver code.  However, this is
> necessary because the overall driver splits the various subsystems
> into separate .c files which are linked together.  This approach is
> well supported by convention in the kernel, and all the non-static
> symbols use the c67x00_ prefix to avoid collisions.
> 
> For example, see ib_core-y in drivers/infiniband/core/Makefile and
> pcieportdrv-y in drivers/pci/pcie/Makefile.
> 
> Since the driver already makes use of this approach, I don't think it
> makes sense to use a difference approach for the root hub support
> code.  (Again, I'm specifically talking about the c67x00 driver here;
> I've not looked at the *hci drivers in detail).

But you did say earlier that the way other drivers were written was a
bad idea...

In any case I agree that the root-hub code in c67x00 should be written
to match the style used by the rest of the driver.

> Of course, when it is built as a module, none of those symbols show up
> because they are not exported.

True.  And true as well of the other drivers which #include *.c files.

Alan Stern
