Return-Path: <glikely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Date: Tue, 16 Nov 2010 23:06:53 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: dirk.brandewie@gmail.com
Subject: Re: [PATCH 4/5] of/powerpc: Move build to use generic dts->dtb rule
Message-ID: <20101117060653.GI12813@angua.secretlab.ca>
References: <cover.1289943240.git.dirk.brandewie@gmail.com>
	<dae91d8292876db96f96896b79076c32cd2bf467.1289943240.git.dirk.brandewie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dae91d8292876db96f96896b79076c32cd2bf467.1289943240.git.dirk.brandewie@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
	microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, sodaville@linutronix.de,
	arjan@linux.intel.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 16, 2010 at 02:41:39PM -0800, dirk.brandewie@gmail.com wrote:
> From: Dirk Brandewie <dirk.brandewie@gmail.com>
> 
> This patch changes arch/powerpc/boot/Makefile to use the generic
> rule build the device tree blobs in scripts/Makefile.lib
> 
> Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
> ---
>  arch/powerpc/boot/Makefile |    7 -------
>  1 files changed, 0 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index fae8192..d90c674 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -147,8 +147,6 @@ targets		+= $(patsubst $(obj)/%,%,$(obj-boot) wrapper.a)
>  extra-y		:= $(obj)/wrapper.a $(obj-plat) $(obj)/empty.o \
>  		   $(obj)/zImage.lds $(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds
>  
> -dtstree		:= $(srctree)/$(src)/dts
> -
>  wrapper		:=$(srctree)/$(src)/wrapper
>  wrapperbits	:= $(extra-y) $(addprefix $(obj)/,addnote hack-coff mktree) \
>  			$(wrapper) FORCE
> @@ -331,11 +329,6 @@ $(obj)/treeImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits)
>  $(obj)/treeImage.%: vmlinux $(obj)/%.dtb $(wrapperbits)
>  	$(call if_changed,wrap,treeboot-$*,,$(obj)/$*.dtb)
>  
> -# Rule to build device tree blobs
> -DTC = $(objtree)/scripts/dtc/dtc
> -
> -$(obj)/%.dtb: $(dtstree)/%.dts
> -	$(DTC) -O dtb -o $(obj)/$*.dtb -b 0 $(DTS_FLAGS) $(dtstree)/$*.dts

This patch needs to modify the rules that have %.dtb dependencies to
go looking in arch/powerpc/boot/dts instead of arch/powerpc/boot
because the rule change will change where .dtb files get generated.

Also, this patch and patch 5 need to be merged with patch 1 so that
the series remains bisectable.

g.

>  
>  # If there isn't a platform selected then just strip the vmlinux.
>  ifeq (,$(image-y))
> -- 
> 1.7.2.3
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
