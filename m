Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Please pull from 'for-2.6.23'
Date: Thu, 30 Aug 2007 01:42:13 +0200
References: <Pine.LNX.4.64.0708291727240.26956@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0708291727240.26956@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708300142.14277.arnd@arndb.de>
Cc: Christian Krafft <krafft@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 30 August 2007, Kumar Gala wrote:
> Please pull from 'for-2.6.23' branch of
> 
> 	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for-2.6.23
> 

I also have a fix for the regression reported by Ishizaki Kou, see below.

I've added that to Kumar's patches and uploaded to my git tree. Please
pull from

master.kernel.org:/pub/scm/linux/kernel/git/arnd/cell-2.6.git for-2.6.23

provided that Jeremy gives his OK.

	Arnd <><

---
Subject: spu_manage: fix spu_unit_number for celleb device tree

From: Christian Krafft <krafft@de.ibm.com>
This fixes a regression introduced with 2.6.23-rc4 after on some
confusion about the device tree interfaces.

IBM QS21 device trees provide "physical-id", so we changed the code to
run on that and remain compatible with all IBM machines.

However, the Toshiba Celleb device tree provides the "unit-id" property,
which was in the Linux code, but never used in this way on IBM hardware.

Legacy device tree used the reg property for the physical id of an spe.
This patch fixes find_spu_unit_number to look for the spu id in that order.
The length is checked to avoid misinterpretation in case the attributes
unit-id or reg do not contain the id.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Cc: Jeremy Kerr <jk@ozlabs.org>
Cc: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>

Index: linux-2.6/arch/powerpc/platforms/cell/spu_manage.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spu_manage.c
+++ linux-2.6/arch/powerpc/platforms/cell/spu_manage.c
@@ -48,10 +48,18 @@ static u64 __init find_spu_unit_number(s
 {
 	const unsigned int *prop;
 	int proplen;
+
+	/* new device trees should provide the physical-id attribute */
 	prop = of_get_property(spe, "physical-id", &proplen);
 	if (proplen == 4)
 		return (u64)*prop;
 
+	/* celleb device tree provides the unit-id */
+	prop = of_get_property(spe, "unit-id", &proplen);
+	if (proplen == 4)
+		return (u64)*prop;
+
+	/* legacy device trees provide the id in the reg attribute */
 	prop = of_get_property(spe, "reg", &proplen);
 	if (proplen == 4)
 		return (u64)*prop;
