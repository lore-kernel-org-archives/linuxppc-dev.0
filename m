Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E4311A0BF2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 20:15:39 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 28 Jan 2015 04:15:36 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 5823E38C8026
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 04:15:33 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0S9FXZ329950114
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 09:15:33 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0S9FW0V019288
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 04:15:32 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>, mpe@ellerman.id.au
Subject: Re: [PATCH V2] cpuidle/powernv: Read target_residency value of idle
 states from DT if available
In-Reply-To: <20150128021044.11166.81418.stgit@preeti.in.ibm.com>
References: <20150128021044.11166.81418.stgit@preeti.in.ibm.com>
Date: Wed, 28 Jan 2015 20:15:28 +1100
Message-ID: <m3wq47w9jj.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rafael.j.wysocki@intel.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Preeti U Murthy <preeti@linux.vnet.ibm.com> writes:
> The device tree now exposes the residency values for different idle states. Read
> these values instead of calculating residency from the latency values. The values
> exposed in the DT are validated for optimal power efficiency. However to maintain
> compatibility with the older firmware code which does not expose residency
> values, use default values as a fallback mechanism. While at it, handle some
> cleanups.

>From a "I just merged the patch that exports these values from firmware"
point of view, using them and falling back looks good.

(I find the hardcoding of snooze in the driver a bit odd, as is the
hardcoding of max power states to 8 - which could bite us in the future
if a future processor has more states... but these aren't problems with
this patch)

Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
