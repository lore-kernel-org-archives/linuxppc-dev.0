Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BD02BDDF0C
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 03:58:45 +1100 (EST)
Message-ID: <45A7BE3A.40508@garzik.org>
Date: Fri, 12 Jan 2007 11:58:34 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: [PATCH 0/4] drivers/ata: add low-level I/O calls
References: <200701120958.l0C9wICB019343@toshiba.co.jp>
In-Reply-To: <200701120958.l0C9wICB019343@toshiba.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Akira Iguchi wrote:
> Dear everyone,
> 
> This is the patchset (based on 2.6.20-rc4) to add low-level I/O calls
> which access the taskfile registers. The idea comes from drivers/ide
> IN*/OUT* calls.
> 
> As you know, these calls are unnecessary for most libata drivers.
> But the Celleb PATA driver needs them to use the libata common code.
> And using these calls, it is possible to remove similar code
> about PIO/MMIO access.

Sorry, but NAK.

libata intentionally provides higher level hooks than just I/O accessors.

A low level I/O hook approach makes it difficult to take into account 
platform-specific details like mmiowb(), especially on embedded platforms.

The high level hook approach also enables greater efficiency.  For 
example, an embedded platform could do

	__raw_writeb(datum, mmio_address + ATA_REG_FOO);
	__raw_writeb(datum, mmio_address + ATA_REG_BAR);
	eieio();

to optimize an entire taskfile-read or taskfile-write operation.

	Jeff
