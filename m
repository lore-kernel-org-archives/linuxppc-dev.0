Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tVLKy0DBfzDvkq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2016 15:10:46 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andreas Schwab <schwab@linux-m68k.org>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2] adb: properly mark continued kernel messages
In-Reply-To: <87oa0zpcvg.fsf_-_@linux-m68k.org>
References: <87r35ynzoe.fsf@linux-m68k.org>
 <1480200189.11342.4.camel@au1.ibm.com> <87oa0zpcvg.fsf_-_@linux-m68k.org>
Date: Fri, 02 Dec 2016 15:10:43 +1100
Message-ID: <877f7j7yyk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Use pr_cont where appropriate, and switch to pr_foo throughout.
> Additionally, lower messages in adb_probe_task to debug level.
>
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> ---
>  drivers/macintosh/adb.c    | 24 +++++++++-----------
>  drivers/macintosh/adbhid.c | 56 +++++++++++++++++++++++-----------------------
>  2 files changed, 39 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
> index 226179b975..5abc265383 100644
> --- a/drivers/macintosh/adb.c
> +++ b/drivers/macintosh/adb.c
> @@ -206,18 +206,17 @@ static int adb_scan_bus(void)
>  	}
>  
>  	/* Now fill in the handler_id field of the adb_handler entries. */
> -	printk(KERN_DEBUG "adb devices:");
> +	pr_debug("adb devices:\n");

Unfortunately pr_debug() is not directly equivalent to printk(KERN_DEBUG).
The latter always prints at DEBUG level, the former prints at DEBUG
level if it is enabled via dynamic debug, or if DEBUG is #defined in the
source.

So in general using pr_debug() means the messages won't be printed,
unless a user takes some action to enable it.

Perhaps in this case that's actually what we want to do, but if so we
should call it out in the change log.

cheers
