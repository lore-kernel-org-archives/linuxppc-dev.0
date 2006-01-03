Return-Path: <ben.collins@ubuntu.com>
Received: from a34-mta01.direcway.com (a34-mta01.direcpc.com [66.82.4.90])
	by ozlabs.org (Postfix) with ESMTP id 39F0668910
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jan 2006 14:29:37 +1100 (EST)
Received: from grayson.internal.net
	(dpc67142247021.direcpc.com [67.142.247.21]) by a34-mta01.direcway.com
	(iPlanet Messaging Server 5.2 HotFix 2.05 (built Mar  3 2005))
	with ESMTP id <0ISH00BILW8ZGQ@a34-mta01.direcway.com> for
	linuxppc-dev@ozlabs.org; Mon, 02 Jan 2006 21:29:35 -0500 (EST)
Date: Mon, 02 Jan 2006 21:29:13 -0500
From: Ben Collins <ben.collins@ubuntu.com>
In-reply-to: <20060102224640.GB27317@hansmi.ch>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Message-id: <1136255354.27583.77.camel@grayson>
MIME-version: 1.0
Content-type: text/plain
References: <20051225212041.GA6094@hansmi.ch>
	<200512252304.32830.dtor_core@ameritech.net>
	<20051231235124.GA18506@hansmi.ch>
	<1136084207.4635.86.camel@localhost.localdomain>
	<20060102224640.GB27317@hansmi.ch>
Cc: linux-kernel@killerfox.forkbomb.ch,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Vojtech Pavlik <vojtech@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on
	Apple	PowerBooks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-01-02 at 23:46 +0100, Michael Hanselmann wrote:

> +static int powerbook_fkeysfirst = 1;
> +module_param_named(pb_fkeysfirst, powerbook_fkeysfirst, bool, 0644);
> +MODULE_PARM_DESC(powerbook_fkeysfirst, "Use fn special keys only while pressing fn");
> +
> +static int powerbook_enablefnkeys = 1;
> +module_param_named(pb_enablefnkeys, powerbook_enablefnkeys, bool, 0644);
> +MODULE_PARM_DESC(powerbook_enablefnkeys, "Enable fn special keys");
> +
> +static int powerbook_enablekeypad = 1;
> +module_param_named(pb_enablekeypad, powerbook_enablekeypad, bool, 0644);
> +MODULE_PARM_DESC(powerbook_enablekeypad, "Enable keypad keys");
> +#endif

I think these should be inverted to, something like
pbook_disable_keypad, pbook_disable_fnkeys and pbook_fnfirst.

Two reasons. First, it just makes more sense to pass a module param to
turn something on (doing powerbook_enablekeypad=0 isn't as intuitive as
pbook_disable_keypad=1). Second reason is that since these are static
vars, defaulting them to uninitialized (leaving them in the bss, as 0)
reduces binary size.

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux
