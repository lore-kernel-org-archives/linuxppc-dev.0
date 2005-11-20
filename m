Return-Path: <dwmw2@infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3C4AE687A7
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Nov 2005 11:08:08 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: greg@kroah.com, airlied@linux.ie
In-Reply-To: <1132442389.4084.5.camel@baythorne.infradead.org>
References: <1132442389.4084.5.camel@baythorne.infradead.org>
Content-Type: text/plain
Date: Sun, 20 Nov 2005 00:08:03 +0000
Message-Id: <1132445283.4084.9.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Fix oops in MGA DRM on root bus.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2005-11-19 at 23:19 +0000, David Woodhouse wrote:
> -       if ((pdev->device == 0x0525)
> +       if ((pdev->device == 0x0525) && pdev->bus->self &&
>             && (pdev->bus->self->vendor == 0x3388)
>             && (pdev->bus->self->device == 0x0021)) {
>                 return 0;

Perhaps with one fewer '&&'...

diff --git a/drivers/char/drm/mga_drv.c b/drivers/char/drm/mga_drv.c
--- a/drivers/char/drm/mga_drv.c
+++ b/drivers/char/drm/mga_drv.c
@@ -161,7 +161,7 @@ static int mga_driver_device_is_agp(drm_
 	 * device.
 	 */
 
-	if ((pdev->device == 0x0525)
+	if ((pdev->device == 0x0525) && pdev->bus->self
 	    && (pdev->bus->self->vendor == 0x3388)
 	    && (pdev->bus->self->device == 0x0021)) {
 		return 0;

-- 
dwmw2
