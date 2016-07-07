Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlSN03fKJzDqxv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 16:27:28 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u676ODOW115467
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 02:27:25 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2415xmnbs1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jul 2016 02:27:25 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 7 Jul 2016 16:27:22 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B6A852BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 16:27:19 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u676RJbM2818448
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 16:27:19 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u676RJap002258
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 16:27:19 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: "andrew.donnellan" <andrew.donnellan@au1.ibm.com>
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Huy Nguyen <huyn@mellanox.com>, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH 14/14] cxl: Add cxl_check_and_switch_mode() API to switch
 bi-modal cards
In-reply-to: <23e62784-d67a-1e08-ed60-99a50a15b249@au1.ibm.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
 <1467638532-9250-15-git-send-email-imunsie@au.ibm.com>
 <577D533E.4030605@linux.vnet.ibm.com>
 <23e62784-d67a-1e08-ed60-99a50a15b249@au1.ibm.com>
Date: Thu, 07 Jul 2016 16:26:47 +1000
Message-Id: <1467872513-sup-7704@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from andrew.donnellan's message of 2016-07-07 11:18:37 +1000:
> > This is to balance the 'get' done in cxl_check_and_switch_mode(), right?
> > A comment wouldn't hurt. I think we're missing the 'put' on the first
> > error path above (!bridge).
> 
> Yep, it's to balance the pci_dev_get() in cxl_check_and_switch_mode() - 
> you're right, a comment to that effect wouldn't hurt.
> 
> You're also right about the error path. Will fix in V2.

We could probably use a dedicated error label for all the error paths
before the pci_dev_put in the main function so we don't need it in every
error path.

> > I was half-expecting to see a new entry in the cxl_pci_tbl pci ID table
> > for the Mellanox entry, but no such thing. By what magic is cxl_probe()
> > called after the switch? Because of the device class?
> 
> It matches against the class, as function 0 of the device after reset 
> comes up as a class 1200 processing accelerator.
> 
> Perhaps we should be a bit more explicit though...

If we explicitly match the Vendor + Device ID we will also match the
networking functions, which we can't do, because before the mode switch
there *IS* a CAPI VSEC in one of the networking functions and our driver
would mistake it as a generic accelerator and try to initialise it. We
could add a comment to this effect to the PCI ID table.

Cheers,
-Ian
