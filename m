Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from www.etchedpixels.co.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99A9FB7D77
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2010 12:56:19 +1100 (EST)
Date: Sat, 27 Feb 2010 01:33:59 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] hvc_console: Fix a race between hvc_close and hvc_remove
Message-ID: <20100227013359.5e50f032@lxorguk.ukuu.org.uk>
In-Reply-To: <1267184786-4377-1-git-send-email-amit.shah@redhat.com>
References: <1267184786-4377-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +	tty_kref_get(hp->tty);
>  	spin_lock_irqsave(&hp->lock, flags);
>  	tty = hp->tty;
>  
> @@ -830,7 +833,9 @@ int hvc_remove(struct hvc_struct *hp)
>  	 * cleaned up the hvc_struct.
>  	 */
>  	if (tty)
> -		tty_hangup(tty);
> +		tty_vhangup(tty);
> +
> +	tty_kref_put(hp->tty);

You need to deref hp->tty, take the kref under the lock (and indeed do
all assignments to it that way too), then tty_kref_put(tty), otherwise
what stops hp->tty changing during the remove ?

Take a look how tty_port_tty_get() and tty_port.c does it ...

Alan
