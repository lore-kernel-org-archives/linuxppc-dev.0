Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4EF0AB7038
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Apr 2012 07:23:16 +1000 (EST)
Message-ID: <1333401767.30734.58.camel@pasglop>
Subject: Re: [PATCH 08/18] PCI, powerpc: Register busn_res for root buses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Milton Miller <miltonm@bga.com>
Date: Tue, 03 Apr 2012 07:22:47 +1000
In-Reply-To: <powerpc-pci-domains-by-busnumber-resend@mdm.bga.com>
References: <1330472496.11728.31.camel@pasglop>
 <1330395009-29260-1-git-send-email-yinghai@kernel.org>
 <1330395009-29260-9-git-send-email-yinghai@kernel.org>
 <CAErSpo4bw-V=SM+h5iP4nfv3HaAnHjwvNwu+4Oz8iyQcY_3gOQ@mail.gmail.com>
 <CAErSpo72_JnUkWXrzbNdbX9wiWZtQdX2tuNjEpYrSd+sGzxfzA@mail.gmail.com>
 <powerpc-pci-domains-by-busnumber-resend@mdm.bga.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Tony Luck <tony.luck@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 lkml <linux-kernel@vger.kernel.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Jesse Barnes <jbarnes@virtuousgeek.org>, Greg Kroah-Hartmann <greg@kroah.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Yinghai Lu <yinghai@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-04-02 at 05:19 -0500, Milton Miller wrote:
> 
> In the POWER3 era we had several boxes that split the pci bus number
> space across domains and RTAS used the bus number to find the correct
> PHB.   This contineed to the first RS64 boxes.  By S80 and RS64-III
> it was obvious that we didn't have enough numbers to continue this
> ilusion and we added the presently used RTAS calls that take the pci
> domain as well as bus, device, and function numbers.
> 
> The bus numbers split across pci domains started with the F50
> F50 chrp 32 bit platforms. 

Ok, so old CHRPs would have a split as well...

I think the best is to honor the bus-range property of the PHB as min &
max values, and if we feel a need to allow the kernel to assign busses
beyond that, we can always quirk the appropriate platform code.

Cheers,
Ben.
