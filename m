Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3467CB7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 17:15:42 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7D94EDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 17:15:41 +1000 (EST)
Subject: Re: [PATCH 2/5] Mechanism to enable use Generic NVRAM driver for
	different size chips
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20090702161224.31202.65236.stgit@ES-J7S4D2J.amer.consind.ge.com>
References: <20090702154928.31202.65107.stgit@ES-J7S4D2J.amer.consind.ge.com>
	<20090702161224.31202.65236.stgit@ES-J7S4D2J.amer.consind.ge.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 13 Aug 2009 17:15:30 +1000
Message-Id: <1250147730.3587.120.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-07-02 at 17:12 +0100, Martyn Welch wrote:
> Remove the reliance on a staticly defined NVRAM size, allowing platforms to support NVRAMs with sizes differing from the standard. A fall back value is provided for platforms not supporting this extension.
> 
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>

I was about to stick 1/5 and 2/5 in -test (on the way to -next) but
I hit this when building 64-bit kernels:

/home/benh/linux-powerpc-test/arch/powerpc/platforms/pseries/nvram.c:26: error: ‘nvram_size’ redeclared as different kind of symbol
/home/benh/linux-powerpc-test/arch/powerpc/include/asm/nvram.h:111: error: previous declaration of ‘nvram_size’ was here
make[3]: *** [arch/powerpc/platforms/pseries/nvram.o] Error 1

Looks trivial enough, can you respin the patch ?

Cheers,
Ben.

> ---
> 
>  arch/powerpc/include/asm/nvram.h |    3 +++
>  arch/powerpc/kernel/setup_32.c   |    8 ++++++++
>  drivers/char/generic_nvram.c     |   27 ++++++++++++++++++++-------
>  3 files changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/nvram.h b/arch/powerpc/include/asm/nvram.h
> index efde5ac..71df8b2 100644
> --- a/arch/powerpc/include/asm/nvram.h
> +++ b/arch/powerpc/include/asm/nvram.h
> @@ -107,6 +107,9 @@ extern void	pmac_xpram_write(int xpaddr, u8 data);
>  /* Synchronize NVRAM */
>  extern void	nvram_sync(void);
>  
> +/* Determine NVRAM size */
> +extern ssize_t nvram_size(void);
> +
>  /* Normal access to NVRAM */
>  extern unsigned char nvram_read_byte(int i);
>  extern void nvram_write_byte(unsigned char c, int i);
> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
> index 1d15424..28f7570 100644
> --- a/arch/powerpc/kernel/setup_32.c
> +++ b/arch/powerpc/kernel/setup_32.c
> @@ -208,6 +208,14 @@ void nvram_write_byte(unsigned char val, int addr)
>  }
>  EXPORT_SYMBOL(nvram_write_byte);
>  
> +ssize_t nvram_size(void)
> +{
> +	if (ppc_md.nvram_size)
> +		return ppc_md.nvram_size();
> +	return -1;
> +}
> +EXPORT_SYMBOL(nvram_size);
> +
>  void nvram_sync(void)
>  {
>  	if (ppc_md.nvram_sync)
> diff --git a/drivers/char/generic_nvram.c b/drivers/char/generic_nvram.c
> index a00869c..e5f71f3 100644
> --- a/drivers/char/generic_nvram.c
> +++ b/drivers/char/generic_nvram.c
> @@ -2,7 +2,7 @@
>   * Generic /dev/nvram driver for architectures providing some
>   * "generic" hooks, that is :
>   *
> - * nvram_read_byte, nvram_write_byte, nvram_sync
> + * nvram_read_byte, nvram_write_byte, nvram_sync, nvram_size
>   *
>   * Note that an additional hook is supported for PowerMac only
>   * for getting the nvram "partition" informations
> @@ -28,6 +28,8 @@
>  
>  #define NVRAM_SIZE	8192
>  
> +static ssize_t nvram_len;
> +
>  static loff_t nvram_llseek(struct file *file, loff_t offset, int origin)
>  {
>  	lock_kernel();
> @@ -36,7 +38,7 @@ static loff_t nvram_llseek(struct file *file, loff_t offset, int origin)
>  		offset += file->f_pos;
>  		break;
>  	case 2:
> -		offset += NVRAM_SIZE;
> +		offset += nvram_len;
>  		break;
>  	}
>  	if (offset < 0) {
> @@ -56,9 +58,9 @@ static ssize_t read_nvram(struct file *file, char __user *buf,
>  
>  	if (!access_ok(VERIFY_WRITE, buf, count))
>  		return -EFAULT;
> -	if (*ppos >= NVRAM_SIZE)
> +	if (*ppos >= nvram_len)
>  		return 0;
> -	for (i = *ppos; count > 0 && i < NVRAM_SIZE; ++i, ++p, --count)
> +	for (i = *ppos; count > 0 && i < nvram_len; ++i, ++p, --count)
>  		if (__put_user(nvram_read_byte(i), p))
>  			return -EFAULT;
>  	*ppos = i;
> @@ -74,9 +76,9 @@ static ssize_t write_nvram(struct file *file, const char __user *buf,
>  
>  	if (!access_ok(VERIFY_READ, buf, count))
>  		return -EFAULT;
> -	if (*ppos >= NVRAM_SIZE)
> +	if (*ppos >= nvram_len)
>  		return 0;
> -	for (i = *ppos; count > 0 && i < NVRAM_SIZE; ++i, ++p, --count) {
> +	for (i = *ppos; count > 0 && i < nvram_len; ++i, ++p, --count) {
>  		if (__get_user(c, p))
>  			return -EFAULT;
>  		nvram_write_byte(c, i);
> @@ -133,9 +135,20 @@ static struct miscdevice nvram_dev = {
>  
>  int __init nvram_init(void)
>  {
> +	int ret = 0;
> +
>  	printk(KERN_INFO "Generic non-volatile memory driver v%s\n",
>  		NVRAM_VERSION);
> -	return misc_register(&nvram_dev);
> +	ret = misc_register(&nvram_dev);
> +	if (ret != 0)
> +		goto out;
> +
> +	nvram_len = nvram_size();
> +	if (nvram_len < 0)
> +		nvram_len = NVRAM_SIZE;
> +
> +out:
> +	return ret;
>  }
>  
>  void __exit nvram_cleanup(void)
