Return-Path: <Joerg.Roedel@amd.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1E688B6FAF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 21:09:57 +1000 (EST)
Date: Tue, 23 Aug 2011 13:09:42 +0200
From: Joerg Roedel <joerg.roedel@amd.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110823110942.GL2079@amd.com>
References: <CA7847D2.FB3A%aafabbri@cisco.com>
	<1314082483.30478.43.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1314082483.30478.43.camel@pasglop>
Cc: chrisw <chrisw@sous-sol.org>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	qemu-devel <qemu-devel@nongnu.org>, aafabbri <aafabbri@cisco.com>,
	iommu <iommu@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>,
	Anthony Liguori <anthony@codemonkey.ws>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"benve@cisco.com" <benve@cisco.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 23, 2011 at 02:54:43AM -0400, Benjamin Herrenschmidt wrote:
> Possibly, the question that interest me the most is what interface will
> KVM end up using. I'm also not terribly fan with the (perceived)
> discrepancy between using uiommu to create groups but using the group fd
> to actually do the mappings, at least if that is still the plan.
> 
> If the separate uiommu interface is kept, then anything that wants to be
> able to benefit from the ability to put multiple devices (or existing
> groups) into such a "meta group" would need to be explicitly modified to
> deal with the uiommu APIs.
> 
> I tend to prefer such "meta groups" as being something you create
> statically using a configuration interface, either via sysfs, netlink or
> ioctl's to a "control" vfio device driven by a simple command line tool
> (which can have the configuration stored in /etc and re-apply it at
> boot).

Hmm, I don't think that these groups are static for the systems
run-time. They only exist for the lifetime of a guest per default, at
least on x86. Thats why I prefer to do this grouping using VFIO and not
some sysfs interface (which would be the third interface beside the
ioctls and netlink a VFIO user needs to be aware of). Doing this in the
ioctl interface just makes things easier.

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
