Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B612DB6F8A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 00:28:19 +1000 (EST)
Message-ID: <4DD528E8.20203@freescale.com>
Date: Thu, 19 May 2011 09:27:52 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 6/7] tty/powerpc: introduce the ePAPR embedded hypervisor
	byte channel driver
References: <1305813272-31826-1-git-send-email-timur@freescale.com>
	<1305813272-31826-7-git-send-email-timur@freescale.com>
	<20110519142225.GC21441@kroah.com>
In-Reply-To: <20110519142225.GC21441@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: kumar.gala@freescale.com, linux-kernel@vger.kernel.org, akpm@kernel.org,
	linux-console@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg KH wrote:
> Why do this conversion in the driver?  Shouldn't that be something that
> userspace worries about?

The udbg interface is a very early kernel printk interface.  I don't know what
the "u" stands for, but "dbg" is for "debug".  The udbg interface is removed
once a normal console driver kicks in.

This is why I need to specify the byte channel handle via Kconfig.  This code is
used so early that not even the device tree is available.

All of the udbg_putc functions do this.

-- 
Timur Tabi
Linux kernel developer at Freescale
