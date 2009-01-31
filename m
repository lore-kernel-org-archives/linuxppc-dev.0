Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id BC5ABDE15A
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2009 21:25:51 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Dynamic-ftrace not working in PlayStation3
Date: Sat, 31 Jan 2009 11:25:34 +0100
References: <a25370a30901260639u3ab97112qf6688667d39e6706@mail.gmail.com>
	<alpine.DEB.1.10.0901292234520.6222@gandalf.stny.rr.com>
	<4983BFA2.9010703@am.sony.com>
In-Reply-To: <4983BFA2.9010703@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901311125.34755.arnd@arndb.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Remis Lima Baima <remis.developer@googlemail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 31 January 2009, Geoff Levand wrote:
> > 
> > So I take it that the above showed that the code worked for some?
> 
> In my trials it blows up on the first load_module() call, and for my
> config that was usbcore:

I looked into it some more with Remis yesterday, and we got ftrace
working by building usbcore and alsa into the kernel. Incidentally,
usbcore is the largest module in this installation (~3MB), which
indicates that it is in some way either related to the size of the
module.

> This ptr of 5f666f725f726573 seems bogus.  I think this code is not
> working correctly:

This is an ascii string "_for_res", probably part of
usb_lock_device_for_reset. We saw the same behaviour, but
a different string.

	Arnd <><
