Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A40E8DDE1A
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 14:22:03 +1000 (EST)
Subject: Re: [PATCH/RFC] Rework ptep_set_access_flags and fix sun4c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hugh@veritas.com>
In-Reply-To: <Pine.LNX.4.64.0705230438490.14106@blonde.wat.veritas.com>
References: <Pine.LNX.4.61.0705012354290.12808@mtfhpc.demon.co.uk>
	<20070509231937.ea254c26.akpm@linux-foundation.org>
	<1178778583.14928.210.camel@localhost.localdomain>
	<20070510.001234.126579706.davem@davemloft.net>
	<Pine.LNX.4.64.0705142018090.18453@blonde.wat.veritas.com>
	<1179176845.32247.107.camel@localhost.localdomain>
	<1179212184.32247.163.camel@localhost.localdomain>
	<1179757647.6254.235.camel@localhost.localdomain>
	<1179815339.32247.799.camel@localhost.localdomain>
	<Pine.LNX.4.64.0705221738020.22822@blonde.wat.veritas.com>
	<1179874748.32247.868.camel@localhost.localdomain>
	<Pine.LNX.4.64.0705230438490.14106@blonde.wat.veritas.com>
Content-Type: text/plain
Date: Wed, 23 May 2007 14:21:45 +1000
Message-Id: <1179894105.32247.904.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: mark@mtfhpc.demon.co.uk, linux-mm@kvack.org, wli@holomorphy.com,
	linuxppc-dev@ozlabs.org, andrea@suse.de,
	"Tom \"spot\" Callaway" <tcallawa@redhat.com>,
	sparclinux@vger.kernel.org, akpm@linux-foundation.org,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-05-23 at 05:03 +0100, Hugh Dickins wrote:
> 
> No, I wasn't meaning the optimization, but the significance of the
> boolean __changed that's returned.  If ptep_set_access_flags does
> not change the pte (because !dirty or !safely_writable or whatever
> that arch calls it), then ideally it ought to return false.

Hrm... I prefer keeping the existing semantics. The old code used to
always update_mmu_cache() on those archs and I'd rather let it continue
do so unless the arch maintainer who knows better changes it :-)
 
> But it doesn't affect correctness if it sometimes says true not
> false, and these arches happen to have an empty update_mmu_cache
> (with lazy_mmu_prot_update currently under separate review), and
> what you have follows what was already being done, and sun4c
> already has to "lie": so it's rather theoretical. 

Ok.

Cheers,
Ben.
