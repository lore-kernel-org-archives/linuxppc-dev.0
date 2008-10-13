Return-Path: <brice@myri.com>
Received: from myri.com (mailbox2.myri.com [64.172.73.26])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 66892DE186
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 05:26:43 +1100 (EST)
Message-ID: <48F391B9.1000206@myri.com>
Date: Mon, 13 Oct 2008 20:21:45 +0200
From: Brice Goglin <brice@myri.com>
MIME-Version: 1.0
To: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>
Subject: Re: [BUILD_FAILURE] 2.6.27-git2 - allyesconfig on powerpc
	selectsCONFIG_INTEL_IOATDMA=y
References: <20081013101559.GA14372@linux.vnet.ibm.com>
	<20081013112631.GD29938@cs181140183.pp.htv.fi>
	<36D9DB17C6DE9E40B059440DB8D95F52066E2EAE@orsmsx418.amr.corp.intel.com>
In-Reply-To: <36D9DB17C6DE9E40B059440DB8D95F52066E2EAE@orsmsx418.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Adrian Bunk <bunk@kernel.org>, e1000-devel@lists.sourceforge.net,
	netdev@vger.kernel.org, "Sosnowski, Maciej" <maciej.sosnowski@intel.com>,
	linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, "Kirsher,
	Jeffrey T" <jeffrey.t.kirsher@intel.com>, sam@ravnborg.org,
	Jeff Garzik <jgarzik@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Brandeburg, Jesse wrote:
> What we want, is myri10ge and ixgbe drivers that can build whether or not CONFIG_INTEL_IOATDMA is enabled.  IF CONFIG_INTEL_IOATDMA *is* enabled (which it should not be on PPC) then there are several cases we want to work:
> CONFIG_INTEL_IOATDMA=m  ---> CONFIG_IXGBE=[m|n]
> CONFIG_INTEL_IOATDMA=y  ---> CONFIG_IXGBE=[m|y|n]
> CONFIG_INTEL_IOATDMA=n  ---> CONFIG_IXGBE=[m|y|n]
> CONFIG_INTEL_IOATDMA depends on X86
>   

I am not sure I want to prevent myri10ge=y just because ioatdma=m.

I would vote for adding some Kconfig stuff to define CONFIG_MYRI10GE_DCA
as boolean set to yes if (IOATDMA=y and MYRI10GE=y/m) or (IOATDMA=m and
MYRI10GE=m). And then use #ifdef CONFIG_MYRI10GE_DCA in the driver source.

Brice
