Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 65A1F67B32
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Jul 2006 00:35:47 +1000 (EST)
Date: Sat, 8 Jul 2006 16:35:30 +0200
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Aristeu Sergio Rozanski Filho <aris@valeta.org>
Subject: Re: [PATCH] powermac: defer work in backlight key press
Message-ID: <20060708143530.GA26186@hansmi.ch>
References: <20060704013923.GG27596@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060704013923.GG27596@cathedrallabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 03, 2006 at 10:39:23PM -0300, Aristeu Sergio Rozanski Filho wrote:
> powermac: defer work in backlight key press

> pmac_backlight_key() is called under interrupt context, can't use mutexes or
> semaphores, so defer the backlight level for later, as it's not critical

Nack, needs spinlock around this part:

> +	pmac_backlight_key_queued = direction;
> +	schedule_work(&pmac_backlight_key_work);

I'll submit another patch with more fixes soon.

Greets,
Michael
