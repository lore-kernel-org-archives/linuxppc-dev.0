Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E8331A0336
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 19:57:55 +1100 (AEDT)
Received: from localhost
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 25 Nov 2015 08:57:49 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4C9851B08069
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 08:58:10 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAP8vlDX10486078
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 08:57:47 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAP8va4U004850
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 01:57:45 -0700
Subject: Re: [PATCH] cxl: Fix DSI misses when the context owning task exits
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1448362578-32456-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Cc: Frank Haverkamp <HAVERKAM@de.ibm.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, imunsie@au1.ibm.com
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-ID: <565577FF.9020000@linux.vnet.ibm.com>
Date: Wed, 25 Nov 2015 09:57:35 +0100
MIME-Version: 1.0
In-Reply-To: <1448362578-32456-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 24/11/2015 11:56, Vaibhav Jain a écrit :
> Presently when a user-space process issues CXL_IOCTL_START_WORK ioctl we
> store the pid of the current task_struct and use it to get pointer to
> the mm_struct of the process, while processing page or segment faults
> from the capi card. However this causes issues when the thread that had
> originally issued the start-work ioctl exits in which case the stored
> pid is no more valid and the cxl driver is unable to handle faults as
> the mm_struct corresponding to process is no more accessible.
>
> This patch fixes this issue by using the mm_struct of the next alive
> task in the thread group. This is done by iterating over all the tasks
> in the thread group starting from thread group leader and calling
> get_task_mm on each one of them. When a valid mm_struct is obtained the
> pid of the associated task is stored in the context replacing the
> exiting one for handling future faults.
>
> The patch introduces a new function named get_mem_context that checks if
> the current task pointed to by ctx->pid is dead? If yes it performs the
> steps described above. Also a new variable cxl_context.glpid is
> introduced which stores the pid of the thread group leader associated
> with the context owning task.
>
> Reported-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Reported-by: Frank Haverkamp <HAVERKAM@de.ibm.com>
> Suggested-by: Ian Munsie <imunsie@au1.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

Looks good to me. Thanks!

Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
