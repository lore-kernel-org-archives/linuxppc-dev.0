Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F0C62B6F9D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 23:23:51 +1000 (EST)
In-Reply-To: <20110823130253.GA30733@oksana.dev.rtsoft.ru>
References: <1314103121-9857-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20110823130253.GA30733@oksana.dev.rtsoft.ru>
Subject: Re: [PATCH] usb: Allocate pram dynamically.
To: Anton Vorontsov <cbouatmailru@gmail.com>,
	Greg Kroah-Hartman <gregkh@suse.de>
Message-ID: <OFE326D207.0B9CB598-ONC12578F5.0049522F-C12578F5.00499678@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 23 Aug 2011 15:23:46 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Vorontsov <cbouatmailru@gmail.com> wrote on 2011/08/23 15:02:53:

> From: Anton Vorontsov <cbouatmailru@gmail.com>
> To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> Cc: linuxppc-dev@lists.ozlabs.org
> Date: 2011/08/23 15:02
> Subject: Re: [PATCH] usb: Allocate pram dynamically.
>
> On Tue, Aug 23, 2011 at 02:38:41PM +0200, Joakim Tjernlund wrote:
> > MPC832x does not have enough MURAM to do fixed MURAM allocation.
> > Change to dynamic allocation.
> >
> > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
>
> Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
>
> Thanks!
>
> p.s. You probably want to send this to Greg KH, + Cc linux-usb
> mailing list.

Added linux-usb and Greg KH per Antons suggestion.

 Jocke

>From 587137e365ac1ba7e333a09962b3e4b68c587808 Mon Sep 17 00:00:00 2001
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Tue, 23 Aug 2011 11:04:24 +0200
Subject: [PATCH] usb: Allocate pram dynamically.

MPC832x does not have enough MURAM to do fixed MURAM allocation.
Change to dynamic allocation.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 drivers/usb/host/fhci-hcd.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/fhci-hcd.c b/drivers/usb/host/fhci-hcd.c
index c7c8392..98adbe8 100644
--- a/drivers/usb/host/fhci-hcd.c
+++ b/drivers/usb/host/fhci-hcd.c
@@ -622,12 +622,15 @@ static int __devinit of_fhci_probe(struct of_device *ofdev,
 		goto err_pram;
 	}

-	pram_addr = cpm_muram_alloc_fixed(iprop[2], FHCI_PRAM_SIZE);
+	pram_addr = cpm_muram_alloc(FHCI_PRAM_SIZE, 64);
 	if (IS_ERR_VALUE(pram_addr)) {
 		dev_err(dev, "failed to allocate usb pram\n");
 		ret = -ENOMEM;
 		goto err_pram;
 	}
+
+	qe_issue_cmd(QE_ASSIGN_PAGE_TO_DEVICE, QE_CR_SUBBLOCK_USB,
+		     QE_CR_PROTOCOL_UNSPECIFIED, pram_addr);
 	fhci->pram = cpm_muram_addr(pram_addr);

 	/* GPIOs and pins */
--
1.7.3.4
