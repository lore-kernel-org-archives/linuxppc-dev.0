Return-Path: <domen.puncer@telargo.com>
Received: from kukmak.uni-mb.si (kukmak.uni-mb.si [164.8.100.3])
	by ozlabs.org (Postfix) with ESMTP id D4A55DDF24
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 06:55:11 +1000 (EST)
Date: Wed, 24 Oct 2007 22:54:03 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/2] mpc52xx: stop drivers from accessing clock config
	directly
Message-ID: <20071024205403.GE3369@nd47.coderock.org>
References: <20071024182308.21194.69416.stgit@trillian.cg.shawcable.net>
	<20071024191206.GD3369@nd47.coderock.org>
	<fa686aa40710241314w2dbe0863ja15746614cff0dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
In-Reply-To: <fa686aa40710241314w2dbe0863ja15746614cff0dd@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 24/10/07 14:14 -0600, Grant Likely wrote:
> On 10/24/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> > On 24/10/07 12:24 -0600, Grant Likely wrote:
> > > Domen,
> > >
> > > Here's a real solution to the problem.  I've somewhat tested this on
> > > the lite5200b.  Can you give it a spin on efika and see if SPI still
> > > works for you?
> >
> > My test case was lite5200b too, I don't think I ever tried SPI on
> > efika.
> > (Are even the right pins on irda connector, or is a necessary line
> > missing?)
> 
> Hmm, I guess that's right.  Can you at least make sure it still boots
> on Efika?  Some of the clock detection stuff has changed so I want to
> make sure it still boots.

OK. I'll do that tomorrow.

> 
> Are you setup to do your SPI test easily on you lite5200b?  When I say
> "somewhat" tested; I mean I probed the driver and it didn't crash.
> :-)  I haven't tried to run traffic over it.

Sorry, lite5200b is resting these days. :-(

> 
> Can you check that on your system?  If not, can you email me what
> setup/programs you used for testing?  I know very little about the SPI
> infrastructure.

For userspace part I used something like: Documentation/spi/spidev
And for kernel the attached, to fill get binded to spidev driver.


	Domen

> 
> Thanks,
> g.
> 
> -- 
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195

-- 
Domen Puncer | Research & Development
.............................................................................................
Telargo d.o.o. | Zagrebška cesta 20 | 2000 Maribor | Slovenia
.............................................................................................
www.telargo.com

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=spidev_test_devices

---
 drivers/spi/Makefile           |    1 +
 drivers/spi/spi_test_devices.c |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

Index: work-powerpc.git/drivers/spi/Makefile
===================================================================
--- work-powerpc.git.orig/drivers/spi/Makefile
+++ work-powerpc.git/drivers/spi/Makefile
@@ -35,3 +35,4 @@ obj-$(CONFIG_SPI_SPIDEV)	+= spidev.o
 
 # SPI slave drivers (protocol for that link)
 # 	... add above this line ...
+obj-m				+= spi_test_devices.o
Index: work-powerpc.git/drivers/spi/spi_test_devices.c
===================================================================
--- /dev/null
+++ work-powerpc.git/drivers/spi/spi_test_devices.c
@@ -0,0 +1,38 @@
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/spi/spi.h>
+
+static struct spi_board_info spi_info[7];
+static struct spi_device *spidev[7];
+static int testdev_init(void)
+{
+	struct spi_board_info *info;
+	int i;
+
+	for (i=0; i<7; i++) {
+		struct spi_master *master;
+
+		info = &spi_info[i];
+		//info->max_speed_hz = 2*1000000;
+		info->max_speed_hz = 100000;
+		//info->max_speed_hz = 1*1000000;
+		strcpy(info->modalias, "spidev");
+
+		master = spi_busnum_to_master(i);
+		if (master)
+			spidev[i] = spi_new_device(master, info);
+	}
+	return 0;
+}
+
+static void testdev_exit(void)
+{
+	/* there is no _remove? */
+	/*for (i=0; i<7; i++) {
+	}*/
+}
+
+module_init(testdev_init);
+module_exit(testdev_exit);
+
+MODULE_LICENSE("GPL");

--MGYHOYXEY6WxJCY8--
