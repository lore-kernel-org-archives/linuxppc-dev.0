Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6930FB6F0C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Dec 2009 09:03:52 +1100 (EST)
Subject: Re: [RFC PATCH v2 1/4] wii: bootwrapper: add fixup to calc useable
	mem2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <1260297833-17625-2-git-send-email-albert_herranz@yahoo.es>
References: <1260297833-17625-1-git-send-email-albert_herranz@yahoo.es>
	<1260297833-17625-2-git-send-email-albert_herranz@yahoo.es>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 12 Dec 2009 09:03:46 +1100
Message-ID: <1260569026.16132.367.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-12-08 at 19:43 +0100, Albert Herranz wrote:
> The top portion of MEM2 (the second 64MB memory block) in the Nintendo
> Wii video game console is used by the firmware running on the Starlet
> processor.
> 
> Add code to calculate the portion of MEM2 safely useable by the
> Broadway processor. When running under the 'mini' firmware this is
> easily determined from an in-memory header. Otherwise, a safe default
> is used.
> 
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/boot/wii.c |  118 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 115 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/boot/wii.c b/arch/powerpc/boot/wii.c
> index d0e2625..2ebaec0 100644
> --- a/arch/powerpc/boot/wii.c
> +++ b/arch/powerpc/boot/wii.c
> @@ -22,10 +22,120 @@
>  
>  BSS_STACK(8192);
>  
> -#define HW_REG(x)	((void *)(x))
> +#define HW_REG(x)		((void *)(x))
>  
> -#define EXI_CTRL	HW_REG(0x0d800070)
> -#define EXI_CTRL_ENABLE	(1<<0)
> +#define EXI_CTRL		HW_REG(0x0d800070)
> +#define EXI_CTRL_ENABLE		(1<<0)
> +
> +#define MEM2_TOP		(0x10000000 + 64*1024*1024)
> +#define FIRMWARE_DEFAULT_SIZE	(12*1024*1024)
> +
> +
> +struct mipc_infohdr {
> +	char magic[3];
> +	u8 version;
> +	u32 mem2_boundary;
> +	u32 ipc_in;
> +	size_t ipc_in_size;
> +	u32 ipc_out;
> +	size_t ipc_out_size;
> +};
> +
> +static int mipc_check_address(u32 pa)
> +{
> +	/* only MEM2 addresses */
> +	if (pa < 0x10000000 || pa > 0x14000000)
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +static struct mipc_infohdr *mipc_get_infohdr(void)
> +{
> +	struct mipc_infohdr **hdrp, *hdr;
> +
> +	/* 'mini' header pointer is the last word of MEM2 memory */
> +	hdrp = (struct mipc_infohdr **)0x13fffffc;
> +	if (mipc_check_address((u32)hdrp)) {
> +		printf("mini: invalid hdrp %08X\n", (u32)hdrp);
> +		hdr = NULL;
> +		goto out;
> +	}
> +
> +	hdr = *hdrp;
> +	if (mipc_check_address((u32)hdr)) {
> +		printf("mini: invalid hdr %08X\n", (u32)hdr);
> +		hdr = NULL;
> +		goto out;
> +	}
> +	if (memcmp(hdr->magic, "IPC", 3)) {
> +		printf("mini: invalid magic\n");
> +		hdr = NULL;
> +		goto out;
> +	}
> +
> +out:
> +	return hdr;
> +}
> +
> +static int mipc_get_mem2_boundary(u32 *mem2_boundary)
> +{
> +	struct mipc_infohdr *hdr;
> +	int error;
> +
> +	hdr = mipc_get_infohdr();
> +	if (!hdr) {
> +		error = -1;
> +		goto out;
> +	}
> +
> +	if (mipc_check_address(hdr->mem2_boundary)) {
> +		printf("mini: invalid mem2_boundary %08X\n",
> +		       hdr->mem2_boundary);
> +		error = -EINVAL;
> +		goto out;
> +	}
> +	*mem2_boundary = hdr->mem2_boundary;
> +	error = 0;
> +out:
> +	return error;
> +
> +}
> +
> +static void platform_fixups(void)
> +{
> +	void *mem;
> +	u32 reg[4];
> +	u32 mem2_boundary;
> +	int len;
> +	int error;
> +
> +	mem = finddevice("/memory");
> +	if (!mem)
> +		fatal("Can't find memory node\n");
> +
> +	/* two ranges of (address, size) words */
> +	len = getprop(mem, "reg", reg, sizeof(reg));
> +	if (len != sizeof(reg)) {
> +		/* nothing to do */
> +		goto out;
> +	}
> +
> +	/* retrieve MEM2 boundary from 'mini' */
> +	error = mipc_get_mem2_boundary(&mem2_boundary);
> +	if (error) {
> +		/* if that fails use a sane value */
> +		mem2_boundary = MEM2_TOP - FIRMWARE_DEFAULT_SIZE;
> +	}
> +
> +	if (mem2_boundary > reg[2] && mem2_boundary < reg[2] + reg[3]) {
> +		reg[3] = mem2_boundary - reg[2];
> +		printf("top of MEM2 @ %08X\n", reg[2] + reg[3]);
> +		setprop(mem, "reg", reg, sizeof(reg));
> +	}
> +
> +out:
> +	return;
> +}
>  
>  void platform_init(unsigned long r3, unsigned long r4, unsigned long r5)
>  {
> @@ -42,5 +152,7 @@ void platform_init(unsigned long r3, unsigned long r4, unsigned long r5)
>  
>  	if (ug_probe())
>  		console_ops.write = ug_console_write;
> +
> +	platform_ops.fixups = platform_fixups;
>  }
>  
