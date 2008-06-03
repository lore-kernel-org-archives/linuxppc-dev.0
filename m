Return-Path: <borntraeger@de.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4008ADE123
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 22:45:22 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id m53CiOLt639122
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jun 2008 12:44:24 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m53CiO9W3281018
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jun 2008 14:44:24 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m53CiNl7016501
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jun 2008 14:44:23 +0200
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Linux PPC devel <linuxppc-dev@ozlabs.org>
Subject: [RFC 0/3]: hvc_console rework for platform without hard irqs
Date: Tue, 3 Jun 2008 14:44:21 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200806031444.21945.borntraeger@de.ibm.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch set if my first attempt to make virtio_console usable on s390.
To do so, I had to change hvc_console, because s390 has no request_irq and
no free_irq.
I want to get feedback from the main users of hvc_console before I proceed.

The basic idea of this patch set is to remove the calls to request_irq and
free_irq and replace them with backend specific callbacks.

Please see the descriptions of the patches for further details:

1/3: hvc_console: rework setup to replace irq functions with callbacks
2/3: virtio_console: use virtqueue notification for hvc_console
3/3: s390: use virtio_console for KVM on s390
