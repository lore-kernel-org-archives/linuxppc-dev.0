Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound3-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 38A2CDE1E6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Mar 2008 04:36:07 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Ported Xilinx GPIO driver to OpenFirmware.
Date: Tue, 11 Mar 2008 10:35:59 -0700
In-Reply-To: <000001c88392$c38a8c40$4a9fa4c0$@se>
References: <000001c88392$c38a8c40$4a9fa4c0$@se>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Magnus Hjorth" <mh@omnisys.se>,
	"git" <git@xilinx.com>
Message-Id: <20080311173602.8E61C728093@mail209-sin.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Thanks Magnus!

Generally speaking this looks reasonable.  Some comments:

>  struct xgpio_instance {
>  	struct list_head link;
>  	unsigned long base_phys;	/* GPIO base address - physical
*/
>  	unsigned long remap_size;
> -	u32 device_id;
> +	u32 device_id;		/* Dev ID for platform devices, 0 for OF
devices */
> +	void *of_id;		/* of_dev pointer for OF devices, NULL
for plat devices */

Why have separate ids?  I don't think the of_dev needs to be kept around
here.  This driver seems seems awkwardly written to have a local list of
all the devices, rather than simply attaching the xgpio_instance as the
private data of the file.

For instance, in drivers/char/xilinx_hwicap.c:

static ssize_t
hwicap_read(struct file *file, char __user *buf, size_t count, loff_t
*ppos)
{
	struct hwicap_drvdata *drvdata =3D file->private_data;

and the drvdata is set in open:

static int hwicap_open(struct inode *inode, struct file *file)
{
	struct hwicap_drvdata *drvdata;
	int status;

	drvdata =3D container_of(inode->i_cdev, struct hwicap_drvdata,
cdev);
	...
	file->private_data =3D drvdata;

Which would work if xgpio_instance directly contains the struct
miscdevice.
I think this is a much cleaner pattern (although it took me a while to
figure out the magic that makes it work... )

> +static struct of_device_id xgpio_of_match[] =3D {
> +	{.compatible =3D "xlnx,xps-gpio-1.00.a"},

This should also probably contain the corresponding strings for the
following as well:
      opb_gpio_v1_00_a
      opb_gpio_v2_00_a
      opb_gpio_v3_01_a
      opb_gpio_v3_01_b
	plb_gpio_v1_00_b

This would seem to be a relatively easy driver to clean up (by pulling
it all into one file and converting the other code to the kernel style)
and submit to mainline, if you're interested?

Steve
