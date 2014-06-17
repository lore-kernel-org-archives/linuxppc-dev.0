Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0139.outbound.protection.outlook.com [207.46.163.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3D3701A02E4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 01:36:03 +1000 (EST)
Message-ID: <1403019343.6603.723.camel@snotra.buserror.net>
Subject: Re: [PATCH v2] KVM: PPC: e500mc: Enhance tlb invalidation condition
 on vcpu schedule
From: Scott Wood <scottwood@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Date: Tue, 17 Jun 2014 10:35:43 -0500
In-Reply-To: <1402995739-23756-1-git-send-email-mihai.caraman@freescale.com>
References: <1402995739-23756-1-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-06-17 at 12:02 +0300, Mihai Caraman wrote:
> On vcpu schedule, the condition checked for tlb pollution is too loose.
> The tlb entries of a vcpu become polluted (vs stale) only when a different
> vcpu within the same logical partition runs in-between. Optimize the tlb
> invalidation condition taking into account the logical partition id.
> 
> With the new invalidation condition, a guest shows 4% performance improvement
> on P5020DS while running a memory stress application with the cpu oversubscribed,
> the other guest running a cpu intensive workload.

See
https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-June/118547.html

-Scott
