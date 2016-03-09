Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B9E491A00BC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 04:08:14 +1100 (AEDT)
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8DDB81401DE
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 04:08:13 +1100 (AEDT)
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 9 Mar 2016 17:08:10 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2277517D8056
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2016 17:08:37 +0000 (GMT)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u29H887a2818412
 for <linuxppc-dev@ozlabs.org>; Wed, 9 Mar 2016 17:08:08 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u29H88WM020808
 for <linuxppc-dev@ozlabs.org>; Wed, 9 Mar 2016 10:08:08 -0700
Subject: Re: [PATCH v3 1/2] cxl: Add mechanism for delivering AFU driver
 specific events
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <michaele@au1.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Matt Ochs <mrochs@us.ibm.com>, Manoj Kumar <kumarmn@us.ibm.com>
References: <1457401715-26435-1-git-send-email-imunsie@au.ibm.com>
 <87a8m7iunv.fsf@vajain21.in.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael Neuling <mikey@neuling.org>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-ID: <56E05876.6090006@linux.vnet.ibm.com>
Date: Wed, 9 Mar 2016 18:08:06 +0100
MIME-Version: 1.0
In-Reply-To: <87a8m7iunv.fsf@vajain21.in.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Vaibhav,

Le 09/03/2016 15:37, Vaibhav Jain a écrit :

> I would propose these two apis.
>
> /*
> *  fetches an event from the driver event queue. NULL means that queue
> *  is empty. Can sleep if needed. The memory for cxl_event is allocated
> *  by module being called. Hence it can be potentially be larger then
> *  sizeof(struct cxl_event). Multiple calls to this should return same
> *  pointer untill ack_event is called.
> */
> struct cxl_event * fetch_event(struct cxl_context * ctx);
>
> /*
> * Returns and acknowledge the struct cxl_event * back to the driver
> * which can then free it or maybe put it back in a kmem_cache. This
> * should be called once we have completely returned the current
> * struct cxl_event from the readcall
> */
> void ack_event(struct cxl_context * ctx, struct cxl_event *);


How would you implement polling on those APIs?
How would you implement afu_read? There are several sources of events.

   Fred
