Return-Path: <krafft@de.ibm.com>
Date: Tue, 28 Aug 2007 16:20:11 +0200
From: Christian Krafft <krafft@de.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Cbe-oss-dev] [patch 1/5] spu_manage: use newer physical-id
Message-ID: <20070828162011.5356afaa@localhost>
In-Reply-To: <200708231812.20493.arnd@arndb.de>
References: <20070823.180152.-1300528381.kouish@swc.toshiba.co.jp>
	<200708231812.20493.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, jk@ozlabs.org,
	krafft@de.ibm.com, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 23 Aug 2007 18:12:19 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Thursday 23 August 2007, kou.ishizaki@toshiba.co.jp wrote:
> > Please check "unit-id" if "physical-id" doesn't exist. Because Celleb
> > uses "unit-id" to provide spe_id.

Sorry for the late answer, wasn't on cc
and had to receive all mails of the last 6 month once again :-(

Can you check if the patch below is working with celleb device tree ?

------
Subject: spu_manage: fix spu_unit_number for celleb device tree

From: Christian Krafft <krafft@de.ibm.com>

New device trees provide "physical-id".
Celleb device tree provide the "unit-id".
Legacy device tree used the reg property for the physical id of an spe.
This patch fixes find_spu_unit_number to look for the spu id in that order.
The length is checked to avoid misinterpretation in case the attributes
unit-id or reg do not contain the id.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>

Index: linux/arch/powerpc/platforms/cell/spu_manage.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/arch/powerpc/platforms/cell/spu_manage.c
+++ linux/arch/powerpc/platforms/cell/spu_manage.c
@@ -48,10 +48,18 @@ static u64 __init find_spu_unit_number(s
 {
 	const unsigned int *prop;
 	int proplen;
+
+	/* new device trees should provide the physical-id attribute */
 	prop =3D of_get_property(spe, "physical-id", &proplen);
 	if (proplen =3D=3D 4)
 		return (u64)*prop;
=20
+	/* celleb device tree provides the unit-id */
+	prop =3D of_get_property(spe, "unit-id", &proplen);
+	if (proplen =3D=3D 4)
+		return (u64)*prop;
+
+	/* legacy device trees provide the id in the reg attribute */
 	prop =3D of_get_property(spe, "reg", &proplen);
 	if (proplen =3D=3D 4)
 		return (u64)*prop;


--=20
Mit freundlichen Gr=FCssen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,=20
Linux Kernel Development
IT Specialist
