Return-Path: <amodra@bigpond.net.au>
Received: from grove.modra.org (CPE-144-136-172-108.sa.bigpond.net.au
	[144.136.172.108]) by ozlabs.org (Postfix) with ESMTP id 35B94679E9
	for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2006 11:04:39 +1000 (EST)
Date: Thu, 11 May 2006 10:34:38 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
Message-ID: <20060511010438.GE24458@bubble.grove.modra.org>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
	<20060510154702.GA28938@twiddle.net>
	<20060510.124003.04457042.davem@davemloft.net>
	<17506.21908.857189.645889@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17506.21908.857189.645889@cargo.ozlabs.ibm.com>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, rth@twiddle.net,
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 11, 2006 at 07:05:24AM +1000, Paul Mackerras wrote:
> No, Richard has a point, it's not the value that is the concern, it's
> the address, which gcc could assume is still valid after a barrier.
> Drat.

That may never happen, at least with a compiler that knows how to
optimise away the addi.  You're using -mtls-size=16 so all your accesses
should look like

	lwz rn,per_cpu_var@tprel(13)

gcc shouldn't think there is any reason to cache the address.

-- 
Alan Modra
IBM OzLabs - Linux Technology Centre
