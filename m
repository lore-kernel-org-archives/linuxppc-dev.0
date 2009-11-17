Return-Path: <cbouatmailru@gmail.com>
Received: from mail-bw0-f223.google.com (mail-bw0-f223.google.com
	[209.85.218.223]) by ozlabs.org (Postfix) with ESMTP id 708B9B7B93
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 03:12:50 +1100 (EST)
Received: by bwz23 with SMTP id 23so152243bwz.9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 08:12:48 -0800 (PST)
Date: Tue, 17 Nov 2009 19:12:44 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [RFC PATCH 1/5] Rework OpenFirmware GPIO handling
Message-ID: <20091117161244.GA6849@oksana.dev.rtsoft.ru>
References: <1258472546-31343-1-git-send-email-dbaryshkov@gmail.com>
	<1258472546-31343-2-git-send-email-dbaryshkov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1258472546-31343-2-git-send-email-dbaryshkov@gmail.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	David Brownell <dbrownell@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 17, 2009 at 06:42:22PM +0300, Dmitry Eremin-Solenikov wrote:
> This patch improves OF GPIO bindings so, that most non-OF-specific gpio
> controllers don't need to call any of OF binding function:
> 
> 0) Move of_gpio_chip into main gpio_chip structure.
> 1) Call of_gpio_init/destroy from gpiochip_add/remove.
> 2) By default supply reasonable defaults for gpio_cells/xlate

Heh.. you didn't google before writing the code, did you? ;-)

I don't really think that David will like this approach, just as
he didn't like the previous one (which was even less intrusive,
but still wrong):

http://lkml.org/lkml/2008/10/16/248 (a huge thread, but worth reading)

Both of the approaches do not solve the pdata issue.

There are some of David's [absolutely legitimate] comments:
http://lkml.org/lkml/2008/10/20/43

Some more thoughts:
http://lkml.org/lkml/2008/10/20/182

And it turned out that the only sane solution is to write
OF-pdata-hooks for the each driver (that we do for many drivers
already):

http://lkml.org/lkml/2008/10/22/471

And for this, you'll need the patches that I sent to you
yesterday.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
