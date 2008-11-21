Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1B49DDDDFA
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2008 08:22:55 +1100 (EST)
Date: Fri, 21 Nov 2008 13:22:44 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Add support for the nwp serial device
Message-Id: <20081121132244.e9e9fd74.akpm@linux-foundation.org>
In-Reply-To: <200811201501.24000.arnd@arndb.de>
References: <200811201501.24000.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 20 Nov 2008 15:01:23 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> This patch adds support for the nwp serial device which is connected to
> a DCR bus. It uses the of_serial device driver to determine necessary
> properties from the device tree. The supported device is added as serial
> port number 84.

checkpatch has a decent whine over this.  Some of those things you
might decide to ignore, other things tell me that you never ran it
anyway...

I'd suggest that nwpserial_pops and nwpserial_reg be marked const, as
they don't need to be in read/write storage.  Except that doesn't work
because the kernel isn't very const-competent.  Ho hum.


(does a powerpc allmodconfig)

drivers/serial/nwpserial.c:443: warning: data definition has no type or storage class
drivers/serial/nwpserial.c:443: warning: type defaults to 'int' in declaration of 'console_initcall'
drivers/serial/nwpserial.c:443: warning: parameter names (without types) in function declaration
drivers/serial/nwpserial.c:400: warning: 'nwpserial_console_init' defined but not used

The file fails to include linux/init.h.  It should do so, but that
doesn't fix the above.

Apparently it hasn't been tested as a kernel module...
