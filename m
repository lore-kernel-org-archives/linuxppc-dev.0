Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C0ED9B6FAB
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2012 16:08:05 +1000 (EST)
Received: by dajt11 with SMTP id t11so6917095daj.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2012 23:08:03 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3] of: Add prefix parameter to of_modalias_node().
To: David Daney <ddaney.cavm@gmail.com>, devicetree-discuss@lists.ozlabs.org,
 Rob Herring <rob.herring@calxeda.com>, spi-devel-general@lists.sourceforge.net
In-Reply-To: <20120520055436.13AF03E03B8@localhost>
References: <1336773923-17866-1-git-send-email-ddaney.cavm@gmail.com>
 <1336773923-17866-2-git-send-email-ddaney.cavm@gmail.com>
 <20120520055436.13AF03E03B8@localhost>
Date: Sun, 20 May 2012 00:08:01 -0600
Message-Id: <20120520060802.03CE73E03B8@localhost>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 David Daney <david.daney@cavium.com>, Takashi Iwai <tiwai@suse.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Liam Girdwood <lrg@ti.com>, Jaroslav Kysela <perex@perex.cz>,
 linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 19 May 2012 23:54:36 -0600, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Fri, 11 May 2012 15:05:21 -0700, David Daney <ddaney.cavm@gmail.com> wrote:
> > From: David Daney <david.daney@cavium.com>
> > 
> > When generating MODALIASes, it is convenient to add things like "spi:"
> > or "i2c:" to the front of the strings.  This allows the standard
> > modprobe to find the right driver when automatically populating bus
> > children from the device tree structure.
> > 
> > Add a prefix parameter, and adjust callers.  For
> > of_register_spi_devices() use the "spi:" prefix.
> > 
> > Signed-off-by: David Daney <david.daney@cavium.com>
> 
> Applied, thanks.  Some notes below...

Wait... why is this necessary?  The module type prefix isn't stored in
the modalias value for any other bus type as far as I can see, and
with this series it appears that the "spi:" prefix may or may not be
present in the modalias.  That doesn't look right.

Why isn't prefixing spi: at uevent time sufficient?  IIUC, modprobe
depends on either UEVENT or the modalias attribute to know which
driver to probe.  It does look like the attribute is missing the spi:
prefix though.  Does the following change work instead of these two
patches?

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3d8f662..da8aac7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -51,7 +51,7 @@ modalias_show(struct device *dev, struct device_attribute *a, char *buf)
 {
        const struct spi_device *spi = to_spi_device(dev);
 
-       return sprintf(buf, "%s\n", spi->modalias);
+       return sprintf(buf, "%s%s\n", SPI_MODULE_PREFIX, spi->modalias);
 }

So, I've dropped this patch from my tree.  If the change above works
for you then I'll push it out.

g.
