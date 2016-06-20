Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rXzrV0n0szDq80
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 15:27:22 +1000 (AEST)
Date: Mon, 20 Jun 2016 15:27:17 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Cc: kvm-ppc@vger.kernel.org,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>, agraf@suse.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Boqun Feng <boqun.feng@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 2/2] KVM: PPC: Don't take lock when check irq's
 resend flag
Message-ID: <20160620052717.GC29366@fergus.ozlabs.ibm.com>
References: <1463381898.19947.6.camel@TP420> <1463382133.19947.10.camel@TP420>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1463382133.19947.10.camel@TP420>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 16, 2016 at 03:02:13PM +0800, Li Zhong wrote:
> It seems that we don't need to take the lock before evaluating irq's
> resend flag. What needed is to make sure when we clear the ics's bit
> in the icp's resend_map, we don't miss the resend flag of the irqs
> that set the bit.
> 
> And seems this could be ordered through the barrier in test_and_clear_bit(),
> and an newly added wmb when setting irq's resend flag, and icp's resend_map.

This looks fine to me.  Is there a measurable performance improvement
from this?  I understand it could be hard to measure.

Also, you could make the patch description more definite - just say
that we don't need to take the lock, there's no need for "seems".

Paul.
