Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlSW06jJhzDqxv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 16:33:32 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u676T5aj038199
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 02:33:29 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2415xm5nfh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jul 2016 02:33:29 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 7 Jul 2016 16:33:26 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D06F02CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 16:33:23 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u676XNEr8389012
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 16:33:23 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u676XNYK025059
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 16:33:23 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 "andrew.donnellan" <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Huy Nguyen <huyn@mellanox.com>
Subject: Re: [PATCH 07/14] cxl: Add support for using the kernel API with a
 real PHB
In-reply-to: <577D4E51.4040108@linux.vnet.ibm.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
 <1467638532-9250-8-git-send-email-imunsie@au.ibm.com>
 <577D4E51.4040108@linux.vnet.ibm.com>
Date: Thu, 07 Jul 2016 16:32:51 +1000
Message-Id: <1467872962-sup-9472@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Frederic Barrat's message of 2016-07-06 20:30:41 +0200:
> 
> > @@ -1572,6 +1575,9 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
> >            */
> >           for (i = 0; i < adapter->slices; i++) {
> >               afu = adapter->afu[i];
> > +            /* Only participate in EEH if we are on a virtual PHB */
> > +            if (afu->phb == NULL)
> > +                return PCI_ERS_RESULT_NONE;
> >               cxl_vphb_error_detected(afu, state);
> >           }
> 
> 
> Sorry, I had my notes out of order, something is bugging me here. Don't 
> we always define afu->phb, though for Mellanox (or if there's no config 
> record in the general case), we don't have any devices attached to it?

I think you're right. I'll change the vPHB code to skip it if there are
no configuration records.

> Which raises the question of the handling of slot_reset and resume 
> callbacks...

We aren't going to support EEH (at least not yet) - the vPHB model makes
this (relatively) easy since we can notify the AFU drivers when we get
notified, but in the peer model it will be the real PHB notifying us and
the networking drivers. If we do end up supporting that, it will come
later.

Cheers,
-Ian
