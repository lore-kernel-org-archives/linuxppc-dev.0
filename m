Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 782DE1A02EA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 14:11:02 +1100 (AEDT)
In-Reply-To: <1446552832-17592-1-git-send-email-fbarrat@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org
Subject: Re: cxl: Fix struct pid leak when attaching a process through user API
Message-Id: <20160126031102.1CE27140317@ozlabs.org>
Date: Tue, 26 Jan 2016 14:11:02 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-03-11 at 12:13:52 UTC, Frederic Barrat wrote:
> When the cxl driver creates a context, it stores the pid of the
> calling task, and mistakenly increments the reference count of the
> struct pid twice, once through get_task_pid(), once through
> get_pid(). The reference count is only decremented once on detach. As
> a result, a struct pid is leaked and it reduces the number of
> processes that can run simultaneously by one.
> The fix is to simply remove the call to get_pid().
> 
> There is a separate patch for the kernel API, since it goes to
> different kernel versions.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Cc: <stable@vger.kernel.org> # 3.18+
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

This no longer applies, since we merged 7b8ad495d592 ("cxl: Fix DSI misses when
the context owning task exits").

Please resend if it's still applicable.

cheers
