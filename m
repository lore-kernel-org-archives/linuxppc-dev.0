Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sf5hP4YYPzDsTQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 14:08:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/4] drivers/pci/hotplug: Support surprise hotplug
In-Reply-To: <1473905242-898-5-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1473905242-898-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1473905242-898-5-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Wed, 21 Sep 2016 14:08:18 +1000
Message-ID: <8737ktao99.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Gavin Shan <gwshan@linux.vnet.ibm.com> writes:

> This supports PCI surprise hotplug. The design is highlighted as
> below:
>
>    * The PCI slot's surprise hotplug capability is exposed through
>      device node property "ibm,slot-surprise-pluggable", meaning
>      PCI surprise hotplug will be disabled if skiboot doesn't support
>      it yet.
>    * The interrupt because of presence or link state change is raised
>      on surprise hotplug event. One event is allocated and queued to
>      the PCI slot for workqueue to pick it up and process in serialized
>      fashion. The code flow for surprise hotplug is same to that for
>      managed hotplug except: the affected PEs are put into frozen state
>      to avoid unexpected EEH error reporting in surprise hot remove path.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/pnv-pci.h |   9 ++
>  drivers/pci/hotplug/pnv_php.c      | 219 +++++++++++++++++++++++++++++++++++++

Can you please resend this and Cc linux-pci and Bjorn, thanks.

cheers
