Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyP0d6NG4zDqZv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 14:34:57 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, hemant@linux.vnet.ibm.com, anju@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/perf: Fix for core/nest imc call trace on
 cpuhotplug
In-Reply-To: <1505151134-26128-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1505151134-26128-1-git-send-email-anju@linux.vnet.ibm.com>
Date: Thu, 21 Sep 2017 14:34:57 +1000
Message-ID: <87r2v0d5zi.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:

> Nest/core pmu units are enabled only when it is used. A reference count is
> maintained for the events which uses the nest/core pmu units. Currently in
> *_imc_counters_release function a WARN() is used for notification of any
> underflow of ref count. Replace WARN() with a pr_info since it is an overkill.

As discussed elsewhere this is not the right solution.

If it's OK for the reference count to be negative, then we shouldn't
print anything when it is.

But I don't understand how it can be OK for the refcount to be negative.
That means someone has a negative number of references to something?

cheers
