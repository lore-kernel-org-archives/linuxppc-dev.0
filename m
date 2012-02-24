Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe001.messaging.microsoft.com
 [65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AF131B6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2012 09:15:21 +1100 (EST)
Message-ID: <4F480BE8.9080606@freescale.com>
Date: Fri, 24 Feb 2012 16:15:04 -0600
From: Timur Tabi <b04825@freescale.com>
MIME-Version: 1.0
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: warnings from drivers/tty/ehv_bytechan.c
References: <20120220072352.4c8131bbcea69afc007a4297@canb.auug.org.au>
 <4F424985.2020706@freescale.com> <20120224215008.GB25330@kroah.com>
 <4F48086C.5010407@freescale.com> <20120224220623.GA29400@kroah.com>
In-Reply-To: <20120224220623.GA29400@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

gregkh@linuxfoundation.org wrote:
>> > That's the simplest approach, for use.  The TTY portion of the driver can
>> > be used as a module.  Is there any real value in loading a TTY driver as a
>> > module?

> Depends on the hardware it supports :)
> 
>> > In this case, the console support for byte channels would not be
>> > available.

> Then it doesn't make sense, right?

I guess that's my question.  Is there a real use case for having console
output go to the serial port, and TTY go to a byte channel?  Even if you
wanted to do that, I supposed you don't need to load the byte channel
driver as a module to get that behavior.

Anyway, that's all academic.  A more important question is: now that the
driver can't be compiled as a module, should I change module_init() to
something else (like device_initcall)?

Should I remove this line?

	#include <linux/module.h>
	
-- 
Timur Tabi
Linux kernel developer at Freescale
