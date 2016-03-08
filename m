Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AE2E21A045E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 04:55:57 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Tue, 8 Mar 2016 10:55:55 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id CBAB53E40055
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 10:55:22 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u28HtMYv38273120
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Mar 2016 10:55:22 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u28HtMWb020950
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Mar 2016 10:55:22 -0700
Subject: Re: [PATCH 3/7] cxlflash: Split out context initialization
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
References: <1457128424-53017-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1457128520-53056-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1457128520-53056-3-git-send-email-ukrishn@linux.vnet.ibm.com>
Cc: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Message-ID: <56DF120B.8080901@linux.vnet.ibm.com>
Date: Tue, 8 Mar 2016 11:55:23 -0600
MIME-Version: 1.0
In-Reply-To: <1457128520-53056-3-git-send-email-ukrishn@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 3/4/2016 3:55 PM, Uma Krishnan wrote:
> From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
>
> Presently, context information structures are allocated and
> initialized in the same routine, create_context(). This imposes
> an ordering restriction such that all pieces of information needed
> to initialize a context must be known before the context is even
> allocated.
>
> This design point is not flexible when the order of context
> creation needs to be modified. Specifically, this can lead to
> problems when members of the context information structure are
> a part of an ordering dependency (i.e. - the 'work' structure
> embedded within the context).
>
> To remedy, the allocation is left as-is, inside of the existing
> create_context() routine and the initialization is transitioned
> to a new void routine, init_context(). At the same time, in
> anticipation of these routines not being called in sequence, a
> state boolean is added to the context information structure to
> track when the context has been initilized. The context teardown
> routine, destroy_context(), is modified to support being called
> with a non-initialized context.
>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>

Reviewed-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
