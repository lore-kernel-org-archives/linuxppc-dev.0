Return-Path: <avorontsov@ru.mvista.com>
Date: Wed, 15 Apr 2009 03:39:39 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2.6.30] fsl_devices.h: Bring the legacy
	fsl_spi_platform_data hooks back
Message-ID: <20090414233939.GA15492@oksana.dev.rtsoft.ru>
References: <1239733836.5344.83.camel@subratamodak.linux.ibm.com>
	<fa686aa40904141142s3717812ep293973fefce8853d@mail.gmail.com>
	<20090414212724.GA12371@oksana.dev.rtsoft.ru>
	<fa686aa40904141431q2f7575a1sd4ada4ee611b6426@mail.gmail.com>
	<20090414215124.GA20534@oksana.dev.rtsoft.ru>
	<fa686aa40904141454s6bc4d226x8bfb66de5d2d8887@mail.gmail.com>
	<20090414220237.GA21581@oksana.dev.rtsoft.ru>
	<fa686aa40904141519w73f3f724m1393e9ae7e437021@mail.gmail.com>
	<20090414222753.GA26006@oksana.dev.rtsoft.ru>
	<fa686aa40904141603u6b533fcfs401e09b718d35ed3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <fa686aa40904141603u6b533fcfs401e09b718d35ed3@mail.gmail.com>
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	David Brownell <dbrownell@users.sourceforge.net>, Greg KH <greg@kroah.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	linux-next <linux-next@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>, subrata@linux.vnet.ibm.com,
	Alexander Beregalov <a.beregalov@gmail.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In commit 364fdbc00fbdd409ade63500710123fe323aa164 ("spi_mpc83xx:
rework chip selects handling"), I merged activate_cs and deactivate_cs
hooks into cs_control, but I overlooked that mpc52xx_psc_spi driver
is using these hooks too. And that resulted in the following build
failure:

CC      drivers/spi/mpc52xx_psc_spi.o
drivers/spi/mpc52xx_psc_spi.c: In function 'mpc52xx_psc_spi_do_probe':
drivers/spi/mpc52xx_psc_spi.c:398: error: 'struct fsl_spi_platform_data'
has no member named 'activate_cs'
drivers/spi/mpc52xx_psc_spi.c:399: error: 'struct fsl_spi_platform_data'
has no member named 'deactivate_cs'
make[2]: *** [drivers/spi/mpc52xx_psc_spi.o] Error 1

This patch simply adds the legacy hooks back for 2.6.30, and for
2.6.31 we'll convert the driver to ->cs_control.

Reported-by: Subrata Modak <subrata@linux.vnet.ibm.com>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

On Tue, Apr 14, 2009 at 05:03:52PM -0600, Grant Likely wrote:
[...]
> > Hm. struct fsl_spi_platform_data is still there. It's just there
> > is no two functions (activate_cs and deactivate_cs) any longer,
> > there's just one: cs_ontrol that takes "spi_device" and "on"
> > arguments).
> >
> > And the build fix (down below) is trivial.
> 
> Regardless of how trivial the build fix is for in-tree, I'm not
> thrilled with breaking out of tree users.  I don't bend over backwards
> for out-of-tree, but the decision should be intentional and not forced
> into, especially during the stabilization period.  Please add the
> hooks back for 2.6.30.  You can send another patch targeted at 2.6.31
> -next to remove them again so that it can be discussed properly on the
> list.

Okay. Here it is.

 include/linux/fsl_devices.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index f2a78b5..0cde180 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -83,6 +83,10 @@ struct fsl_spi_platform_data {
 	u16	max_chipselect;
 	void	(*cs_control)(struct spi_device *spi, bool on);
 	u32	sysclk;
+
+	/* Legacy hooks, used by mpc52xx_psc_spi driver. */
+	void	(*activate_cs)(u8 cs, u8 polarity);
+	void	(*deactivate_cs)(u8 cs, u8 polarity);
 };
 
 struct mpc8xx_pcmcia_ops {
-- 
1.6.2.2
