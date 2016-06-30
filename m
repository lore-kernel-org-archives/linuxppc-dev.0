Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgQQf2WnwzDrCX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 02:45:46 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5UGd9MA091305
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 12:45:44 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23uwt93t7u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 12:45:44 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Fri, 1 Jul 2016 02:45:41 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8503D3578053
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 02:45:39 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5UGjdFP2031976
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 02:45:39 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5UGjdCQ010095
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 02:45:39 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: mikey <mikey@neuling.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Huy Nguyen <huyn@mellanox.com>,
 Frederic Barrat <frederic.barrat@fr.ibm.com>
Subject: Re: [PATCH 1/2] cxl: Fix bug where AFU disable operation had no effect
In-reply-to: <57753FA8.1080306@linux.vnet.ibm.com>
References: <1467226286-28547-1-git-send-email-imunsie@au.ibm.com>
 <57752A8A.1020501@linux.vnet.ibm.com>
 <1467298239-sup-4306@x230.ozlabs.ibm.com>
 <57753FA8.1080306@linux.vnet.ibm.com>
Date: Fri, 01 Jul 2016 02:45:37 +1000
Message-Id: <1467305057-sup-6047@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Frederic Barrat's message of 2016-06-30 17:50:00 +0200:
> 
> Le 30/06/2016 17:32, Ian Munsie a écrit :
> >> For dedicated mode, the CAIA recommends an explicit reset of the AFU
> >> >(section 2.1.1).
> > True, I had forgotten that procedure was added to the document before it
> > was made public - I'll update the comment and resend.
> >
> 
> Actually, my point was that for dedicated mode, we shouldn't have the 
> "if" and always reset. It's only for dedicated mode, so it wouldn't 
> impact cx4 and we would stay CAIA-compliant. If one day, there's a xsl 
> with a dedicated mode AFU, they are expected to follow the spec.

Yeah, I thought of that as well while I was updating the patch and
removed that from the dedicated path. I still added a comment to that
path to note that though.

Cheers,
-Ian
