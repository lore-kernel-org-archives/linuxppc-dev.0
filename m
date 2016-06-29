Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfy4b3Xy2zDqyT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 08:28:30 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5TMO99e073786
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 18:28:28 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23uuhu9g4g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 18:28:28 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 30 Jun 2016 08:28:26 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 495F73578053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 08:28:24 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5TMSOWB3735906
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 08:28:24 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5TMSNmN031086
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 08:28:23 +1000
Subject: Re: [PATCH] cxl: Fix NULL pointer dereference on kernel contexts with
 no AFU interrupts
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 mikey <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
References: <1467226517-29098-1-git-send-email-imunsie@au.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 30 Jun 2016 08:28:20 +1000
MIME-Version: 1.0
In-Reply-To: <1467226517-29098-1-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <ac33c4a3-544f-2917-1cd7-14c62f176522@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 30/06/16 04:55, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
>
> If a kernel context is initialised and does not have any AFU interrupts
> allocated it will cause a NULL pointer dereference when the context is
> detached since the irq_names list will not have been initialised.
>
> Move the initialisation of the irq_names list into the cxl_context_init
> routine so that it will be valid for the entire lifetime of the context
> and will not cause a NULL pointer dereference.
>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>

As it's nice having your machine not crash on every shutdown...

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
