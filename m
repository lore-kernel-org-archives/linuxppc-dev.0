Return-Path: <michael@ellerman.id.au>
Date: Fri, 5 Apr 2013 17:52:38 +1100
From: Michael Ellerman <michael@ellerman.id.au>
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] powerpc: Set default VGA device
Message-ID: <20130405065238.GC5082@concordia>
References: <201304042158.r34LwGPg010714@d03av02.boulder.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201304042158.r34LwGPg010714@d03av02.boulder.ibm.com>
Cc: klebers@linux.vnet.ibm.com, linux-pci@vger.kernel.org, bhelgaas@google.com,
 linuxppc-dev@lists.ozlabs.org, lucaskt@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Brian,


On Thu, Apr 04, 2013 at 04:58:17PM -0500, Brian King wrote:
> 
> Add a PCI quirk for VGA devices on Power to set the default VGA device.
> Ensures a default VGA is always set if a graphics adapter is present,
> even if firmware did not initialize it. If more than one graphics
> adapter is present, ensure the one initialized by firmware is set
> as the default VGA device. This ensures that X autoconfiguration
> will work.

So a few things:

 - You are doing this on all power systems, not just pseries which is I
   assume what you're testing on - that seems OK to me, but just
   checking.
 - What is the "initialized by firmware" test? Just that IO & MEM are
   enabled?
 - You potentially override an existing default, is that a problem? Can
   the user set the default? (no AFAICS).
 - The x86 code is slightly different, they don't override an existing
   default, why do we?

cheers
