Return-Path: <mmarek@suse.cz>
Message-ID: <4D10B775.6040500@suse.cz>
Date: Tue, 21 Dec 2010 15:19:33 +0100
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
To: dirk.brandewie@gmail.com
Subject: Re: [PATCH 2/4] x86/of: Add building device tree blob(s) into image.
References: <cover.1291820033.git.dirk.brandewie@gmail.com>
	<abe67e5689fef1d94e57be68ec5ef47a8f13bf8e.1291820034.git.dirk.brandewie@gmail.com>
In-Reply-To: <abe67e5689fef1d94e57be68ec5ef47a8f13bf8e.1291820034.git.dirk.brandewie@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linux-arch@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, sodaville@linutronix.de,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 8.12.2010 16:01, dirk.brandewie@gmail.com wrote:
> From: Dirk Brandewie <dirk.brandewie@gmail.com>
> 
> This patch adds linking device tree blob into vmlinux. DTB's are
> added by adding the blob object name to list of objects to be linked
> into the image.
> 
> Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
> ---
>  arch/x86/platform/ce4100/Makefile |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/x86/platform/ce4100/Makefile b/arch/x86/platform/ce4100/Makefile
> index 91fc929..e5f3b7b 100644
> --- a/arch/x86/platform/ce4100/Makefile
> +++ b/arch/x86/platform/ce4100/Makefile
> @@ -1 +1,11 @@
>  obj-$(CONFIG_X86_INTEL_CE)	+= ce4100.o
> +clean-files := *dtb.S
> +
> +ifdef CONFIG_X86_OF
> +###
> +# device tree blob
> +obj-$(CONFIG_X86_INTEL_CE) += ce4100.dtb.o
> +
> +$(obj)/%.dtb: $(src)/%.dts
> +	$(call cmd,dtc)
> +endif

Hi,

CONFIG_X86_OF should be defined in some Kconfig file and there is no
ce4100.dts??

Michal
