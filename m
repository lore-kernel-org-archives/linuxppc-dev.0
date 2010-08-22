Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
	by ozlabs.org (Postfix) with ESMTP id DE201B70D0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 22 Aug 2010 21:39:35 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] pmu: add compat_pmu_ioctl
Date: Sun, 22 Aug 2010 13:33:50 +0200
References: <m2lj7zzm6w.fsf@igel.home>
In-Reply-To: <m2lj7zzm6w.fsf@igel.home>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201008221333.50575.arnd@arndb.de>
Cc: Andreas Schwab <schwab@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Saturday 21 August 2010 23:32:23 Andreas Schwab wrote:
> The ioctls are actually compatible, but due to historical mistake the
> numbers differ between 32bit and 64bit.

Looks good to me, but

> +#ifdef CONFIG_COMPAT
> +#define PMU_IOC_GET_BACKLIGHT32	_IOR('B', 1, u32)
> +#define PMU_IOC_SET_BACKLIGHT32	_IOW('B', 2, u32)
> +#define PMU_IOC_GET_MODEL32	_IOR('B', 3, u32)
> +#define PMU_IOC_HAS_ADB32	_IOR('B', 4, u32)
> +#define PMU_IOC_CAN_SLEEP32	_IOR('B', 5, u32)
> +#define PMU_IOC_GRAB_BACKLIGHT32 _IOR('B', 6, u32)

It would be nicer to use compat_size_t instead of u32 for annotation
purposes. Obviously both of them are defined as unsigned int, so
that is no functional change.

> +	return pmu_unlocked_ioctl(filp, cmd, arg);

This should ideally use "(unsigned long)compat_ptr(arg)" instead of
just arg. Also doesn't matter on powerpc, but it's better to do
it the strict way.

	Arnd
