Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHLy934lBzF0WY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 21:01:53 +1100 (AEDT)
Date: Thu, 11 Jan 2018 21:01:48 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Alexander Graf <agraf@suse.de>
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Remove vcpu->arch.dec usage
Message-ID: <20180111100148.GJ24294@fergus.ozlabs.ibm.com>
References: <20171219145624.46724-1-agraf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171219145624.46724-1-agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 19, 2017 at 03:56:24PM +0100, Alexander Graf wrote:
> On Book3S in HV mode, we don't use the vcpu->arch.dec field at all.
> Instead, all logic is built around vcpu->arch.dec_expires.
> 
> So let's remove the one remaining piece of code that was setting it.
> 
> Signed-off-by: Alexander Graf <agraf@suse.de>

Thanks, applied to my kvm-ppc-next branch.

> Looking through the DEC logic, I fail to see any code that allows
> save or restore of DEC. Do we maybe miss out on that register for
> (live) migration?

Yes, it looks like we do.  I'm amazed no-one has noticed before.  I'll
fix it.

Paul.
