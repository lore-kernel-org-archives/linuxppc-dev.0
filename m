Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E0766DE0AA
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 12:20:43 +1100 (EST)
Message-ID: <45B805E1.1030906@garzik.org>
Date: Wed, 24 Jan 2007 20:20:33 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: [PATCH] driver/ata: PATA driver	for Celleb
References: <200701170924.l0H9OsdG002754@harpo.it.uu.se>
	<45AE539E.2040600@garzik.org>
	<17838.34747.222649.93821@alkaid.it.uu.se>
	<200701180055.l0I0tl6M021051@toshiba.co.jp>
	<200701180129.l0I1TL48013407@toshiba.co.jp>
In-Reply-To: <200701180129.l0I1TL48013407@toshiba.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Mikael Pettersson <mikpe@it.uu.se>, arnd@arndb.de, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org, paulus@samba.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Akira Iguchi wrote:
> This is the patch for PATA controller of Celleb.
> It depends on the previous "add another IRQ calls" patch.
> 
> Because this driver needs special taskfile accesses, there is
> a copy of ata_std_softreset(). ata_dev_try_classify() is exported
> so that it can be used in this function.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>

The driver looks OK, the only thing I wonder is:  can you use the iomap 
interface to eliminate the rest of the duplicated code?

See Tejun's latest patchset "[PATCHSET] Managed device resources, take 
#3" which completes the conversion of libata to using the lib/iomap.c 
interface.

	Jeff
