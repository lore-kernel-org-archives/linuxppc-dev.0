Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0F286DDDEA
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Dec 2008 11:11:13 +1100 (EST)
Date: Mon, 22 Dec 2008 03:11:07 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 2/3] powerpc: Make default kexec/crash_kernel ops implicit
Message-ID: <20081222001107.GA26630@oksana.dev.rtsoft.ru>
References: <20081216162217.GA3885@oksana.dev.rtsoft.ru>
	<20081216162305.GB21749@oksana.dev.rtsoft.ru>
	<1229900922.8269.15.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <1229900922.8269.15.camel@localhost>
Cc: Paul Mackerras <paulus@samba.org>, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 22, 2008 at 10:08:42AM +1100, Michael Ellerman wrote:
> On Tue, 2008-12-16 at 19:23 +0300, Anton Vorontsov wrote:
> > This patch removes need for each platform to specify default kexec and
> > crash kernel ops, thus effectively adds a working kexec support for most
> > boards.
> > 
> > Platforms that can't cope with default ops will explode in some weird
> > way (a hang or reboot is most likely), which means that the board's
> > kexec support should be fixed or blacklisted via dummy _prepare callback
> > returning -ENOSYS.
> 
> But where is the patch to do this?

The -ENOSYS dummy callback is a last resort thing to do when nobody
cares or it's impossible to fix the Kexec on some board. We don't
have any such boards (yet).

> The chance of kexec working on some random machine that's never been
> tested is pretty slim, every driver needs to be aware its hardware might
> be in a weird state,

The boards setup isn't always static. The Kexec might work perfectly
well on a standalone board, but might hang with some weird PCI device
attached to it (think that it might need some PCI fixup on shutdown).

I think that a "Kexec tested to work on a particular board" term
just doesn't exist. It might work, but it might hang with other setup
on the *same* board.

But in practice the Kexec work on every 6xx board I have. And I have
pretty much of Freescale boards (almost all from the 83xx series),
and I don't think it's practical to add #ifdef CONFIG_KEXEC into the
every board file...

Thus I don't think that disabling Kexec by default is a good idea.

Plus, note that PowerPC port is the only one that disables Kexec
by default (all other arches permit Kexec by default).

> so enabling it by default is not a good idea IMHO.

Why? A hang or plain/watchdog reboot is OK since kexec is as
dangerous as trying to boot another kernel using "reboot ->
u-boot -> new kernel" sequence -- it might not work, the new
kernel might not boot for some reason.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
