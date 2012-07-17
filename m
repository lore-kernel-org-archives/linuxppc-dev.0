Return-Path: <linuxram@us.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e5.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 070DC2C0175
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2012 13:40:47 +1000 (EST)
Received: from /spool/local
 by e5.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <linuxram@us.ibm.com>;
 Mon, 16 Jul 2012 23:40:43 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 560CF6E804D
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2012 23:40:31 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6H3eUbC33161246
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2012 23:40:31 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6H3eUIG005467
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2012 00:40:30 -0300
Date: Tue, 17 Jul 2012 11:40:25 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 0/7] minimal alignment for p2p bars
Message-ID: <20120717034025.GC2369@ram-ThinkPad-T61>
References: <1342491799-30303-1-git-send-email-shangw@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342491799-30303-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, linuxram@us.ibm.com, linuxppc-dev@ozlabs.org,
 bhelgaas@google.com, yinghai@kernel.org
Reply-To: Ram Pai <linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 17, 2012 at 10:23:12AM +0800, Gavin Shan wrote:
> v1 -> v2:
> 	* Shorten the varaible names so that they looks more short.
> 	* Changelog adjustment so that they looks more meaningful.
> 
> v2 -> v3:
> 	* Rebase to 3.5.RC4
> 
> v3 -> v4:
> 	* Merge Yinghai's patches.
> 
> v3 -> v4:
> 	* Split patch for easy review.
> 	* Add function to retrieve the minimal alignment of p2p bridge. 
> 
> v4 -> v5:
> 	* Rebase to 3.5.RC7
> 	* Introduce weak function pcibios_window_alignment() to retrieve
> 	  I/O and memory alignment for P2P bridges.
> 	* Introduce pcibios_window_alignment() for ppc to override the
> 	  PCI function.
> 	* Add ppc_md.pcibios_window_alignment() for specific platform like
> 	  powernv can override ppc's pcibios_window_alignment().
> 
> v5 -> v6:
> 	* Refactor pcibios_window_alignment() so the platform-specific
> 	  implementation needn't return the default alignment according
> 	  to Bjorn's suggestion.
> 	* Simplify pbus_size_mem() according to Bjorn's suggestion: Just
> 	  check the platform required alignment at very end and adjust
> 	  the "min_align" if necessary.
> 
> Lu Yinghai(3):
>   pci: change variable name for find_pci_host_bridge
>   pci: argument pci_bus for find_pci_host_bridge
>   pci: fiddle with conversion of pci and CPU address


Gavin,
	Do you need Yinghai's first 3 patches to implement your
	functionality?

	I dont see those new functions being called from anywhere
	in your patches.

RP
