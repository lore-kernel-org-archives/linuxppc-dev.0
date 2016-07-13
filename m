Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rq5jg5h10zDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 14:40:22 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D4dK9U101309
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 00:40:20 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24566wndte-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 00:40:19 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 13 Jul 2016 14:40:10 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D09B73578057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 14:40:08 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6D4e8VN13041788
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 14:40:08 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6D4e81T012856
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 14:40:08 +1000
Subject: Re: [PATCH 10/15] cxl: Add preliminary workaround for CX4 interrupt
 limitation
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
References: <1468237822-26276-1-git-send-email-imunsie@au.ibm.com>
 <1468237822-26276-11-git-send-email-imunsie@au.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 13 Jul 2016 14:40:07 +1000
MIME-Version: 1.0
In-Reply-To: <1468237822-26276-11-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <0ce2413d-9314-a345-bb01-9875ca24d77f@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/07/16 21:50, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
>
> The Mellanox CX4 has a hardware limitation where only 4 bits of the
> AFU interrupt number can be passed to the XSL when sending an interrupt,
> limiting it to only 15 interrupts per context (AFU interrupt number 0 is
> invalid).
>
> In order to overcome this, we will allocate additional contexts linked
> to the default context as extra address space for the extra interrupts -
> this will be implemented in the next patch.
>
> This patch adds the preliminary support to allow this, by way of adding
> a linked list in the context structure that we use to keep track of the
> contexts dedicated to interrupts, and an API to simultaneously iterate
> over the related context structures, AFU interrupt numbers and hardware
> interrupt numbers. The point of using a single API to iterate these is
> to hide some of the details of the iteration from external code, and to
> reduce the number of APIs that need to be exported via base.c to allow
> built in code to call.
>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
