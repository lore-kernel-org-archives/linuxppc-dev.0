Return-Path: <benh@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5C3AE140B00
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 17:15:06 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 6 May 2014 17:15:04 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id F28413578047
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 17:15:00 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s467Ekll11141402
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 May 2014 17:14:46 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s467F0cC027809
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 May 2014 17:15:00 +1000
Message-ID: <1399360499.20388.107.camel@pasglop>
Subject: Re: [PATCH RFC 00/22] EEH Support for VFIO PCI devices on PowerKVM
 guest
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Alexander Graf <agraf@suse.de>
Date: Tue, 06 May 2014 17:14:59 +1000
In-Reply-To: <536887A3.30703@suse.de>
References: <1399253291-3975-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <53677C6C.8060508@suse.de> <1399298412.24318.521.camel@ul30vt.home>
 <20140506042622.GA24228@shangw> <536887A3.30703@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-05-06 at 08:56 +0200, Alexander Graf wrote:
> > For the error injection, I guess I have to put the logic token
> management
> > into QEMU and error injection request will be handled by QEMU and
> then
> > routed to host kernel via additional syscall as we did for pSeries.
> 
> Yes, start off without in-kernel XICS so everything simply lives in 
> QEMU. Then add callbacks into the in-kernel XICS to inject these 
> interrupts if we don't have wide enough interfaces already.

It's got nothing to do with XICS ... :-)

But yes, we can route everything via qemu for now, then we'll need
at least one of the call to have a "direct" path but we should probably
strive to even make it real mode if that's possible, it's the one that
Linux will call whenever an MMIO returns all f's to check if the
underlying PE is frozen.

But we can do that as a second stage.

In fact going via VFIO ioctl's does make the whole security and
translation model much simpler initially.

Cheers,
Ben.
