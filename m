Return-Path: <htejun@gmail.com>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rV9zn42GhzDqjl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 01:53:57 +1000 (AEST)
Received: by mail-qk0-x244.google.com with SMTP id a186so3355022qkf.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 08:53:57 -0700 (PDT)
Date: Wed, 15 Jun 2016 11:53:50 -0400
From: Tejun Heo <htejun@gmail.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] workqueue: Move wq_update_unbound_numa() to the
 beginning of CPU_ONLINE
Message-ID: <20160615155350.GB24102@mtj.duckdns.org>
References: <cover.1465311052.git.ego@linux.vnet.ibm.com>
 <6b3c7059ec5d2d6157d23d619e4507692a42a5bd.1465311052.git.ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6b3c7059ec5d2d6157d23d619e4507692a42a5bd.1465311052.git.ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Tue, Jun 07, 2016 at 08:44:02PM +0530, Gautham R. Shenoy wrote:
> Currently in the CPU_ONLINE workqueue handler, the
> restore_unbound_workers_cpumask() will never call
> set_cpus_allowed_ptr() for a newly created unbound worker thread.

Hmmm... did you actually verify that this happens?  A new kworker
always gets bound to the cpumask that it's assigned to in
create_worker().

Thanks.

-- 
tejun
