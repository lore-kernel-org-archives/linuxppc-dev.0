Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6CA841A0151
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 09:50:40 +1000 (EST)
Message-ID: <1403567429.4587.142.camel@pasglop>
Subject: Re: [PATCH v1 1/3] powerpc/powernv: Sync header with firmware
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Tue, 24 Jun 2014 09:50:29 +1000
In-Reply-To: <20140623234427.GA4955@shangw>
References: <1403489682-14841-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1403489682-14841-2-git-send-email-gwshan@linux.vnet.ibm.com>
 <1403557814.4587.137.camel@pasglop> <20140623234427.GA4955@shangw>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 agraf@suse.de, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-06-24 at 09:44 +1000, Gavin Shan wrote:
> >I much'd prefer see a opal_pci_err_inject that is specific to
> >IO(D)A errors, which takes a PHB ID and goes via the normal dispatch
> >to PHB ops inside OPAL. For the rest, especially core specific
> >injections, we can provide a separate dedicated call.
> >
> 
> Thanks, Ben. I'll change the firmware API to have a separate
> API (opal_pci_err_inject) for PCI errors.

Also, how do we expose to Linux that the new API is supported ?

Linux shouldn't create the additional files if it isn't...

There are two ways, we can have a property in the DT of the PHB
indicating that it supports error injection or we can check for the
existence of the OPAL token at boot (there's an OPAL call to do that).

Cheers,
Ben.
