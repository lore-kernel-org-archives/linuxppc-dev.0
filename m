Return-Path: <andrew.vasquez@qlogic.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5513EB7BAA
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  1 Aug 2009 02:59:06 +1000 (EST)
Received: from avexch1.qlogic.com (avexch1.qlogic.com [198.70.193.115])
	by ozlabs.org (Postfix) with ESMTP id D950FDDDA0
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Aug 2009 02:59:05 +1000 (EST)
Date: Fri, 31 Jul 2009 09:47:00 -0700
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 1/3] Support for PCI Express reset type
Message-ID: <20090731164700.GC23800@n5105in79bv1s.qlogic.org>
References: <4A721FB1.4040903@us.ibm.com> <87hbws3jvx.fsf@basil.nowhere.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87hbws3jvx.fsf@basil.nowhere.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Richard Lary <rlary@us.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linasvepstas@gmail.com" <linasvepstas@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 31 Jul 2009, Andi Kleen wrote:

> Mike Mason <mmlnx@us.ibm.com> writes:
> >
> > These patches supersede the previously submitted patch that
> > implemented a fundamental reset bit field. 
> >
> > Please review and let me know of any concerns.
> 
> Any plans to implement that for x86 too? Right now it seems to be a PPC
> specific hack.

Are there any non-PPC platforms which support EEH slot-reset?

> And where is the driver that is using it?

That would be the qla2xxx (FC/FCoE storage) and qlge (10gb NIC
) drivers.  Changes to the drivers could look something like:

Index: b/drivers/net/qlge/qlge_main.c
===================================================================
--- a/drivers/net/qlge/qlge_main.c
+++ b/drivers/net/qlge/qlge_main.c
@@ -4289,6 +4289,9 @@ static int __devinit qlge_probe(struct p
 		return err;
 	}
 
+	/* Set EEH reset type to fundamental for this device */
+	pdev->needs_freset = 1;
+
 	qdev = netdev_priv(ndev);
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 	ndev->features = (0
Index: b/drivers/scsi/qla2xxx/qla_os.c
===================================================================
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1773,6 +1773,10 @@ qla2x00_probe_one(struct pci_dev *pdev, 
 	/* Set ISP-type information. */
 	qla2x00_set_isp_flags(ha);
 
+	/* Set EEH reset type to fundamental if required by hba  */
+	if (IS_QLA24XX(ha) || IS_QLA25XX(ha) || IS_QLA81XX(ha))
+		pdev->needs_freset = 1;
+
 	/* Configure PCI I/O space */
 	ret = qla2x00_iospace_config(ha);
 	if (ret)


once the infrastructure changes were hashed out.

-- av
