Return-Path: <mika.westerberg@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ybCj81Cg4zDqZ1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 01:30:19 +1100 (AEDT)
Date: Mon, 13 Nov 2017 16:30:13 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] powerpc/pci: Unroll two pass loop when scanning
 bridges
Message-ID: <20171113143013.GF18997@lahna.fi.intel.com>
References: <20171110175230.82522-1-andriy.shevchenko@linux.intel.com>
 <20171110175230.82522-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171110175230.82522-2-andriy.shevchenko@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 10, 2017 at 07:52:30PM +0200, Andy Shevchenko wrote:
> The current scanning code is really hard to understand because it calls
> the same function in a loop where pass value is changed without any
> comments explaining it:
> 
>   for (pass = 0; pass < 2; pass++)
>     for_each_pci_bridge(dev, bus)
>       max = pci_scan_bridge(bus, dev, max, pass);
> 
> Unfamiliar reader cannot tell easily what is the purpose of this loop
> without looking at internals of pci_scan_bridge().
> 
> In order to make this bit easier to understand, open-code the loop in
> pci_scan_child_bus() and pci_hp_add_bridge() with added comments.
> 
> No functional changes intended.
> 
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
