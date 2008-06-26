Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 970FBDDEDF
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 01:49:24 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: monstr@seznam.cz
Subject: Re: [PATCH 58/60] microblaze_v4: sys_microblaze.c
Date: Thu, 26 Jun 2008 17:48:29 +0200
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-58-git-send-email-monstr@seznam.cz>
	<1214483429-32360-59-git-send-email-monstr@seznam.cz>
In-Reply-To: <1214483429-32360-59-git-send-email-monstr@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200806261748.30698.arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com,
	John.Linn@xilinx.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 26 June 2008, monstr@seznam.cz wrote:
> +
> +/*
> + * sys_ipc() is the de-multiplexer for the SysV IPC calls..
> + *
> + * This is really horribly ugly.
> + */

If it's so horribly ugly, don't do it this way ;-)

> +int
> +sys_ipc(uint call, int first, int second, int third, void *ptr, long fifth)
> +{
> +	int version, ret;
> +
> +	version = call >> 16; /* hack for backward compatibility */
> +	call &= 0xffff;

Backwards compatibility with what?


> +static inline unsigned long
> +do_mmap2(unsigned long addr, size_t len,
> +	unsigned long prot, unsigned long flags,
> +	unsigned long fd, unsigned long pgoff)
> +{
> +	struct file *file = NULL;
> +	int ret = -EBADF;
> +
> +	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
> +	if (!(flags & MAP_ANONYMOUS))
> +		if (!(file = fget(fd))) {
> +			printk(KERN_INFO "no fd in mmap\r\n");
> +			goto out;
> +		}
> +
> +	down_write(&current->mm->mmap_sem);
> +	ret = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
> +	up_write(&current->mm->mmap_sem);
> +	if (file)
> +		fput(file);
> +out:
> +	return ret;
> +}
> +
> +unsigned long sys_mmap2(unsigned long addr, size_t len,
> +			unsigned long prot, unsigned long flags,
> +			unsigned long fd, unsigned long pgoff)
> +{
> +	return do_mmap2(addr, len, prot, flags, fd, pgoff);
> +}
> +
> +unsigned long sys_mmap(unsigned long addr, size_t len,
> +			unsigned long prot, unsigned long flags,
> +			unsigned long fd, off_t offset)
> +{
> +	int err = -EINVAL;
> +
> +	if (offset & ~PAGE_MASK) {
> +		printk(KERN_INFO "no pagemask in mmap\r\n");
> +		goto out;
> +	}
> +
> +	err = do_mmap2(addr, len, prot, flags, fd, offset >> PAGE_SHIFT);
> +out:
> +	return err;
> +}

Which mmap is uClibc really using? I suppose you only need mmap2, even for
compatibility with any binary ever built for microblaze.

	Arnd <><
