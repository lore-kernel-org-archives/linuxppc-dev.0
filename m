Return-Path: <ben.collins@ubuntu.com>
Received: from a34-mta01.direcway.com (a34-mta01.direcpc.com [66.82.4.90])
	by ozlabs.org (Postfix) with ESMTP id 966AA68929
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jan 2006 06:19:22 +1100 (EST)
Received: from grayson.internal.net
	(dpc67142247021.direcpc.com [67.142.247.21]) by a34-mta01.direcway.com
	(iPlanet Messaging Server 5.2 HotFix 2.05 (built Mar  3 2005))
	with ESMTP id <0ISJ008VE6ZROS@a34-mta01.direcway.com> for
	linuxppc-dev@ozlabs.org; Tue, 03 Jan 2006 14:19:21 -0500 (EST)
Date: Tue, 03 Jan 2006 14:18:49 -0500
From: Ben Collins <ben.collins@ubuntu.com>
In-reply-to: <20060103191433.GA11169@hansmi.ch>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Message-id: <1136315929.14744.2.camel@grayson>
MIME-version: 1.0
Content-type: text/plain
References: <20051225212041.GA6094@hansmi.ch>
	<200512252304.32830.dtor_core@ameritech.net>
	<20051231235124.GA18506@hansmi.ch>
	<1136084207.4635.86.camel@localhost.localdomain>
	<20060102224640.GB27317@hansmi.ch> <1136255354.27583.77.camel@grayson>
	<20060103191433.GA11169@hansmi.ch>
Cc: linux-kernel@killerfox.forkbomb.ch,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Vojtech Pavlik <vojtech@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key
	on	Apple	PowerBooks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +static int usbhid_pb_fkeyslast = 0;
> +module_param_named(pb_fkeyslast, usbhid_pb_fkeyslast, bool, 0644);
> +MODULE_PARM_DESC(usbhid_pb_fkeyslast, "Use F keys only while pressing fn on PowerBooks");
> +
> +static int usbhid_pb_disablefnkeys = 0;
> +module_param_named(pb_disablefnkeys, usbhid_pb_disablefnkeys, bool, 0644);
> +MODULE_PARM_DESC(usbhid_pb_disablefnkeys, "Disable fn special keys on PowerBooks");
> +
> +static int usbhid_pb_disablekeypad = 0;
> +module_param_named(pb_disablekeypad, usbhid_pb_disablekeypad, bool, 0644);
> +MODULE_PARM_DESC(usbhid_pb_disablekeypad, "Disable keypad keys on PowerBooks");
> +#endif

For it to be useful, you have to not initialize them (since they are
static, they will be zero'd anyway). Initializing them defeats the
purpose.

static int usbhid_pb_fkeyslast;
etc.

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux
