Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C3723B7006
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2012 17:05:19 +1000 (EST)
Message-ID: <1340866985.20977.62.camel@pasglop>
Subject: Re: [PATCH V4 1/2] PCI: pcibus address to resource converting take
 bus directly
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 28 Jun 2012 17:03:05 +1000
In-Reply-To: <CAErSpo4u6HKdVqaaiL5=GSWRXiVfyfJ7EsnkAwGz6KvKrqaM=w@mail.gmail.com>
References: <1340808525-24996-1-git-send-email-shangw@linux.vnet.ibm.com>
 <CAErSpo4u6HKdVqaaiL5=GSWRXiVfyfJ7EsnkAwGz6KvKrqaM=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-pci@vger.kernel.org, yinghai@kernel.org,
 Gavin Shan <shangw@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-06-27 at 12:15 -0600, Bjorn Helgaas wrote:
> 
> This patch appears to have multiple unrelated changes:
> 
>   - change "struct pci_bus *bus" to "struct pci_bus *root_bus"
>   - change find_pci_host_bridge() argument from dev to bus
>   - fiddle with pcibios_bus_to_resource() and
> pcibios_resource_to_bus()
> 
> These should be split out to make your patches easier to review.
> 
> What's the rationale for preferring the pci_bus over the pci_dev? 

We really want to stop doing that crap and put a pointer to the host
bridge directly in each pci_dev (and maybe pci_bus).

We already do that on powerpc via sysdata (pointing to our private
structure but the plan is to move that toward struct pci_host_bridge
eventually).

We'll need host bridge access to deal with resource "offsets" in a few
more places and having to do a lookup is just a pain.

For example, see my earlier email about the issues with the way we
calculate the minimum address to assign devices. This is currently
broken when we have an offset and to fix it we'll probably want to deal
with offsets all the way down in the resource allocation code.

Cheers,
Ben.
