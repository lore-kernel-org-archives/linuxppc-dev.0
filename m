Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyx4k1J7mzDr4V
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 20:40:06 +1000 (AEST)
Date: Thu, 29 Jun 2017 12:39:59 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>, mpe@ellerman.id.au,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org, stewart@linux.vnet.ibm.com,
 dja@axtens.net, eranian@google.com, hemant@linux.vnet.ibm.com
Subject: Re: [PATCH v11 07/10] powerpc/perf: PMU functions for Core IMC and
 hotplugging
In-Reply-To: <766e7d43-0ca9-1e34-2cbe-73d1cbb2ee14@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.20.1706291239070.1861@nanos>
References: <1498676291-24002-1-git-send-email-anju@linux.vnet.ibm.com>
 <1498676291-24002-2-git-send-email-anju@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1706282104290.1890@nanos>
 <766e7d43-0ca9-1e34-2cbe-73d1cbb2ee14@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 29 Jun 2017, Madhavan Srinivasan wrote:
> On Thursday 29 June 2017 01:11 AM, Thomas Gleixner wrote:
> Idea is to handle multiple event session for a given core and
> yes, my bad, current implementation is racy/broken.
> But an alternate approach is to have a per-core mutex and
> per-core ref count to handle this.
> 
> event_init path:
> per-core mutex lock
>   if ( per-core[refcount] == 0) {
>        rc = opal call to start the engine;
>        if (rc on failure) {
>        per-core mutex unlock;
>        log error info;
>        return error;
>        }
>   }
>   increment the per-core[refcount];
> per-core mutex unlock;
> 
> 
> event_destroy path:
> per-core mutex lock
>   decrement the per-core[refcount];
>   if ( per-core[refcount] == 0) {
>      rc = opal call to stop the engine;
>      if (rc on failure) {
>        per-core mutex unlock;
>        log the failure;
>        return error;
>      }
>   } else if ( per-core[refcount] < 0) {
>      WARN()
>      per-core[refcount] = 0;
>   }
> per-core mutext unlock;

Yes, that works and looks about right.

Thanks,

	tglx
