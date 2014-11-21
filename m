Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7A5871A0185
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Nov 2014 22:51:33 +1100 (AEDT)
Message-ID: <546F25EE.5090601@users.sourceforge.net>
Date: Fri, 21 Nov 2014 12:45:50 +0100
From: SF Markus Elfring <elfring@users.sourceforge.net>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.cz>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/1] tty-hvsi_lib: Deletion of an unnecessary check before
 the function call "tty_kref_put"
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
In-Reply-To: <5317A59D.4@users.sourceforge.net>
Content-Type: text/plain; charset=windows-1252
Cc: Julia Lawall <julia.lawall@lip6.fr>, kernel-janitors@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 21 Nov 2014 12:40:32 +0100

The tty_kref_put() function tests whether its argument is NULL and then
returns immediately. Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/tty/hvc/hvsi_lib.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvsi_lib.c b/drivers/tty/hvc/hvsi_lib.c
index 7ae6c29..a270f04 100644
--- a/drivers/tty/hvc/hvsi_lib.c
+++ b/drivers/tty/hvc/hvsi_lib.c
@@ -405,8 +405,7 @@ void hvsilib_close(struct hvsi_priv *pv, struct hvc_struct *hp)
 		hvsi_send_close(pv);
 	}
 
-	if (pv->tty)
-		tty_kref_put(pv->tty);
+	tty_kref_put(pv->tty);
 	pv->tty = NULL;
 }
 
-- 
2.1.3
