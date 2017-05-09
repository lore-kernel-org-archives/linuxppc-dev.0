Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wMYSn53fDzDqJv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 May 2017 19:08:41 +1000 (AEST)
Date: Tue, 9 May 2017 19:08:38 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: P.A. Semi: "PR" KVM configure error after KVM changes for 4.12
Message-ID: <20170509090838.GC28688@fergus.ozlabs.ibm.com>
References: <d38b72b2-b2b7-97a9-41a5-72651faa0937@xenosoft.de>
 <32d4e529-c0ef-3a97-05c0-6b9933d18e92@xenosoft.de>
 <c992819c-ee60-c3e6-bc12-761f3aee3998@xenosoft.de>
 <1f331c00-1833-340b-2725-81c85f4a2a28@xenosoft.de>
 <03ce35a5-6996-6d9e-0a39-3cc21f7cd291@xenosoft.de>
 <3ffbd423-be9f-dc37-4e81-9097bf8a34fb@xenosoft.de>
 <68fca557-87c8-5c60-208d-5b57da1152c5@xenosoft.de>
 <1c52e1a2-580a-474c-a09d-21c879f97419@xenosoft.de>
 <9c66da5e-1a89-8948-d100-3996f194aca3@xenosoft.de>
 <69e6beec-e909-4ca8-64e4-d8f45627af97@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <69e6beec-e909-4ca8-64e4-d8f45627af97@xenosoft.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 09, 2017 at 10:42:51AM +0200, Christian Zigotzky wrote:
> Hi All,
> 
> After the first batch of KVM changes for 4.12 merge window I get the
> following error message if I want to configure the Linux kernel with KVM PR
> support on my P.A. Semi board.
> 
> warning: (KVM_BOOK3S_64) selects SPAPR_TCE_IOMMU which has unmet direct
> dependencies (IOMMU_SUPPORT && (PPC_POWERNV || PPC_PSERIES))
> 
> Did you change the system requirements for KVM? Does it only work on IBM
> pSeries machines now?

That probably came in with Alexey Kardashevskiy's patches to
accelerate the TCE (IOMMU) hypercalls.  There was no deliberate
intention to restrict PR KVM to IBM machines.  I'll fix it.

However, I expect that at least for now we will not support PCI
pass-through on machines other than IBM pSeries, because the KVM vfio
code needs some specific services from the iommu layer which are
platform-dependent and probably not implemented on other platforms
(maple, pasemi, powermac).  If you have been using PCI pass-through
successfully in the past with PR KVM then please let me know and we'll
look at what is needed to keep it working.

Paul.
