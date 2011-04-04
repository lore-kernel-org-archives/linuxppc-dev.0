Return-Path: <glikely@secretlab.ca>
Received: from mail-iy0-f170.google.com (mail-iy0-f170.google.com
	[209.85.210.170]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 26BCEB6F88
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2011 06:54:46 +1000 (EST)
Received: by iyb12 with SMTP id 12so7711207iyb.15
	for <linuxppc-dev@ozlabs.org>; Mon, 04 Apr 2011 13:54:43 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Mon, 4 Apr 2011 14:54:40 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Ayman El-Khashab <ayman@elkhashab.com>
Subject: Re: problem PCIe LSI detected at 32 device addresses (ppc460ex)
Message-ID: <20110404205440.GB25557@ponder.secretlab.ca>
References: <20110401162619.GA20132@crust.elkhashab.com>
	<20110401225903.GA27320@crust.elkhashab.com>
	<1301867559.2549.32.camel@pasglop>
	<BANLkTikTeAgc2dg3-M7yM185pg7FAdbAGw@mail.gmail.com>
	<20110403232213.GA28042@crust.elkhashab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110403232213.GA28042@crust.elkhashab.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Apr 03, 2011 at 06:22:13PM -0500, Ayman El-Khashab wrote:
> 
> On Sun, Apr 03, 2011 at 04:09:26PM -0600, Grant Likely wrote:
> > On Sun, Apr 3, 2011 at 3:52 PM, Benjamin Herrenschmidt
> > <benh@kernel.crashing.org> wrote:
> > >
> > >> Ok, I've narrowed the scope of the problem some. ?I moved forward
> > >> to a more recent kernel (2.6.31 to 2.6.36) and that resolved the
> > >> problem of the controller showing up as every device on the bus.
> > >> However, from 2.6.37 to the current HEAD, I have not been able to
> > >> build a kernel to run on the 460EX. ?I tried 2.6.37, 2.6.38, and
> > >> the HEAD and all result in the following kernel panic. ?I am not
> > >> sure how to proceed here. ?I suppose we can stick with 2.6.36 since
> > >> it works, but I'd like to understand what it might take to remedy
> > >> this.
> > >
> > > Smells like somebody changed something with the OF flash code... Josh,
> > > Grant, any idea what's up there ?
> > 
> > Not sure, more information would be helpful.
> > 
> > Ayman, if you do a 'git log v2.6.36.. drivers/mtd/maps/physmap_of.c',
> > then you'll see a list of commits touching the mtd driver.  Would you
> > be able to do a 'git checkout <sha1-id>' on each of those are report
> > back on at what point things stop working?  Actually, a full bisect
> > between 2.6.36 and 2.6.37 would be best, but this is a good start if
> > you're limited on time.  Once you find the first commit where it
> > fails, do a 'git checkout <sha1>~1' to confirm that it is in fact the
> > commit that causes the breakage.
> 
> I can try to find the commit tomorrow.  In the interim, i've pasted
> the dts below.  The board was originally based on the canyonlands, but
> we've made some changes, mostly to the pcie.  we run the 1-l port in 
> endpoint mode, we have a chain of plx switches and devices on the 4-l 
> port.  One item that I don't think would matter, but is not too common 
> is that we are booting these over the pci bus from another PPCs memory.
> I only mention this since this failure is during boot, though everything
> should by local to the cpu by this time.
> 
> > 
> > Can you also post your device tree please?
> 
> Here is the device tree for our custom board.

Hmmm, considering that there is no device node for NAND in this tree,
something is definitely wrong.  The NAND driver should not be getting
probed.  If you can do a git bisect on the kernel it will go a long
way to figuring out what is wrong.

I suspect that it is related to merging of_platform_bus_type into the
platform_bus_type.  It looks like a device is getting incorrectly
matched to the driver, but I don't know why.

It would also help to add this code to 2.6.38 and send me the log
output:

g.


diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index c01cd1a..e9ac215 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -56,6 +56,8 @@ static int platform_driver_probe_shim(struct platform_device *pdev)
 	 * come up empty.  Return -EINVAL in this case so other drivers get
 	 * the chance to bind. */
 	match = of_match_device(pdev->dev.driver->of_match_table, &pdev->dev);
+	dev_info(&pdev->dev, "match to of_platform_driver, node:%s\n",
+		pdev->dev.of_node ? pdev->dev.of_node->full_name : "!none!");
 	return match ? ofpdrv->probe(pdev, match) : -EINVAL;
 }
 
