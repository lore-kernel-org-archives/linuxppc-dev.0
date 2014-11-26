Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 30E8E1A0515
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 14:44:19 +1100 (AEDT)
In-Reply-To: <20141120041345.3339.6873.stgit@mars.in.ibm.com>
To: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/powernv: Fix the hmi event version check.
Message-Id: <20141126034419.0917A1401B1@ozlabs.org>
Date: Wed, 26 Nov 2014 14:44:18 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-20-11 at 04:14:36 UTC, Mahesh Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> The current HMI event structure is an ABI and carries a version field to
> accommodate future changes without affecting/rearranging current structure
> members that are valid for previous versions. The current version check
> "if (hmi_evt->version != OpalHMIEvt_V1)" seems to consider that version
> will always be V1 which may not be true in future. If we start supporting
> HMI event > V1, this check would fail without printing anything on older
> kernels. This patch fixes this issue.

It's not clear what you mean when you say "this check would fail without
printing anything". The check will fail, and it will print something, ie. the
error message.

What you mean is "the check will fail, and the HMI info will not be printed".

I'll CC this to stable unless you disagree.

cheers
