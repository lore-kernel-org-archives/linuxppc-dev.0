Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C0411A0168
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 16:24:03 +1000 (EST)
Date: Tue, 17 Jun 2014 16:23:58 +1000
From: Paul Mackerras <paulus@samba.org>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] powerpc/book3s: Fix guest MC delivery mechanism to
 avoid soft lockups in guest.
Message-ID: <20140617062358.GB12120@drongo>
References: <20140611084756.9634.82266.stgit@mars.in.ibm.com>
 <20140611084821.9634.7119.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140611084821.9634.7119.stgit@mars.in.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 11, 2014 at 02:18:21PM +0530, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> Currently we forward MCEs to guest which have been recovered by guest.
> And for unhandled errors we do not deliver the MCE to guest. It looks like
> with no support of FWNMI in qemu, guest just panics whenever we deliver the
> recovered MCEs to guest. Also, the existig code used to return to host for
> unhandled errors which was casuing guest to hang with soft lockups inside
> guest and makes it difficult to recover guest instance.
> 
> This patch now forwards all fatal MCEs to guest causing guest to crash/panic.
> And, for recovered errors we just go back to normal functioning of guest
> instead of returning to host.

... having corrupted possibly live values that the guest had in SRR0/1.

Ideally the guest should have cleared MSR[RI] before putting values in
SRR0/1, so perhaps you could check that and return to the guest
without giving it a machine check if MSR[RI] is set.  But if MSR[RI]
is clear, the guest is unfixably corrupted because the machine check
overwrote SRR0/1, and the only thing we can do, in the absence of
FWNMI support, is give the guest a machine check interrupt and let it
crash.

Paul.
