Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DEC61DDDF8
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Feb 2008 21:19:18 +1100 (EST)
Date: Mon, 4 Feb 2008 02:19:17 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: balbir@linux.vnet.ibm.com
Subject: Re: Build failure with 2.6.24-mm1
Message-Id: <20080204021917.41f56303.akpm@linux-foundation.org>
In-Reply-To: <20080204100743.GA4445@balbir.in.ibm.com>
References: <47A6E355.8040404@linux.vnet.ibm.com>
	<20080204100743.GA4445@balbir.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Shaohua, Zhang Yanmin <yanmin.zhang@intel.com>,
	Greg KH <greg@kroah.com>, Li <shaohua.li@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 4 Feb 2008 15:37:43 +0530 Balbir Singh <balbir@linux.vnet.ibm.com> wrote:

> * Balbir Singh <balbir@linux.vnet.ibm.com> [2008-02-04 15:35:09]:
> 
> I just saw the following build failure on a power machine.
> 
> In file included from include/acpi/platform/acenv.h:140,
>                  from include/acpi/acpi.h:54,
>                  from include/acpi/acpi_bus.h:31,
>                  from drivers/pci/pcie/aspm.c:20:
> include/acpi/platform/aclinux.h:59:22: error: asm/acpi.h: No such file or directory
> In file included from include/acpi/platform/aclinux.h:120,
>                  from include/acpi/platform/acenv.h:140,
>                  from include/acpi/acpi.h:54,
>                  from include/acpi/acpi_bus.h:31,
>                  from drivers/pci/pcie/aspm.c:20:
> include/acpi/actypes.h:130: error: expected '=', ',', ';', 'asm' or
> '__attribute__' before 'UINT64'
> include/acpi/actypes.h:131: error: expected '=', ',', ';', 'asm' or
> '__attribute__' before 'INT64'
> include/acpi/actypes.h:753: error: expected ')' before '*' token
> include/acpi/actypes.h:756: error: expected ')' before '*' token
> In file included from include/acpi/acpi.h:61,
>                  from include/acpi/acpi_bus.h:31,
>                  from drivers/pci/pcie/aspm.c:20:
> include/acpi/acpiosxf.h:179: error: expected declaration specifiers or '...'
> before 'acpi_osd_handler'
> include/acpi/acpiosxf.h:183: error: expected declaration specifiers or '...'
> before 'acpi_osd_handler'
> include/acpi/acpiosxf.h:192: error: expected declaration specifiers or '...'
> before 'acpi_osd_exec_callback'
> make[3]: *** [drivers/pci/pcie/aspm.o] Error 1
> make[2]: *** [drivers/pci/pcie] Error 2
> make[2]: *** Waiting for unfinished jobs....
>   CC      drivers/ps3/ps3-vuart.o
>   CC      net/netlink/attr.o
> make[1]: *** [drivers/pci] Error 2
> make[1]: *** Waiting for unfinished jobs..
> 
> The following config option is responsible for the build failure
> 
> config PCIEASPM
>         bool "PCI Express ASPM support(Experimental)"
>         depends on PCI && EXPERIMENTAL && PCIEPORTBUS
>         default y
>         help
>           This enables PCI Express ASPM (Active State Power Management) and
>           Clock Power Management. ASPM supports state L0/L0s/L1.
> 
>           When in doubt, say N.
> 
> Here's a probable fix for the problem.
> 
> 
> Make the build of drivers/pci/pcie/aspm.c depend on ACPI.
> 
> NOTE, the patch has not been tested. The dependency on ACPI might be wrong,
> but setting it to default "y" caused the build on my powerpc box to break.
> 
> Signed-off-by: Balbir Singh <balbir@linux.vnet.ibm.com>
> ---
> 
>  drivers/pci/pcie/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/pci/pcie/Kconfig~fix-mm-ppc-build drivers/pci/pcie/Kconfig
> --- linux-2.6.24/drivers/pci/pcie/Kconfig~fix-mm-ppc-build	2008-02-04 15:30:29.000000000 +0530
> +++ linux-2.6.24-balbir/drivers/pci/pcie/Kconfig	2008-02-04 15:33:45.000000000 +0530
> @@ -32,7 +32,7 @@ source "drivers/pci/pcie/aer/Kconfig"
>  #
>  config PCIEASPM
>  	bool "PCI Express ASPM support(Experimental)"
> -	depends on PCI && EXPERIMENTAL && PCIEPORTBUS
> +	depends on PCI && EXPERIMENTAL && PCIEPORTBUS && ACPI
>  	default y
>  	help
>  	  This enables PCI Express ASPM (Active State Power Management) and

Thanks.  I think Greg is going to revert PCIEASPM altogether?
