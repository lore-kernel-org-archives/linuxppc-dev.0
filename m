Return-Path: <glikely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Date: Thu, 23 Dec 2010 15:13:19 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: dirk.brandewie@gmail.com
Subject: Re: [PATCH 4/4] microblaze/of: Use generic rule to build dtb's
Message-ID: <20101223221319.GI20384@angua.secretlab.ca>
References: <1293047849-26078-1-git-send-email-dirk.brandewie@gmail.com>
	<1293047849-26078-5-git-send-email-dirk.brandewie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1293047849-26078-5-git-send-email-dirk.brandewie@gmail.com>
Cc: linux-arch@vger.kernel.org, mmarek@suse.cz, linux-kbuild@vger.kernel.org,
	microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 22, 2010 at 11:57:29AM -0800, dirk.brandewie@gmail.com wrote:
> From: Dirk Brandewie <dirk.brandewie@gmail.com>
> 
> Modify arch/powerpc/boot/Makefile to use dtc command in
> scripts/Makefile.lib
> 
> Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>

applied, thanks

g.

> ---
>  arch/microblaze/boot/Makefile |   12 +++---------
>  1 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/microblaze/boot/Makefile b/arch/microblaze/boot/Makefile
> index be01d78..4c4e58e 100644
> --- a/arch/microblaze/boot/Makefile
> +++ b/arch/microblaze/boot/Makefile
> @@ -10,9 +10,6 @@ targets := linux.bin linux.bin.gz simpleImage.%
>  
>  OBJCOPYFLAGS := -O binary
>  
> -# Where the DTS files live
> -dtstree         := $(srctree)/$(src)/dts
> -
>  # Ensure system.dtb exists
>  $(obj)/linked_dtb.o: $(obj)/system.dtb
>  
> @@ -51,14 +48,11 @@ $(obj)/simpleImage.%: vmlinux FORCE
>  	$(call if_changed,strip)
>  	@echo 'Kernel: $@ is ready' ' (#'`cat .version`')'
>  
> -# Rule to build device tree blobs
> -DTC = $(objtree)/scripts/dtc/dtc
>  
>  # Rule to build device tree blobs
> -quiet_cmd_dtc = DTC     $@
> -	cmd_dtc = $(DTC) -O dtb -o $(obj)/$*.dtb -b 0 -p 1024 $(dtstree)/$*.dts
> +DTC_FLAGS := -p 1024
>  
> -$(obj)/%.dtb: $(dtstree)/%.dts FORCE
> -	$(call if_changed,dtc)
> +$(obj)/%.dtb: $(src)/dts/%.dts FORCE
> +	$(call cmd,dtc)
>  
>  clean-files += *.dtb simpleImage.*.unstrip linux.bin.ub
> -- 
> 1.7.2.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
