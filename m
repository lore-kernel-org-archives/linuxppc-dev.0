Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqWZD3WlxzDqFV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:05:23 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6DL3Qvk086034
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 17:05:21 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2452xsc8yn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 17:05:21 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 14 Jul 2016 07:05:19 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C3C9F2BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:05:16 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6DL5Gfg20906054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:05:16 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6DL5GwX016584
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:05:16 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: "andrew.donnellan" <andrew.donnellan@au1.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Huy Nguyen <huyn@mellanox.com>
Subject: Re: [PATCH 05/15] cxl: Allow a default context to be associated with
 an external pci_dev
In-reply-to: <0a7c4db6-7f48-be69-81e0-ca1ede3f6cea@au1.ibm.com>
References: <1468237822-26276-1-git-send-email-imunsie@au.ibm.com>
 <1468237822-26276-6-git-send-email-imunsie@au.ibm.com>
 <0a7c4db6-7f48-be69-81e0-ca1ede3f6cea@au1.ibm.com>
Date: Thu, 14 Jul 2016 07:05:14 +1000
Message-Id: <1468442596-sup-1930@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from andrew.donnellan's message of 2016-07-13 15:52:45 +1000:
> > +bool _cxl_pci_associate_default_context(struct pci_dev *dev, struct cxl_afu *afu)
> 
> If we're sharing these functions between the vPHB and peer models, do we 
> have a better place than vphb.c for them?

Sure, I might split them out into a new phb.c for V3. It just seemed a
little pointless to create a new file for two functions at the time, but
you are right that they don't really belong in vphb.c. I guess an
alternative would be to rename vphb.c to phb.c, but 90% of that file is
vphb specific... I'll split these out.

> > +{
> > +    struct cxl_context *ctx;
> > +
> > +    /*
> > +     * Allocate a context to do cxl things too. This is used for interrupts
> 
> s/too/to/?

Heh, the one part of the comment that I didn't change from Mikey's code ;-P

Will fix.

Cheers,
-Ian
