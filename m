Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 70662DDF6E
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 19:36:11 +1100 (EST)
Date: Tue, 30 Jan 2007 09:36:09 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/9] ps3: Preallocate bootmem memory for ps3fb
In-Reply-To: <200701300927.52087.arnd@arndb.de>
Message-ID: <Pine.LNX.4.62.0701300934270.4728@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<1170124157.19887.116.camel@concordia.ozlabs.ibm.com>
	<Pine.LNX.4.62.0701300914580.4728@pademelon.sonytel.be>
	<200701300927.52087.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>, James Simmons <jsimmons@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 30 Jan 2007, Arnd Bergmann wrote:
> On Tuesday 30 January 2007 09:16, Geert Uytterhoeven wrote:
> > We have a similar problem with the storage driver, which needs a block of 256
> > KiB of contiguous memory.
> 
> I guess at least that one should be solveable. If the 256kb is only
> internal flash access, it is should not be part of the storage driver
> but of whatever else is used to drive this.

If we convert the FLASH part to a character device driver, the 256 KiB will be
internal to the character device driver.

> Assuming the module gets loaded shortly after boot, you can still allocate
> 256kb practically always, using get_free_pages().

I'm afraid that assumption is usually false, as you only need to access the
FLASH when you want to change boot flags or update the boot loader.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
