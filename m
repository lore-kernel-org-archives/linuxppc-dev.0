Return-Path: <ossthema@de.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E37D6DE6B6
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 01:44:50 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id m8NFhjXO111748
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 15:43:45 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m8NFhj6w3252362
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 17:43:45 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m8NFhfoS016737
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 17:43:41 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: Sebastien Dugue <sebastien.dugue@bull.net>
Subject: Re: [PATCH HACK] powerpc: quick hack to get a functional eHEA with
	hardirq preemption, eHCA is close
Date: Tue, 23 Sep 2008 17:43:23 +0200
References: <20080915100406.342e027a@bull.net>
	<OFD7842B7A.ADC47EED-ONC12574C8.003A2CB3-C12574C8.003AC948@de.ibm.com>
	<20080918143146.77db81d5@bull.net>
In-Reply-To: <20080918143146.77db81d5@bull.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809231743.23828.ossthema@de.ibm.com>
Cc: Thomas Q Klein <TKLEIN@de.ibm.com>, tinytim@us.ibm.com,
	Linux-rt <linux-rt-users@vger.kernel.org>,
	Jan-Bernd Themann <THEMANN@de.ibm.com>, netdev@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	jean-pierre.dion@bull.net, linux-ppc <linuxppc-dev@ozlabs.org>,
	Benjamin Herrenschmidt <bherren@au1.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>,
	Christoph Raisch <RAISCH@de.ibm.com>, gilles.carry@ext.bull.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I think these are the "functional" changes that need to be included in
the ibmebus driver. We'll add a RT flag in the final version to enable
these changes only for RT-Linux for now. 
Ben, can you / your team look into the implementation
of the set_irq_type functionality needed for XICS?

Regards,
Jan-Bernd & Christoph

diff -Nurp b/arch/powerpc/kernel/ibmebus.c a/arch/powerpc/kernel/ibmebus.c
--- b/arch/powerpc/kernel/ibmebus.c	2008-09-22 00:29:55.000000000 +0200
+++ a/arch/powerpc/kernel/ibmebus.c	2008-09-23 12:04:53.000000000 +0200
@@ -216,12 +216,16 @@ int ibmebus_request_irq(u32 ist, irq_han
 			unsigned long irq_flags, const char *devname,
 			void *dev_id)
 {
+	int ret;
 	unsigned int irq = irq_create_mapping(NULL, ist);
 
 	if (irq == NO_IRQ)
 		return -EINVAL;
 
-	return request_irq(irq, handler, irq_flags, devname, dev_id);
+	ret = request_irq(irq, handler, irq_flags, devname, dev_id);
+	set_irq_type(irq, IRQ_TYPE_EDGE_RISING);
+
+	return ret;
 }
 EXPORT_SYMBOL(ibmebus_request_irq);
 
