Return-Path: <glikely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 29 Dec 2010 17:15:41 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH 1/7] fdt: Add Kconfig for EARLY_FLATTREE
Message-ID: <20101230001541.GA32711@angua.secretlab.ca>
References: <1290021345-4303-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1290124502-13125-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<d43cf8d1-8821-4400-9c58-692846dd37ac@SG2EHSMHS005.ehs.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d43cf8d1-8821-4400-9c58-692846dd37ac@SG2EHSMHS005.ehs.local>
Cc: dirk.brandewie@gmail.com, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 18, 2010 at 03:54:56PM -0800, Stephen Neuendorffer wrote:
> The device tree code is now in two pieces: some which can be used generically
> on any platform which selects CONFIG_OF_FLATTREE, and some early which is used
> at boot time on only a few architectures.  This patch segregates the early
> code so that only those architectures which care about it need compile it.
> This also means that some of the requirements in the early code (such as
> a cmd_line variable) that most architectures (e.g. X86) don't provide
> can be ignored.
> 
> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

Applied, thanks.  I had to fix up the #ifdef which was testing for
CONFIG_EARLY_FLATTREE instead of CONFIG_OF_EARLY_FLATTREE, and I
reworked OF_EARLY_FLATTREE to select instead of depend on OF_FLATTREE.

Cheers,
g.

> 
> ----
> 
> Grant,
> We had discussed doing something like this a loooong time ago.  This (or at
> least some other way of dealing with cmd_line) is
> actually necessary to compile on X86.  Do you still want to do it this way?
> Looking at my old email, you suggested only powerpc and microblaze need this.
> Is that still the case?
> 
> Conflicts:
> 
> 	drivers/of/fdt.c
> ---
>  arch/microblaze/Kconfig |    1 +
>  arch/powerpc/Kconfig    |    1 +
>  drivers/of/Kconfig      |    5 +++++
>  drivers/of/fdt.c        |    4 ++++
>  4 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
> index 692fdfc..384375c 100644
> --- a/arch/microblaze/Kconfig
> +++ b/arch/microblaze/Kconfig
> @@ -20,6 +20,7 @@ config MICROBLAZE
>  	select TRACING_SUPPORT
>  	select OF
>  	select OF_FLATTREE
> +	select OF_EARLY_FLATTREE
>  
>  config SWAP
>  	def_bool n
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 631e5a0..2cd7b32 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -119,6 +119,7 @@ config PPC
>  	default y
>  	select OF
>  	select OF_FLATTREE
> +	select OF_EARLY_FLATTREE
>  	select HAVE_FTRACE_MCOUNT_RECORD
>  	select HAVE_DYNAMIC_FTRACE
>  	select HAVE_FUNCTION_TRACER
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index aa675eb..0199157 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -19,6 +19,10 @@ config OF_FLATTREE
>  	bool
>  	select DTC
>  
> +config OF_EARLY_FLATTREE
> +	bool
> +	depends on OF_FLATTREE
> +
>  config OF_PROMTREE
>  	bool
>  
> @@ -62,3 +66,4 @@ config OF_MDIO
>  	  OpenFirmware MDIO bus (Ethernet PHY) accessors
>  
>  endmenu # OF
> +
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index c1360e0..4d71b29 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -27,6 +27,8 @@ int __initdata dt_root_size_cells;
>  
>  struct boot_param_header *initial_boot_params;
>  
> +#ifdef CONFIG_EARLY_FLATTREE
> +
>  char *find_flat_dt_string(u32 offset)
>  {
>  	return ((char *)initial_boot_params) +
> @@ -604,3 +606,5 @@ void __init unflatten_device_tree(void)
>  
>  	pr_debug(" <- unflatten_device_tree()\n");
>  }
> +
> +#endif /* CONFIG_EARLY_FLATTREE */
> -- 
> 1.5.6.6
> 
> 
> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
> 
> 
