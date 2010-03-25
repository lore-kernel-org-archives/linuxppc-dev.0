Return-Path: <anton@ozlabs.org>
Date: Fri, 26 Mar 2010 10:30:31 +1100
From: Anton Blanchard <anton@samba.org>
To: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 4/7] hvc_console: Fix race between hvc_close and hvc_remove
Message-ID: <20100325233031.GC5594@kryten>
References: <20100319151326.GC8541@kroah.com>
	<1269011916-8836-4-git-send-email-gregkh@suse.de>
	<1269119079.8599.65.camel@pasglop>
	<20100321043725.GA21566@amit-x200.redhat.com>
	<20100324121902.GJ15789@amit-x200.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100324121902.GJ15789@amit-x200.redhat.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, a.p.zijlstra@chello.nl,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, tglx@linutronix.de,
	Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 
Hi,

> And this suggests that hvc_kick() is called before hvc_task is
> initialised, ie, before hvc_init() is called.
>
> Does this help?

Looks good, tests OK on my POWER5 box. Thanks!

Tested-by: Anton Blanchard <anton@samba.org>

> diff --git a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
> index ba55bba..50ac983 100644
> --- a/drivers/char/hvc_console.c
> +++ b/drivers/char/hvc_console.c
> @@ -285,6 +285,9 @@ EXPORT_SYMBOL_GPL(hvc_instantiate);
>  /* Wake the sleeping khvcd */
>  void hvc_kick(void)
>  {
> +       if (!hvc_task)
> +               return;
> +
>         hvc_kicked = 1;
>         wake_up_process(hvc_task);
>  }
> 
> 		Amit
