Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2EA01B7B78
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Sep 2009 10:55:08 +1000 (EST)
Subject: Re: [PATCH v3 0/3] cpu: pseries: Cpu offline states framework
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
In-Reply-To: <20090916074848.GB4870@osiris.boeblingen.de.ibm.com>
References: <20090915120629.20523.79019.stgit@sofia.in.ibm.com>
	<1253016701.5506.73.camel@laptop>
	<20090915145834.GG4846@balbir.in.ibm.com>
	<20090916074848.GB4870@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Thu, 24 Sep 2009 10:52:46 +1000
Message-Id: <1253753566.7103.359.camel@pasglop>
Mime-Version: 1.0
Cc: "Darrick J. Wong" <djwong@us.ibm.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, Gautham R Shenoy <ego@in.ibm.com>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org, Arun R Bharadwaj <arun@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-09-16 at 09:48 +0200, Heiko Carstens wrote:
> FWIW, this sounds exactly like the same we have already on s390.
> But back then I didn't consider adding a common code infrastructure
> would make sense :)
> 
> Besides the "online" attribute we have an additional "configure"
> attribute to which can only be written if the cpu is offline.
> Writing a "0" to it would mean that you currently won't need the cpu
> anymore and the hypervisor is free to reassign the cpu to a different
> LPAR.
> Writing a "1" to it means you want to use it. If there are enough
> resources you will get it. If not.. bad luck.
> 
Maybe we should use a common API for that then. And the right way to do
so is via a generically located attribute.

Ben.
