Return-Path: <Joerg.Roedel@amd.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5B0F0B6F8F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Aug 2011 02:48:34 +1000 (EST)
Date: Thu, 25 Aug 2011 18:46:01 +0200
From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
To: Don Dutile <ddutile@redhat.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110825164601.GK1923@amd.com>
References: <1314118861.2859.51.camel@bling.home>
	<CA79326A.FB97%aafabbri@cisco.com> <20110824091035.GD2079@amd.com>
	<1314220434.2859.203.camel@bling.home>
	<20110825105402.GB1923@amd.com> <4E566C61.9060105@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4E566C61.9060105@redhat.com>
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
	iommu <iommu@lists.linux-foundation.org>, chrisw <chrisw@sous-sol.org>,
	Alex Williamson <alex.williamson@redhat.com>, Avi Kivity <avi@redhat.com>,
	Anthony Liguori <anthony@codemonkey.ws>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
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

On Thu, Aug 25, 2011 at 11:38:09AM -0400, Don Dutile wrote:

> On 08/25/2011 06:54 AM, Roedel, Joerg wrote:
> > We need to solve this differently. ARM is starting to use the iommu-api
> > too and this definitly does not work there. One possible solution might
> > be to make the iommu-ops per-bus.
> >
> When you think of a system where there isn't just one bus-type
> with iommu support, it makes more sense.
> Additionally, it also allows the long-term architecture to use different types
> of IOMMUs on each bus segment -- think per-PCIe-switch/bridge IOMMUs --
> esp. 'tuned' IOMMUs -- ones better geared for networks, ones better geared
> for direct-attach disk hba's.

Not sure how likely it is to have different types of IOMMUs within a
given bus-type. But if they become reality we can multiplex in the
iommu-api without much hassle :)
For now, something like bus_set_iommu() or bus_register_iommu() would
provide a nice way to do bus-specific setups for a given iommu
implementation.

Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
