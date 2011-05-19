Return-Path: <B04825@freescale.com>
Received: from CH1EHSOBE005.bigfish.com (ch1ehsobe004.messaging.microsoft.com
	[216.32.181.184]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A19EAB6F7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 01:09:26 +1000 (EST)
Message-ID: <4DD5329C.2040200@freescale.com>
Date: Thu, 19 May 2011 10:09:16 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6/7] tty/powerpc: introduce the ePAPR embedded hypervisor
	byte channel driver
References: <1305813272-31826-1-git-send-email-timur@freescale.com>
	<1305813272-31826-7-git-send-email-timur@freescale.com>
	<201105191702.39919.arnd@arndb.de>
In-Reply-To: <201105191702.39919.arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: kumar.gala@freescale.com, linux-kernel@vger.kernel.org, akpm@kernel.org,
	linux-console@vger.kernel.org, greg@kroah.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> Why is this using a full tty driver instead of the hvc framework that most
> other hypervisor consoles use?

Because HVC uses the same interface for consoles and tty, and that resulted in
dropped characters if the client driver returns EAGAIN because it's output
buffer is full.  I posted a patch that "fixes" this, but it was rejected.
Here's the original patch:

http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-August/085136.html

And here's the thread discussing our concerns:

http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-September/thread.html

(search for "fix dropping of characters when output byte channel is full")

-- 
Timur Tabi
Linux kernel developer at Freescale
