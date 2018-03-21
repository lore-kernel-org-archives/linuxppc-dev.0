Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405gJz1QHlzF0wQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 17:44:50 +1100 (AEDT)
Subject: [PATCH 1/1] PCI set flag PCI_SCAN_ALL_PCIE_DEVS for P.A. Semi boards
To: Michael Ellerman <mpe@ellerman.id.au>, Bjorn Helgaas
 <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Olof Johansson <olof@lixom.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <4cfe3cc0-7fe3-9774-7d20-1b7fcb7aa910@xenosoft.de>
 <CAErSpo55Q8Q=5p6_+uu7ahnw+53ibVDNRXxrzRV9QnUr_9EUfw@mail.gmail.com>
 <28b43e1a-3643-9edb-7123-be1cb0dc846a@xenosoft.de>
 <CAErSpo7fup7+doD6A7RKh8kdE8HQaQrEh=gq35+nC-dBeOQ1uA@mail.gmail.com>
 <527175f7-8a13-37a1-9f0a-0b918aeebd64@xenosoft.de>
 <20171130224243.GB19640@bhelgaas-glaptop.roam.corp.google.com>
 <406ba7c4-7305-4069-227f-81afed202e47@xenosoft.de>
 <20171201232716.GA18780@bhelgaas-glaptop.roam.corp.google.com>
 <dc228918-652a-e24c-ce7b-8d1b30153d3b@xenosoft.de>
 <639e975f-1b3a-4f85-9a40-13fe2473fc28@xenosoft.de>
 <20180319191310.GG77194@bhelgaas-glaptop.roam.corp.google.com>
 <87tvtbg0i9.fsf@concordia.ellerman.id.au>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <9841e67b-fc61-cfa7-e6ab-cede76665e27@xenosoft.de>
Date: Wed, 21 Mar 2018 07:44:25 +0100
MIME-Version: 1.0
In-Reply-To: <87tvtbg0i9.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael,

Thanks for the hint because of removing tags and thanks a lot for adding 
the patch to the official source code. This patch helps us a lot.

Have a nice day!

Christian

On 19 March 2018 at 11:32PM, Michael Ellerman wrote:
 >
 > I'm happy to take it, I've been meaning to check if Olof sent a SOB in
 > his original mail but haven't got to it.
 >
 > ...
 >
 > Yes, he did, see below.
 >
 > So I'll merge that, I'll add a Tested-by for you Christian.
 >
 > Christian please don't remove any of the tags when submitting other
 > peoples' patches in future.
 >
 > cheers
 >
 >
 > >From a3b390277627b0342c8ccfc16e58679e0d8abdde Mon Sep 17 00:00:00 2001
 > From: Olof Johansson <olof@lixom.net>
 > Date: Sat, 2 Dec 2017 14:56:36 -0800
 > Subject: [PATCH] powerpc/pasemi: set PCI_SCAN_ALL_PCI_DEVS
 >
 > Needed on Amiga X1000 with SB600.
 >
 > Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
 > Cc: Bjorn Helgaas <bhelgaas@google.com>
 > Signed-off-by: Olof Johansson <olof@lixom.net>
 > ---
 >  arch/powerpc/platforms/pasemi/pci.c | 2 ++
 >  1 file changed, 2 insertions(+)
 >
 > diff --git a/arch/powerpc/platforms/pasemi/pci.c 
b/arch/powerpc/platforms/pasemi/pci.c
 > index 5ff6108..ea54ed2 100644
 > --- a/arch/powerpc/platforms/pasemi/pci.c
 > +++ b/arch/powerpc/platforms/pasemi/pci.c
 > @@ -224,6 +224,8 @@ void __init pas_pci_init(void)
 >         return;
 >     }
 >
 > +    pci_set_flag(PCI_SCAN_ALL_PCIE_DEVS):
 > +
 >     for (np = NULL; (np = of_get_next_child(root, np)) != NULL;)
 >         if (np->name && !strcmp(np->name, "pxp") && !pas_add_bridge(np))
 >             of_node_get(np);
 >
