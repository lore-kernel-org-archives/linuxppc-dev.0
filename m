Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6698E1A012A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 15:59:54 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 13 Apr 2015 23:59:52 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 97BCD3E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 23:59:49 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3E5vvi028704800
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 22:57:57 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3E5xntu023221
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 23:59:49 -0600
Message-ID: <552CACD2.5060600@linux.vnet.ibm.com>
Date: Tue, 14 Apr 2015 11:29:46 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 3/3] powerpc/powernv: Introduce sysfs control for
 fastsleep workaround behavior
References: <1428976613-13007-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1428976613-13007-4-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1428976613-13007-4-git-send-email-shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Shreyas,

On 04/14/2015 07:26 AM, Shreyas B. Prabhu wrote:
> Fastsleep is one of the idle state which cpuidle subsystem currently
> uses on power8 machines. In this state L2 cache is brought down to a
> threshold voltage. Therefore when the core is in fastsleep, the
> communication between L2 and L3 needs to be fenced. But there is a bug
> in the current power8 chips surrounding this fencing.
> 
> OPAL provides a workaround which precludes the possibility of hitting
> this bug. But running with this workaround applied causes checkstop
> if any correctable error in L2 cache directory is detected. Hence OPAL
> also provides a way to undo the workaround.
> 
> In the existing implementation, workaround is applied by the last thread
> of the core entering fastsleep and undone by the first thread waking up.
> But this has a performance cost. These OPAL calls account for roughly
> 4000 cycles everytime the core has to enter or wakeup from fastsleep.
> 
> This patch introduces a sysfs attribute (fastsleep_workaround_state)
> to choose the behavior of this workaround.
> 
> By default, fastsleep_workaround_state = dynamic. In this case, workaround
> is applied/undone everytime the core enters/exits fastsleep.
> 
> fastsleep_workaround_state = applyonce. In this case the workaround is
> applied once on all the cores and never undone. This can be triggered by
> echo applyonce > /sys/devices/system/cpu/fastsleep_workaround_state

I was wondering if we really need such an elaborate design for this
sysfs file. Why not a sysfs file called fastsleep_workaround_apply_once,
which is set to '0' by default and the only value that it can take is
'1' ? The name easily implies that the workaround is applied only once
if it is set. I can see that this can cut down a good chunk of code from
this patch. I just didn't find too much value in having so much code for
a simple 'on' knob.

Regards
Preeti U Murthy
