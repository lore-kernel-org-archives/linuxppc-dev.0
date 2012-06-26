Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5891D1007E1
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2012 12:50:56 +1000 (EST)
Message-ID: <1340679045.3732.3.camel@pasglop>
Subject: Re: [PATCH V3 1/2] PCI: retrieve host bridge by PCI bus
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Tue, 26 Jun 2012 12:50:45 +1000
In-Reply-To: <20120626003020.GA6307@shangw>
References: <1340593821-19011-1-git-send-email-shangw@linux.vnet.ibm.com>
 <CAE9FiQUE0_niTRmvZ=ROSFKB4HKDFFLjfJC+QeQkTKLMyvxv4g@mail.gmail.com>
 <20120626003020.GA6307@shangw>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 Yinghai Lu <yinghai@kernel.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-06-26 at 08:30 +0800, Gavin Shan wrote:
> >> +EXPORT_SYMBOL(pci_bus_host_bridge);
> 
> Yinghai, thanks for your time on this :-)
> 
> >
> >why do you need to export it?
> >
> 
> The reason is that we have introduced extra fields to "struct
> pci_host_bridge"
> in [PATCH 2/2] and platform want to access those extra fields. 

But the platform code is built-in, not modular, so it doesn't need
EXPORT_SYMBOL (additionally even if we wanted to export it we probably
also want it _GPL only, so EXPORT_SYMBOL_GPL, but I don't think we need
to).

Cheers,
Ben.
