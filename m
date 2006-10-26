Return-Path: <mgreer@mvista.com>
Date: Thu, 26 Oct 2006 15:56:53 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [RFC] bootwrapper: prevent fdt from being overwritten by kernel
Message-ID: <20061026225653.GA20233@mag.az.mvista.com>
References: <20061026225045.GA19839@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061026225045.GA19839@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 26, 2006 at 03:50:45PM -0700, Mark A. Greer wrote:
> diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
> index 234bb5b..4927c17 100644
> --- a/arch/powerpc/boot/main.c
> +++ b/arch/powerpc/boot/main.c
> @@ -169,7 +169,7 @@ static int is_elf32(void *hdr)
>  	return 1;
>  }
>  
> -static void prep_kernel(unsigned long *a1, unsigned long *a2)
> +static void get_elfheader(void)
>  {
>  	int len;
>  
> @@ -186,11 +186,13 @@ static void prep_kernel(unsigned long *a
>  		       sizeof(elfheader));
>  
>  	if (!is_elf64(elfheader) && !is_elf32(elfheader)) {
> -		printf("Error: not a valid PPC32 or PPC64 ELF file!\n\r");
>  		exit();
>  	}
> -	if (platform_ops.image_hdr)
> -		platform_ops.image_hdr(elfheader);
> +}
> +
> +static void prep_kernel(unsigned long *a1, unsigned long *a2)
> +{
> +	int len;

Oops, the "if (!is_elf64(elfheader) && !is_elf32(elfheader)) {"
check should stay in prep_kernel.

Mark
