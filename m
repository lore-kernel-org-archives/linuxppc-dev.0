Return-Path: <colin@colino.net>
Received: from paperstreet.colino.net (colino.net [213.41.131.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CC5D82BC0F
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Oct 2004 01:59:47 +1000 (EST)
Received: from pirandello (asap.atchik.net [195.167.234.210])
	by paperstreet.colino.net (Postfix) with ESMTP id 6326A73E9
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Oct 2004 17:59:26 +0200 (CEST)
Date: Fri, 22 Oct 2004 17:59:23 +0200
From: Colin Leroy <colin@colino.net>
Cc: Linux PPC Dev <linuxppc-dev@ozlabs.org>
Message-ID: <20041022175923.21b11f18.colin@colino.net>
In-Reply-To: <20041022173046.003bf2ea.colin@colino.net>
References: <20041022173046.003bf2ea.colin@colino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: hda errors on iBook G4
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 22 Oct 2004 at 17h10, Colin Leroy wrote:

Hi, 

> I noticed hda status errors in my iBook G4's dmesg quite a long time
> ago, but never looked any more... Today I just ran tests with hdparm
> and this looks like really reproduceable:

I found one strange thing in drivers/ide/ppc/pmac.c:

pmac_ide_do_setfeature(ide_drive_t *drive, u8 command) {...}

pmac_ide_udma_enable(ide_drive_t *drive, u16 mode)
{...
	ret = pmac_ide_do_setfeature(drive, mode);
...}

We really want to pass u16 to the function taking an u8 arg?
(just a wild shot, it's probably wanted, but i thought i'd share).

-- 
Colin
