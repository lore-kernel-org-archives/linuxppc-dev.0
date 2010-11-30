Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH v2] PPC4xx: Adding PCI(E) MSI support
From: Michael Ellerman <michael@ellerman.id.au>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20101129183535.GA5603@zod.rchland.ibm.com>
References: <1289852106-17577-1-git-send-email-tmarri@apm.com>
	<20101129183535.GA5603@zod.rchland.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-zKT8P+RD/iZ7hKXafl15"
Date: Tue, 30 Nov 2010 12:30:09 +1100
Message-ID: <1291080609.2648.102.camel@concordia>
Mime-Version: 1.0
Cc: tmarri@apm.com, linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-zKT8P+RD/iZ7hKXafl15
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-11-29 at 13:35 -0500, Josh Boyer wrote:
> On Mon, Nov 15, 2010 at 12:15:06PM -0800, tmarri@apm.com wrote:
> >From: Tirumala Marri <tmarri@apm.com>
> >
> >This patch adds MSI support for 440SPe, 460Ex, 460Sx and 405Ex.
> >
>=20
> My apologies in the delay here.  I was on holiday for a while and never
> got back to review this.  A few notes below.
>=20
> Also, I've added a few patches from Victor for suspend/idle support in
> my next branch that cause a minor conflict with this one.  It's not a
> big deal to fix, but if you rework the patch for the comments, rebasing
> it to my next branch would be appreciated.
>=20
> >diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c b/arch/powerpc/sysdev/ppc4=
xx_msi.c
> >new file mode 100644
> >index 0000000..9ed559f
> >--- /dev/null
> >+++ b/arch/powerpc/sysdev/ppc4xx_msi.c
> >@@ -0,0 +1,311 @@
> >+/*
> >+ * Adding PCI-E MSI support for PPC4XX SoCs.
> >+ *
> >+ * Copyright (c) 2010, Applied Micro Circuits Corporation
> >+ * Authors: 	Tirumala R Marri <tmarri@apm.com>
> >+ * 		Feng Kan <fkan@apm.com>
> >+ *
> >+ * This program is free software; you can redistribute it and/or
> >+ * modify it under the terms of the GNU General Public License as
> >+ * published by the Free Software Foundation; either version 2 of
> >+ * the License, or (at your option) any later version.
> >+ *
> >+ * This program is distributed in the hope that it will be useful,
> >+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >+ * GNU General Public License for more details.
> >+ *
> >+ * You should have received a copy of the GNU General Public License
> >+ * along with this program; if not, write to the Free Software
> >+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
> >+ * MA 02111-1307 USA
> >+ */
> >+
> >+#include <linux/irq.h>
> >+#include <linux/bootmem.h>
> >+#include <linux/pci.h>
> >+#include <linux/msi.h>
> >+#include <linux/of_platform.h>
> >+#include <linux/interrupt.h>
> >+#include <asm/prom.h>
> >+#include <asm/hw_irq.h>
> >+#include <asm/ppc-pci.h>
> >+#include <boot/dcr.h>
>=20
> This still seems weird to include.  Perhaps you should duplicate the
> macros you need into asm/dcr-regs.h or something.
>=20
> >+#include <asm/dcr-regs.h>
> >+#include <asm/msi_bitmap.h>
> >+
> >+#define PEIH_TERMADH	0x00
> >+#define PEIH_TERMADL	0x08
> >+#define PEIH_MSIED	0x10
> >+#define PEIH_MSIMK	0x18
> >+#define PEIH_MSIASS	0x20
> >+#define PEIH_FLUSH0	0x30
> >+#define PEIH_FLUSH1	0x38
> >+#define PEIH_CNTRST	0x48
> >+#define NR_MSI_IRQS	4
> >+
> >+LIST_HEAD(msi_head);
> >+struct ppc4xx_msi {
> >+	u32 msi_addr_lo;
> >+	u32 msi_addr_hi;
> >+	void __iomem *msi_regs;
> >+	int msi_virqs[NR_MSI_IRQS];
> >+	struct msi_bitmap bitmap;
> >+	struct list_head list;
> >+};
> >+
> >+struct ppc4xx_msi_feature {
> >+	u32 ppc4xx_pic_ip;
> >+	u32 msiir_offset;
> >+};
> >+
> >+static int ppc4xx_msi_init_allocator(struct platform_device *dev,
> >+		struct ppc4xx_msi *msi_data)
> >+{
> >+	int err;
> >+
> >+	err =3D msi_bitmap_alloc(&msi_data->bitmap, NR_MSI_IRQS,
> >+			      dev->dev.of_node);
> >+	if (err)
> >+		return err;
> >+
> >+	err =3D msi_bitmap_reserve_dt_hwirqs(&msi_data->bitmap);
> >+	if (err < 0) {
> >+		msi_bitmap_free(&msi_data->bitmap);
> >+		return err;
> >+	}
> >+
> >+	return 0;
> >+}
> >+
> >+static int ppc4xx_setup_msi_irqs(struct pci_dev *dev, int nvec, int typ=
e)
> >+{
> >+	int err =3D 0;
> >+	int int_no =3D -ENOMEM;
> >+	unsigned int virq;
> >+	struct msi_msg msg;
> >+	struct msi_desc *entry;
> >+	struct device_node *msi_dev =3D NULL;
> >+	struct ppc4xx_msi *msi_data =3D dev->dev.platform_data;
> >+
> >+	msi_dev =3D of_find_node_by_name(NULL, "ppc4xx-msi");
> >+	if (msi_dev) {
> >+		err =3D -ENODEV;
> >+		goto out_free;
> >+	}
> >+
> >+	list_for_each_entry(entry, &dev->msi_list, list) {
> >+		list_for_each_entry(msi_data, &msi_head, list) {
> >+			int_no =3D msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
> >+			if(int_no >=3D 0)
> >+				break;
> >+		}
> >+		if(int_no < 0) {
> >+
> >+			err =3D int_no;
> >+			pr_debug("%s: fail allocating msi interrupt\n",
> >+					__func__);
> >+		}
> >+		virq =3D irq_of_parse_and_map(msi_dev, int_no);
> >+		if (virq =3D=3D NO_IRQ) {
> >+			dev_err(&dev->dev, "%s: fail mapping irq\n", __func__);
> >+			msi_bitmap_free_hwirqs(&msi_data->bitmap, int_no, 1);
> >+			err =3D -ENOSPC;
> >+			goto out_free;
> >+		}
> >+		msi_data->msi_virqs[int_no] =3D virq;
> >+		set_irq_data(virq, (void *)int_no);
> >+		dev_dbg(&dev->dev, "%s: virq =3D %d \n", __func__, virq);
> >+
> >+		/* Setup msi address space */
> >+		msg.address_hi =3D msi_data->msi_addr_hi;
> >+		msg.address_lo =3D msi_data->msi_addr_lo;
> >+
> >+		set_irq_msi(virq, entry);
> >+		msg.data =3D int_no;
> >+		write_msi_msg(virq, &msg);
> >+	}
> >+	of_node_put(msi_dev);
> >+	return err;
> >+
> >+out_free:
> >+	of_node_put(msi_dev);
> >+	return err;
>=20
> You can move the label up and get rid of the duplicate of_node_put and
> return calls.

Yes, but the real issue is you shouldn't be looking for the of node in
this routine. It should be stored in the ppc4xx_msi structure at probe
time.

Which raises the question, how are you finding the ppc4xx_msi struct.
You grab it out of the pci_dev's platform_data, but I don't see where
you stashed it in there.

I think you copied that pattern from fsl_msi.c, it works for remove, but
it doesn't work for setup_msi_irqs(). The device you are passed there is
the pci device which is having MSIs enabled, not the device that
represents your MSI controller.

You also have a list of ppc4xx_msi structs, but you never actually use
it, except to add and remove them. But that achieves nothing because you
never try to look them up.

cheers

--=-zKT8P+RD/iZ7hKXafl15
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkz0U54ACgkQdSjSd0sB4dLy4gCgsEkYh/MOoUcUlVo7YptCZv51
6FIAnj61bkVdh+ZgwYM0A7Br3/1rbksp
=M9wL
-----END PGP SIGNATURE-----

--=-zKT8P+RD/iZ7hKXafl15--
