Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svxDl3rCczDt0f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 03:35:51 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9DGSRAC107771
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 12:35:48 -0400
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26286w662j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 12:35:48 -0400
Received: from localhost
 by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Thu, 13 Oct 2016 17:35:46 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 108FE17D8056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 17:37:53 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9DGZiFq29753468
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 16:35:44 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9DGZhDb030455
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 10:35:44 -0600
Subject: Re: [PATCH v3] cxl: Prevent adapter reset if an active context exists
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1476356908-302-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, gkurz@linux.vnet.ibm.com
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Thu, 13 Oct 2016 18:35:43 +0200
MIME-Version: 1.0
In-Reply-To: <1476356908-302-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <0b835a13-db86-bba8-2c74-6250e15da62d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Vaibhav,


Le 13/10/2016 à 13:08, Vaibhav Jain a écrit :
> This patch prevents resetting the cxl adapter via sysfs in presence of
> one or more active cxl_context on it. This protects against an
> unrecoverable error caused by PSL owning a dirty cache line even after
> reset and host tries to touch the same cache line. In case a force reset
> of the card is required irrespective of any active contexts, the int
> value -1 can be stored in the 'reset' sysfs attribute of the card.
>
> The patch introduces a new atomic_t member named contexts_num inside
> struct cxl that holds the number of active context attached to the card
> , which is checked against '0' before proceeding with the reset. To
> prevent against a race condition where a context is activated just after
> reset check is performed, the contexts_num is atomically set to '-1'
> after reset-check to indicate that no more contexts can be activated on
> the card anymore.
>
> Before activating a context we atomically test if contexts_num is
> non-negative and if so, increment its value by one. In case the value of
> contexts_num is negative then it indicates that the card is about to be
> reset and context activation is error-ed out at that point.
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>


Looks good to me, thanks! And sorry, I could have saved you an iteration.

Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Actually, I guess I'm supposed to do that now:
Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

   Fred
