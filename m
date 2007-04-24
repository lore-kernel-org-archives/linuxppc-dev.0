Return-Path: <FENKES@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BB867DDF1B
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 22:07:12 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id l3OC72GH264216
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 12:07:02 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l3OC72I53776670
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 14:07:02 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l3OC71Pe032310
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 14:07:01 +0200
In-Reply-To: <ada7is27vdv.fsf@cisco.com>
To: Roland Dreier <rdreier@cisco.com>
MIME-Version: 1.0
Subject: Re: [PATCH] ib_core: Add missing device link to class device
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OF8C8AA8EC.A66DAC49-ONC12572C7.00416B4B-C12572C7.00428AF7@de.ibm.com>
Date: Tue, 24 Apr 2007 14:06:59 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, LKML <linux-kernel@vger.kernel.org>,
	OF-General <general@lists.openfabrics.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roland Dreier <rdreier@cisco.com> wrote on 23.04.2007 21:17:48:

> Hmm, I have links like this on my system already:
> 
> the patch actually looks sane but I don't understand why it's needed.
> Could you explain?

I had a look at the kernel code -- currently, all device drivers except
ehca do this by themselves:

cxgb3:
1110         dev->ibdev.dma_device = &(dev->rdev.rnic_info.pdev->dev);
1111         dev->ibdev.class_dev.dev = &(dev->rdev.rnic_info.pdev->dev);

amso1100:
798         dev->ibdev.dma_device = &dev->pcidev->dev;
799         dev->ibdev.class_dev.dev = &dev->pcidev->dev;

ipath:
1559         dev->dma_device = &dd->pcidev->dev;
1560         dev->class_dev.dev = dev->dma_device;

mthca:
1295         dev->ib_dev.dma_device           = &dev->pdev->dev;
1296         dev->ib_dev.class_dev.dev        = &dev->pdev->dev;

So I think it makes a lot of sense to put the class_dev.dev assignment
into generic ib_core code instead of repeating it in all the drivers.
The respective lines could move out of the drivers in the future but
won't hurt anyone until then.

What's your take on this?

Cheers,
  Joachim

---
Joachim Fenkes  --  eHCA Linux Driver Developer and Hardware Tamer
IBM Deutschland Entwicklung GmbH  --  Dept. 3627 (I/O Firmware Dev. 2)
Schoenaicher Strasse 220  --  71032 Boeblingen  --  Germany
eMail: fenkes@de.ibm.com  --  Phone: +49 7031 16 1239 
