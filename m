Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17545.17329.227226.926906@cargo.ozlabs.ibm.com>
Date: Fri, 9 Jun 2006 19:47:29 +1000
From: Paul Mackerras <paulus@samba.org>
To: mostrows@watson.ibm.com
Subject: Re: [PATCH] Provide mechanism for editing builtin command-line in
	zImage binary.
In-Reply-To: <11489544631499-git-send-email-mostrows@watson.ibm.com>
References: <11489544631499-git-send-email-mostrows@watson.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michal Ostrowski writes:

> -BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj)
> +BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj) -I$(O)/include -I$(O)/include2\
> +			-D__KERNEL__

I don't like this; we are trying to keep the boot wrapper separate,
not make it more dependent on the rest of the kernel.

> +#include <linux/autoconf.h>
> +#include <asm/setup.h>

We don't really need COMMAND_LINE_SIZE here - nothing says the command
line from the firmware or the boot wrapper *has* to be the same size
as the kernel's command-line buffer.

> +static char builtin_cmdline[COMMAND_LINE_SIZE]
> +		__attribute__((section("__builtin_cmdline"))) = CONFIG_CMDLINE;
> +#endif

If CONFIG_CMDLINE is set, then the kernel image *already* has the
default in it, and we don't need another copy here.  Just make your
buffer here some fixed, known size and uninitialized (i.e. all
zeroes).  Do the setprop if the /chosen/bootargs is empty and your
buffer has been edited to be non-null.

Paul.
