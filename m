Return-Path: <BATV+d1941b170df8d5091610+2224+infradead.org+arjan@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A29F2B7B9C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Sep 2009 17:42:28 +1000 (EST)
Date: Fri, 25 Sep 2009 09:42:27 +0200
From: Arjan van de Ven <arjan@infradead.org>
To: svaidy@linux.vnet.ibm.com
Subject: Re: [PATCH v2 0/2] cpu: pseries: Offline state framework.
Message-ID: <20090925094227.05984cab@infradead.org>
In-Reply-To: <20090925072549.GB9562@dirshya.in.ibm.com>
References: <20090828095741.10641.32053.stgit@sofia.in.ibm.com>
	<1251869611.7547.38.camel@twins>
	<1253753307.7103.356.camel@pasglop>
	<1253778667.7695.130.camel@twins>
	<1253781508.7103.437.camel@pasglop>
	<1253791987.7695.153.camel@twins>
	<20090924134123.4acd1adf@infradead.org>
	<20090925072549.GB9562@dirshya.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Gautham R Shenoy <ego@in.ibm.com>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	"Darrick J. Wong" <djwong@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 25 Sep 2009 12:55:49 +0530
Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> wrote:

> > I obviously can't speak for p-series cpus, just wanted to point out
> > that there is no universal truth about "offlining saves power".
> 
> Hi Arjan,
> 
> As you have said, on some cpus the extra effort of offlining does not
> save us any extra power, and the state will be same as idle.  The
> assertion that offlining saves power is still valid, it could be same
> as idle or better depending on the architecture and implementation.
> 
> On x86 we still need the code (Venki posted) to take cpus to C6 on
> offline to save power or else offlining consumes more power than idle
> due to C1/hlt state.  This framework can help here as well if we have
> any apprehension on making lowest sleep state as default on x86 and
> want the administrator to decide.

even with Venki's patch, all our measurements indicate that taking
cores away is damage on x86. Don't let that stop what you do for
powerpc, but for x86 it's not a win. Linux is good at keeping cores in
C6 long enough that the downside of offlining is bigger...



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
