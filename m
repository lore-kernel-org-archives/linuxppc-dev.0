Return-Path: <cmetcalf@tilera.com>
Received: from USMAMAIL.TILERA.COM (usmamail.tilera.com [206.83.70.75])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "usmamail.tilera.com",
	Issuer "Go Daddy Secure Certification Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 40CE2B6FB0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Jun 2011 07:01:46 +1000 (EST)
Message-ID: <4DED4030.9050503@tilera.com>
Date: Mon, 6 Jun 2011 17:01:36 -0400
From: Chris Metcalf <cmetcalf@tilera.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/7] [v2] drivers/misc: introduce Freescale hypervisor
	management driver
References: <1306953337-15698-1-git-send-email-timur@freescale.com>
	<201106061803.58531.arnd@arndb.de> <4DECFBC5.6070205@freescale.com>
	<201106061824.53844.arnd@arndb.de>
In-Reply-To: <201106061824.53844.arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: kumar.gala@freescale.com, linux-kernel@vger.kernel.org, akpm@kernel.org,
	Deepak Saxena <dsaxena@linaro.org>,
	linux-console@vger.kernel.org, greg@kroah.com,
	linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6/6/2011 12:24 PM, Arnd Bergmann wrote:
> On Monday 06 June 2011, Timur Tabi wrote:.
>> And what about my concern that my driver will be the only one in drivers/virt?
> I have no doubt that more of these will come. Chris Metcalf is currently
> looking for a home for his tilera hypervisor drivers, and we have the
> microsoft hyperv drivers in drivers/staging, so they will hopefully
> move to a proper place later. We also have similar drivers in other
> places, e.g. drivers/ps3/ps3-sys-manager.c, drivers/s390/char/vmcp.c
> or parts of drivers/xen.

It might help if someone (Arnd?) wanted to propose a statement of what
drivers/virt was really for.  If it's for any Linux driver that upcalls to
a hypervisor for any reason, then the Tilera paravirtualized drivers fit in
well.  If it's intended more for drivers that guests running under a
hypervisor can use to talk to the hypervisor itself (e.g. managing
notifications that a hypervisor delivers to a guest to cause it to shut
down or take other actions), then it doesn't seem like the Tilera
paravirtualized device drivers belong there, since they're just using the
Tilera hypervisor synchronously to do I/O or get/set device and driver state.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
