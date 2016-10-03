Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3snzX429DtzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 10:58:28 +1100 (AEDT)
Message-ID: <1475539094.3784.113.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: During context switch, check before setting
 mm_cpumask
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Balbir Singh <bsingharora@gmail.com>, Anton Blanchard <anton@ozlabs.org>,
 paulus@samba.org, mpe@ellerman.id.au, npiggin@gmail.com, cyrilbur@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 04 Oct 2016 10:58:14 +1100
In-Reply-To: <b0537503-e415-ec23-f2c9-88d18209473e@gmail.com>
References: <1475476829-6296-1-git-send-email-anton@ozlabs.org>
 <b0537503-e415-ec23-f2c9-88d18209473e@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-10-04 at 10:25 +1100, Balbir Singh wrote:
> I think this makes sense, in fact I think in the longer term we can
> even use __set_bit() reorder-able version since we have a sync
> coming out of schedule(). The read side for TLB flush can use a RMB

No, that wouldn't be atomic vs. other threads accessing the same
bitmap.

Ben.
