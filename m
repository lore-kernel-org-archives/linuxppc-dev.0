Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 46CC9B7B60
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 08:23:37 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id CDEB9DDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 08:23:36 +1000 (EST)
Date: Wed, 19 Aug 2009 02:23:35 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Greg Kroah-Hartman <gregkh@suse.de>,
	David Brownell <dbrownell@users.sourceforge.net>
Subject: [PATCH] USB: fsl_qe_udc: Add fsl,mpc8323-qe-usb compatible entry
Message-ID: <20090818222335.GA28135@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current bindings specify that "fsl,mpc8323-qe-usb" compatible entry
should be used as a base match for QE UDCs, so update the driver to
comply with the bindings.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

On Thu, Apr 02, 2009 at 02:17:11PM -0500, Scott Wood wrote:
> Anton Vorontsov wrote:
> >On Thu, Apr 02, 2009 at 01:42:37PM -0500, Timur Tabi wrote:
> >>Anton Vorontsov wrote:
> >>
> >>>Oh, I was wrong. fsl_qe_udc driver uses mpc8360 compatible for
> >>>matching, so you can't remove it. :-/
> >>Ugh, that's a bug in the driver then.
> >
> >Yes, but that depends on what chip was the first one? MPC8323 or
> >MPC8360?
> 
> Actually, it depends on which one we picked in the devtree binding
> (assuming they're compatible both ways), which appears to be
> mpc8323.

A bit delayed, but here is a patch to fix the issue.

 drivers/usb/gadget/fsl_qe_udc.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
index d701bf4..7881f12 100644
--- a/drivers/usb/gadget/fsl_qe_udc.c
+++ b/drivers/usb/gadget/fsl_qe_udc.c
@@ -2751,6 +2751,10 @@ static int __devexit qe_udc_remove(struct of_device *ofdev)
 /*-------------------------------------------------------------------------*/
 static struct of_device_id __devinitdata qe_udc_match[] = {
 	{
+		.compatible = "fsl,mpc8323-qe-usb",
+		.data = (void *)PORT_QE,
+	},
+	{
 		.compatible = "fsl,mpc8360-qe-usb",
 		.data = (void *)PORT_QE,
 	},
-- 
1.6.3.3
