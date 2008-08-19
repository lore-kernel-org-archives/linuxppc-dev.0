Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 97BA2DE044
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 19:02:59 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Corrections please ...
Date: Tue, 19 Aug 2008 11:02:53 +0200
References: <48A9E2C6.1030205@hypersurf.com>
In-Reply-To: <48A9E2C6.1030205@hypersurf.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808191102.53911.arnd@arndb.de>
Cc: Kevin Diggs <kevdig@hypersurf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 18 August 2008, Kevin Diggs wrote:
> Subject: Corrections please ...

The subject should be the one line change log, e.g.

[PATCH] add kerneldoc comments for completion.h

Also, cc the maintainer of the code. If you can't tell
from the MAINTAINERS file, look for the most common
name when doing 'git log path/to/file.c'. In this case,
there does not seem to be an actual maintainer, but I
would expect Willy and Ingo to be interested in the code.

Read Documentation/SubmittingPatches.

> Could I get any needed corrections on this. Especially on the "???"
> 

The introductory text should explain why the patch is needed.
If you have more comments, put them behind the changelog text,
under a '---' line.

> [kevdig@PowerMac8600B linux-2.6.26]$ diff -U3 
> include/linux/completion.{h.orig,h}|more
> --- include/linux/completion.h.orig     2008-08-13 00:56:52.000000000 -0700
> +++ include/linux/completion.h  2008-08-18 13:00:23.000000000 -0700

Patches should be in -p1 format. Best use a tool like quilt, git or
mercurial to generate the patch instead of doing it by hand.

> @@ -10,6 +10,16 @@
> 
>   #include <linux/wait.h>
> 
> +/**
> + * struct completion - structure used to maintain state for a "completion"
> + * @done:  counting variable used to signal completion
> + * @wait:  internal wait queue head; used for locking and synchronization
> + *
> + * This is the structure used to maintain the state for a "completion". See
> + * also:  complete(), wait_for_completion() (and friends _timeout,
> + * _interruptible, _interruptible_timeout, and _killable), 
> init_completion(),
> + * and macros DECLARE_COMPLETION() and INIT_COMPLETION().
> + */

Line wrapping is broken, you need the right settings for sending unmodified
emails from your mail client.

	Arnd <><
