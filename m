Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9179CB6FAA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2012 14:10:53 +1000 (EST)
Message-ID: <1335327042.21961.27.camel@pasglop>
Subject: Re: 3.4-rc3 compile failed on IBM Power6
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Wed, 25 Apr 2012 14:10:42 +1000
In-Reply-To: <20120425015044.GA4637@shangw>
References: <CAPxxNQmfkJLPHq0BvzxOnLFO-e0FRmaF1VqLhP-jMqF-ziM2tA@mail.gmail.com>
 <20120425005432.GA14663@linux.vnet.ibm.com> <20120425015044.GA4637@shangw>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Ryan Wang <openspace.wang@gmail.com>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-04-25 at 09:50 +0800, Gavin Shan wrote:
> In order to make iommu.c irrelative to CONFIG_EEH, we might figure out
> the PE number of the PCI device during PCI probe time. Here're some
> rough thoughts about the rework.
> 
>         - Introduce additional field "int pe_num" to "struct dev_archdata".
>           That would be traced like: (struct pci_dev)->(struct device dev)
>           ->(struct dev_archdata archdata).
>         - During the PCI probe time (maybe pci_fixup_early), we can figure
>           out the PE number.
> 
> Then we can retrieve the PE number of PCI device from "int pe_num" and needn't
> care CONFIG_EEH has been turned on or off. I'm not sure Ben has any comments
> on the idea? 

Just select EEH from pseries Kconfig, no point in keeping that a user visible option.

Cheers,
Ben.
