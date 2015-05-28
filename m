Return-Path: <JBeulich@suse.com>
Received: from mail.emea.novell.com (mail.emea.novell.com [130.57.118.101])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 717841A119C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 18:48:37 +1000 (AEST)
Message-Id: <5566EDC6020000780007E67F@mail.emea.novell.com>
Date: Thu, 28 May 2015 09:28:22 +0100
From: "Jan Beulich" <JBeulich@suse.com>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: "David Vrabel" <david.vrabel@citrix.com>,
 "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
 "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH] hvc_xen: avoid uninitialized variable warning
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Older compilers don't recognize that "v" can't be used uninitialized;
other code using hvm_get_parameter() zeros the value too, so follow
suit here.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
---
 drivers/tty/hvc/hvc_xen.c         |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- 4.1-rc5/drivers/tty/hvc/hvc_xen.c
+++ 4.1-rc5-xen-unint-warnings/drivers/tty/hvc/hvc_xen.c
@@ -302,7 +302,7 @@ static int xen_initial_domain_console_in
 static void xen_console_update_evtchn(struct xencons_info *info)
 {
 	if (xen_hvm_domain()) {
-		uint64_t v;
+		uint64_t v =3D 0;
 		int err;
=20
 		err =3D hvm_get_parameter(HVM_PARAM_CONSOLE_EVTCHN, &v);
