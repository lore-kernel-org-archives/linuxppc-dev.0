Return-Path: <borntraeger@de.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [194.196.100.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 64651B7B80
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 06:26:34 +1100 (EST)
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id n9FJQUfo019309
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 19:26:30 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id n9FJQT4N2789456
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 20:26:29 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n9FJQS6S008826
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 20:26:29 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] hvc_console: returning 0 from put_chars is not an error
Date: Thu, 15 Oct 2009 21:26:27 +0200
References: <1255557226-4403-1-git-send-email-timur@freescale.com>
	<200910152041.26646.borntraeger@de.ibm.com>
	<4AD770A9.6070509@freescale.com>
In-Reply-To: <4AD770A9.6070509@freescale.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <200910152126.28024.borntraeger@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, brueckner@linux.vnet.ibm.com,
	Timur Tabi <timur@freescale.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Donnerstag 15 Oktober 2009 20:57:45 schrieb Scott Wood:
> Doing it in the backend requires the backend to know whether it's being
> called for printk or for user I/O.  In the latter case, we don't want to
> spin, but rather wait for an IRQ (or poll with a timer if there's no IRQ).

Right. Now you have me convinced that we really should have some logic in 
hvc_console because, its the only place that knows if it came from printk or 
user.

About the backends, there are some that spin until the text is delivered (e.g. 
virtio) , others can drop (e.g. iucv is a connection oriented protocol and it 
will (and has to) drop if there is no connection). 
