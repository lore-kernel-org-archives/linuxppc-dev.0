Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA6191A0202
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 20:14:03 +1100 (AEDT)
In-Reply-To: <1448362578-32456-1-git-send-email-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Frank Haverkamp <HAVERKAM@de.ibm.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Subject: Re: cxl: Fix DSI misses when the context owning task exits
Message-Id: <20160111091403.79FBE140323@ozlabs.org>
Date: Mon, 11 Jan 2016 20:14:03 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-24-11 at 10:56:18 UTC, Vaibhav Jain wrote:
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
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
> Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7b8ad495d59280b634a7b546f4

cheers
