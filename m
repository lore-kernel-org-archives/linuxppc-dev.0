Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rg8f10wDXzDqyk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 16:24:40 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5U6NpCN033933
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 02:24:39 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23usub9dvx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 02:24:39 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 30 Jun 2016 16:24:36 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id F3F103578052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 16:24:33 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5U6OXf13539356
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 16:24:33 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5U6OXHT016089
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 16:24:33 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: "andrew.donnellan" <andrew.donnellan@au1.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, mikey <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
Subject: Re: [PATCH] cxl: Fix NULL pointer dereference on kernel contexts with
 no AFU interrupts
In-reply-to: <e17203b8-0662-e110-f6f6-ab41617db45a@au1.ibm.com>
References: <1467226517-29098-1-git-send-email-imunsie@au.ibm.com>
 <ac33c4a3-544f-2917-1cd7-14c62f176522@au1.ibm.com>
 <1467262824.7296.3.camel@ellerman.id.au>
 <e17203b8-0662-e110-f6f6-ab41617db45a@au1.ibm.com>
Date: Thu, 30 Jun 2016 16:24:31 +1000
Message-Id: <1467267733-sup-444@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from andrew.donnellan's message of 2016-06-30 15:15:02 +1000:
> On 30/06/16 15:00, Michael Ellerman wrote:
> > On Thu, 2016-06-30 at 08:28 +1000, Andrew Donnellan wrote:
> >> On 30/06/16 04:55, Ian Munsie wrote:
> >>>
> >>> From: Ian Munsie <imunsie@au1.ibm.com>
> >>>
> >>> If a kernel context is initialised and does not have any AFU interrupts
> >>> allocated it will cause a NULL pointer dereference when the context is
> >>> detached since the irq_names list will not have been initialised.
> >>>
> >>> Move the initialisation of the irq_names list into the cxl_context_init
> >>> routine so that it will be valid for the entire lifetime of the context
> >>> and will not cause a NULL pointer dereference.
> >>>
> >>> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> >
> >> As it's nice having your machine not crash on every shutdown...
> >
> > Fixes: ????
> 
> Ian can correct me if I'm wrong, but I suspect this doesn't affect 
> cxlflash (the only current user of the cxl kernel API) - this issue was 
> hit while working on CAPI support for mlx5.

Correct - no current user hits this bug, but the upcoming mlx5 support
does because of the way it uses interrupts.

-Ian
