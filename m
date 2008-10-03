Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-39.bluehost.com (outbound-mail-39.bluehost.com
	[69.89.20.193]) by ozlabs.org (Postfix) with SMTP id B2A5DDDF74
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Oct 2008 02:00:17 +1000 (EST)
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 1/2] pci: Add ability to mmap legacy_io on some
	platforms
Date: Fri, 3 Oct 2008 08:53:29 -0700
References: <20081003094951.10B3FDE183@ozlabs.org>
In-Reply-To: <20081003094951.10B3FDE183@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200810030853.30340.jbarnes@virtuousgeek.org>
Cc: linuxppc-dev@ozlabs.org, Bjorn Helgaas <bjorn.helgaas@hp.com>,
	tony.luck@intel.com, linux-pci@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday, October 3, 2008 2:49 am Benjamin Herrenschmidt wrote:
> This adds the ability to mmap legacy IO space to the legacy_io files
> in sysfs on platforms that support it. This will allow to clean up
> X to use this instead of /dev/mem for legacy IO accesses such as
> those performed by Int10.
>
> While at it I moved pci_create/remove_legacy_files() to pci-sysfs.c
> where I think they belong, thus making more things statis in there
> and cleaned up some spurrious prototypes in the ia64 pci.h file
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> I didn't have a chance to test that I didn't break ia64, so I would
> be if somebody could give it a spin there ! Thanks !
>
>  arch/ia64/include/asm/pci.h |   12 -----
>  arch/ia64/pci/pci.c         |    7 ++-
>  drivers/pci/pci-sysfs.c     |   93
> +++++++++++++++++++++++++++++++++++++++++--- drivers/pci/pci.h           | 
>   6 ++
>  drivers/pci/probe.c         |   66 -------------------------------
>  5 files changed, 102 insertions(+), 82 deletions(-)

Heh, is it obvious that this code originated on ia64 and no one ever ported it 
to another platform until now?  :)

Tony and/or Bjorn, do you want to take a look and make sure this is ok?  If so 
I can take the whole thing into the PCI tree.

Thanks,
Jesse
