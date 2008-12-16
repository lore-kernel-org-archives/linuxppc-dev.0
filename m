Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 05051DDF77
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 12:12:11 +1100 (EST)
Date: Mon, 15 Dec 2008 17:11:58 -0800 (PST)
From: Trent Piepho <tpiepho@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] POWERPC: MTD: Add cached map support to physmap_of MTD
	driver
In-Reply-To: <18758.62580.416920.482077@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0812151653050.28806@t2.domain.actdsltmp>
References: <1229365518-20538-1-git-send-email-tpiepho@freescale.com>
	<18758.62580.416920.482077@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, MTD mailing list <linux-mtd@lists.infradead.org>,
	xyzzy@speakeasy.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 16 Dec 2008, Paul Mackerras wrote:
> Trent Piepho writes:
>> The MTD system supports operation where a direct mapped flash chip is
>> mapped twice.  The normal mapping is a standard ioremap(), which is
>> non-cached and guarded on powerpc.  The second mapping is used only for
>> reads and can be cached and non-guarded.  Currently, only the pxa2xx
>> mapping driver makes use of this feature.  This patch adds support to the
>> physmap_of driver on PPC32 platforms for this cached mapping mode.
>
> Note that having two mappings of the same physical address that differ
> in cacheability is a programming error according to the PowerPC
> architecture.
>
> Do you know that the processor implementations where you want to do
> this can cope with having two mappings with different cacheability?

Good question.  It worked for me, but I guess all powerpc32 can't handle
it.

Shame, as it provides a huge speed up.  I suppose an alternative would be
to map the chip twice at different physical addresses, by just configuring
the chip select to be twice the size it should be, and giving them
different cacheability.

Or changing the mapping for writes and then changing it back.  It wouldn't
be necessary to change the whole thing, just the page being written to.
