Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdL9J2R9VzDrKD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 20:28:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>,
 Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc/powernv/idle: Round up latency and residency
 values
In-Reply-To: <20170823185841.25286-1-svaidy@linux.vnet.ibm.com>
References: <20170823185841.25286-1-svaidy@linux.vnet.ibm.com>
Date: Thu, 24 Aug 2017 20:28:19 +1000
Message-ID: <877extw98c.fsf@concordia.ellerman.id.au>
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

Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> writes:

> On PowerNV platforms, firmware provides exit latency and
> target residency for each of the idle states in nano
> seconds.  Cpuidle framework expects the values in micro
> seconds.  Round up to nearest micro seconds to avoid errors
> in cases where the values are defined as fractional micro
> seconds.
>
> Default idle state of 'snooze' has exit latency of zero.  If
> other states have fractional micro second exit latency, they
> would get rounded down to zero micro second and make cpuidle
> framework choose deeper idle state when snooze loop is the
> right choice.
>
> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

This sounds like a fairly bad bug, does it need a Fixes / Cc stable tag?

cheers
