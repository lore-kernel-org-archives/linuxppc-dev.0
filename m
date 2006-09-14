Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7599B67B7C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Sep 2006 11:55:36 +1000 (EST)
Date: Wed, 13 Sep 2006 18:48:52 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Aleck Lin <aleck@gdatech.com>
Subject: Re: Ethernet driver for Linux kernel 2.6 running on ML403
Message-ID: <20060914014852.GA8375@gate.ebshome.net>
References: <mailman.241.1158193867.2423.linuxppc-embedded@ozlabs.org>
	<002501c6d79e$cca7ee40$800101df@monstertop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <002501c6d79e$cca7ee40$800101df@monstertop>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Sep 13, 2006 at 06:40:40PM -0700, Aleck Lin wrote:
> Hi,
> 
> I'm able to boot Linux 2.6 on ML403 board (with a ramdisk file system).
> 
> However, during the kernel booting, it complains that "No network devices
> available," So I figured I probably didn't enable the ethernet driver in the
> kernel. 
> 
> >From doing "make menuconfig", under "Device Drivers" --> "Network device
> support" --> "Ethernet(10 or 100Mbit)", I checked the box of both "Ethernet
> (10 or 100Mbit)" and "PowerPC 4xx on-chip Ethernet support." I then
> save/exit the menuconfig to compile the kernel again. I've attached the
> error output at the bottom.
> 
> The problem is that I don't have any define in my .config file that matches
> "CONFIG_405GP", "CONFIG_405GPR" or "CONFIG_405EP" in the
> /drivers/net/ibm_emac/ibm_emac.h file, so it complains that I might not have
> correct defines. 

Yes, I put that check there exactly to prevent people from using my 
driver on non-compatible hardware :).

> 1st question: Which one of the CONFIG_405xxx should I use? I was searching
> around but couldn't find an answer, but my intuition tells me that it should
> probably be CONFIG_405GP.

No.

> 2nd question: So I decided to try with CONFIG_405GP just to see what
> happens. However, some compilation errors were still there. And it complains
> about "dereferencing pointer to incomplete type". Does anyone have any
> experience working with this driver and perhaps found that there's an error
> in the kernel for this driver?

This driver isn't for your chip and simply cannot work.

-- 
Eugene
