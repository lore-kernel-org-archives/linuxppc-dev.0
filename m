Return-Path: <lintonrjeremy@gmail.com>
Received: from mail-qg0-x234.google.com (mail-qg0-x234.google.com
 [IPv6:2607:f8b0:400d:c04::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C46C1A0061
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2015 09:50:59 +1000 (AEST)
Received: by qgem68 with SMTP id m68so22668774qge.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2015 16:50:55 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 29 Jun 2015 18:50:55 -0500
Message-ID: <CAEFTgixGKnMuMGp2DfoksqF0m_P6-EGJ0sUjg2=ReX2X0tq2nA@mail.gmail.com>
Subject: [PATCH] Fix pSeries boot failure, by returning interrupt controller
 node when an interrupt-map property doesn't exist
From: Jeremy Linton <lintonrjeremy@gmail.com>
To: benh@kernel.crashing.org
Cc: robherring2@gmail.com, grant.likely@linaro.org, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, paulus@samba.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a reformat of the patch attached to "pSeries boot failure due
to wrong interrupt controller".

It allows of_irq_parse_raw() to return the node pointer of the
interrupt controller, rather than the parent bus. This allows
ics_rtas_host_match() to detect that the controller is a legacy 8259
and avoid using xics. This avoids an RTAS assertion/crash during early
kernel bootstrapping.




Signed-off-by: Jeremy Linton <lintonrjeremy@gmail.com>
---
 drivers/of/irq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 1a79806..cb4b9ae 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -252,8 +252,6 @@ int of_irq_parse_raw(const __be32 *addr, struct
of_phandle_args *out_irq)
                 * Successfully parsed an interrrupt-map translation; copy new
                 * interrupt specifier into the out_irq structure
                 */
-               out_irq->np = newpar;
-
                match_array = imap - newaddrsize - newintsize;
                for (i = 0; i < newintsize; i++)
                        out_irq->args[i] = be32_to_cpup(imap - newintsize + i);
@@ -262,6 +260,7 @@ int of_irq_parse_raw(const __be32 *addr, struct
of_phandle_args *out_irq)

        skiplevel:
                /* Iterate again with new parent */
+               out_irq->np = newpar;
                pr_debug(" -> new parent: %s\n", of_node_full_name(newpar));
                of_node_put(ipar);
                ipar = newpar;
--
1.8.1.4
