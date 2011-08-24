Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CBEADB6F65
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Aug 2011 19:33:16 +1000 (EST)
Received: from /spool/local by au.ibm.com with XMail ESMTP
	for <linuxppc-dev@lists.ozlabs.org> from <dwg@au1.ibm.com>;
	Wed, 24 Aug 2011 10:30:15 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7O9VpJk1536166
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2011 19:31:51 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7O9X6IC028572
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2011 19:33:06 +1000
Date: Wed, 24 Aug 2011 19:33:00 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110824093300.GI30097@yookeroo.fritz.box>
References: <20110823110431.GK2079@amd.com> <CA792953.FB87%aafabbri@cisco.com>
	<20110824091425.GE2079@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110824091425.GE2079@amd.com>
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

On Wed, Aug 24, 2011 at 11:14:26AM +0200, Roedel, Joerg wrote:
> On Tue, Aug 23, 2011 at 12:54:27PM -0400, aafabbri wrote:
> > On 8/23/11 4:04 AM, "Joerg Roedel" <joerg.roedel@amd.com> wrote:
> > > That is makes uiommu basically the same as the meta-groups, right?
> > 
> > Yes, functionality seems the same, thus my suggestion to keep uiommu
> > explicit.  Is there some need for group-groups besides defining sets of
> > groups which share IOMMU resources?
> > 
> > I do all this stuff (bringing up sets of devices which may share IOMMU
> > domain) dynamically from C applications.  I don't really want some static
> > (boot-time or sysfs fiddling) supergroup config unless there is a good
> > reason KVM/power needs it.
> > 
> > As you say in your next email, doing it all from ioctls is very easy,
> > programmatically.
> 
> I don't see a reason to make this meta-grouping static. It would harm
> flexibility on x86. I think it makes things easier on power but there
> are options on that platform to get the dynamic solution too.

I think several people are misreading what Ben means by "static".  I
would prefer to say 'persistent', in that the meta-groups lifetime is
not tied to an fd, but they can be freely created, altered and removed
during runtime.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
