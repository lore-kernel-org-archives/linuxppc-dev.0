Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 23ACCDDFB5
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 18:16:24 +1000 (EST)
Date: Fri, 6 Jun 2008 01:16:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: 2.6.26-rc5 DOA on mac g5
Message-Id: <20080606011619.5082606f.akpm@linux-foundation.org>
In-Reply-To: <20080605215511.85660cdf.akpm@linux-foundation.org>
References: <20080605215511.85660cdf.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 5 Jun 2008 21:55:11 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> Might be a platform thing, might be an ATA thing:

OK, I found Hugh's fix.

Please let's not release 2.6.27 with a 1000-patch bisect-breaking hole
in it.

From: Hugh Dickins <hugh@veritas.com>

Fix G5 SATA irq 18: nobody cared, reported on -rc5 by Olaf Hering: fixlet
to a57c1bade5a0ee5cd8b74502db9cbebb7f5780b2 libata-sff: Fix oops reported
in kerneloops.org for pnp devices with no ctl

Signed-off-by: Hugh Dickins <hugh@veritas.com>
Acked-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
Tested-by: Olaf Hering <olaf@aepfle.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/libata-sff.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/ata/libata-sff.c~libata-fix-g5-sata-broken-on-rc5 drivers/ata/libata-sff.c
--- a/drivers/ata/libata-sff.c~libata-fix-g5-sata-broken-on-rc5
+++ a/drivers/ata/libata-sff.c
@@ -278,7 +278,7 @@ static u8 ata_sff_irq_status(struct ata_
 		    	return status;
 	}
 	/* Clear INTRQ latch */
-	status = ata_sff_check_status(ap);
+	status = ap->ops->sff_check_status(ap);
 	return status;
 }
 
_
