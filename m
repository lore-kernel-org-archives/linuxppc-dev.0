Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 938ACDDE19
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jan 2008 11:35:18 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] [2.6.24] Add PPC nvram ioctls to compat_ioctl
Date: Wed, 2 Jan 2008 01:34:41 +0100
References: <20071231224558.GA16517@lixom.net>
In-Reply-To: <20071231224558.GA16517@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801020134.41761.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 31 December 2007, Olof Johansson wrote:
> Fix the following console warning when running 'nvsetenv', and makes
> setting of new variables work again:
> 
> ioctl32(nvsetenv:4022): Unknown cmd fd(3) cmd(20007043){t:'p';sz:0}
> arg(00000003) on /dev/nvram
> 
> That's the IOC_NVRAM_SYNC call.
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
> index e8b7c3a..7be6765 100644
> --- a/fs/compat_ioctl.c
> +++ b/fs/compat_ioctl.c

Please don't. I have this long-term plan of getting rid of fs/compat_ioctl.c,
the better answer is to convert arch/powerpc/kernel/nvram_64.c and
drivers/char/generic_nvram.c from the .ioctl file_operation to
.unlocked_ioctl/.compat_ioctl.

	Arnd <><
