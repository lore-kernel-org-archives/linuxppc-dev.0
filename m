Return-Path: <adobriyan@gmail.com>
Received: from mail-fx0-f222.google.com (mail-fx0-f222.google.com
	[209.85.220.222]) by ozlabs.org (Postfix) with ESMTP id 881F0B7C32
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  9 Jan 2010 22:01:19 +1100 (EST)
Received: by fxm22 with SMTP id 22so22574600fxm.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 09 Jan 2010 03:01:15 -0800 (PST)
Date: Sat, 9 Jan 2010 13:01:04 +0200
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jeremy Kerr <jeremy.kerr@canonical.com>
Subject: Re: [PATCH] proc_devtree: fix THIS_MODULE without module.h
Message-ID: <20100109110104.GA20100@x200>
References: <1262830753.577814.127040702434.1.gpush@pororo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1262830753.577814.127040702434.1.gpush@pororo>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 07, 2010 at 01:19:13PM +1100, Jeremy Kerr wrote:
> Commit e22f628395432b967f2f505858c64450f7835365 introduced a build
> breakage for ARM devtree work: the THIS_MODULE macro was added, but we
> don't have module.h
> 
> This change adds the necessary #include to get THIS_MODULE defined.
> While we could just replace it with NULL (PROC_FS is a bool, not a
> tristate), using THIS_MODULE will prevent unexpected breakage if we
> ever do compile this as a module.

I'd say, remove .owner line.
It definitely not needed in non-modular code.

> --- a/fs/proc/proc_devtree.c
> +++ b/fs/proc/proc_devtree.c
> @@ -11,6 +11,7 @@
>  #include <linux/stat.h>
>  #include <linux/string.h>
>  #include <linux/of.h>
> +#include <linux/module.h>
