Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1outboundpool.messaging.microsoft.com [216.32.181.186])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3A7761007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  3 May 2011 05:46:05 +1000 (EST)
Message-ID: <4DBF065C.3030407@freescale.com>
Date: Mon, 2 May 2011 14:30:36 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: <linuxppc-dev@lists.ozlabs.org>, devicetree-discuss
	<devicetree-discuss@ozlabs.org>, <linux-fbdev@vger.kernel.org>
Subject: Login prompt on a video console instead of serial port?
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm using a Freescale P1022DS (PowerPC e500 core) system, which has a built-in
video controller.  I have a framebuffer driver that works fine, and if I add
"video=fslfb:1280x1024-32@60,monitor=0 console=tty0" to the command-line, then
*most* of the kernel boot log appears on the serial port and the video display.

However, the login prompt is always on the serial port.  This happens even if I
delete the "console=ttyS0,115200" from the command-line.  I presume this is
because the "linux,stdout-path" property in the device tree always points to a
serial port node.

So my question is: what do I need to do get the login prompt on the video
console?  That is, stdout goes to /dev/fb0 but stdin is still from /dev/ttyS0.
I presume I need to direct "linux,stdout-path" to the fslfb node in the device
tree, but there doesn't appear to be support for "linux,stdin-path".

-- 
Timur Tabi
Linux kernel developer at Freescale
