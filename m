Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id 68021B7EB8
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2010 01:09:38 +1100 (EST)
Date: Wed, 27 Jan 2010 17:09:36 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/3] USB: FHCI: Fix build after kfifo rework
Message-ID: <20100127140936.GB31608@oksana.dev.rtsoft.ru>
References: <20100127140809.GA27906@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20100127140809.GA27906@oksana.dev.rtsoft.ru>
Cc: linux-usb@vger.kernel.org, Stefani Seibold <stefani@seibold.net>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After kfifo rework FHCI fails to build:

  CC      drivers/usb/host/fhci-tds.o
drivers/usb/host/fhci-tds.c: In function 'fhci_ep0_free':
drivers/usb/host/fhci-tds.c:108: error: used struct type value where scalar is required
drivers/usb/host/fhci-tds.c:118: error: used struct type value where scalar is required
drivers/usb/host/fhci-tds.c:128: error: used struct type value where scalar is required

This is because kfifos are no longer pointers in the ep struct.
So, instead of checking the pointers, we should now check if kfifo
is initialized.

Reported-by: Josh Boyer <jwboyer@gmail.com>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/usb/host/fhci-tds.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/fhci-tds.c b/drivers/usb/host/fhci-tds.c
index d224ab4..e123289 100644
--- a/drivers/usb/host/fhci-tds.c
+++ b/drivers/usb/host/fhci-tds.c
@@ -105,7 +105,7 @@ void fhci_ep0_free(struct fhci_usb *usb)
 		if (ep->td_base)
 			cpm_muram_free(cpm_muram_offset(ep->td_base));
 
-		if (ep->conf_frame_Q) {
+		if (kfifo_initialized(&ep->conf_frame_Q)) {
 			size = cq_howmany(&ep->conf_frame_Q);
 			for (; size; size--) {
 				struct packet *pkt = cq_get(&ep->conf_frame_Q);
@@ -115,7 +115,7 @@ void fhci_ep0_free(struct fhci_usb *usb)
 			cq_delete(&ep->conf_frame_Q);
 		}
 
-		if (ep->empty_frame_Q) {
+		if (kfifo_initialized(&ep->empty_frame_Q)) {
 			size = cq_howmany(&ep->empty_frame_Q);
 			for (; size; size--) {
 				struct packet *pkt = cq_get(&ep->empty_frame_Q);
@@ -125,7 +125,7 @@ void fhci_ep0_free(struct fhci_usb *usb)
 			cq_delete(&ep->empty_frame_Q);
 		}
 
-		if (ep->dummy_packets_Q) {
+		if (kfifo_initialized(&ep->dummy_packets_Q)) {
 			size = cq_howmany(&ep->dummy_packets_Q);
 			for (; size; size--) {
 				u8 *buff = cq_get(&ep->dummy_packets_Q);
-- 
1.6.5.7
