Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [194.246.123.103])
	by ozlabs.org (Postfix) with ESMTP id 7A5B4B6FB0
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  6 Jun 2011 12:11:23 +1000 (EST)
Date: Sun, 5 Jun 2011 19:11:18 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 3.0-rc1: powerpc hangs at Kernel virtual memory layout
In-Reply-To: <1307000008.29297.59.camel@pasglop>
Message-ID: <alpine.DEB.2.01.1106051907190.21697@trent.utfs.org>
References: <alpine.DEB.2.01.1105311644010.21697@trent.utfs.org>
	<alpine.DEB.2.01.1106011712270.21697@trent.utfs.org>
	<1306983467.29297.51.camel@pasglop>
	<alpine.DEB.2.01.1106012057130.21697@trent.utfs.org>
	<1307000008.29297.59.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: zajec5@gmail.com, linux ppc dev <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2 Jun 2011 at 17:33, Benjamin Herrenschmidt wrote:
> It -looks- to me that something goes wrong in the tty code when a large
> file is piped through a pty, causing the kernel to hang for minutes in
> the workqueue / ldisk flush code. I've just sent an initial report to
> Alan Cox about it and am currently bisecting it.

This was the "tty vs workqueue oddities" thread, right? FWIW, 
55db4c64eddf37 ("Revert "tty: make receive_buf() return the amout of bytes 
received"") seems to have fixed it on this powerpc machine as well.

With your "ssb: pci: Don't call PCIe specific workarounds on PCI cores" 
patch applied, powerpc32 seems to be quite happy with 3.0-rc1+

Thanks,
Christian.
-- 
BOFH excuse #382:

Someone was smoking in the computer room and set off the halon systems.
