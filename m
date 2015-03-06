Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B943C1A018B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Mar 2015 10:00:54 +1100 (AEDT)
Message-ID: <1425682582.4636.197.camel@kernel.crashing.org>
Subject: Re: [REGRESSION in 3.18][PPC] PA Semi fails to boot after: of/base:
 Fix PowerPC address parsing hack
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steven Rostedt <rostedt@goodmis.org>
Date: Sat, 07 Mar 2015 09:56:22 +1100
In-Reply-To: <20150306100021.5637d790@gandalf.local.home>
References: <20150305171239.3a8135e6@gandalf.local.home>
 <1425615522.4636.173.camel@kernel.crashing.org>
 <20150306100021.5637d790@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <robh@kernel.org>,
 Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-03-06 at 10:00 -0500, Steven Rostedt wrote:
> On Fri, 06 Mar 2015 15:18:42 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
>  
> > Can you shoot me the DT (/proc/device-tree in a tarball) ?
> 
> Attached.

This is indeed a bug in their DT. We might want to add quirks for
that unless it can be fixed (or has been via FW update). Olof ?

In the meantime, try that patch:

diff --git a/drivers/of/address.c b/drivers/of/address.c
index ad29069..78a7dcb 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -450,12 +450,17 @@ static struct of_bus *of_match_bus(struct device_node *np)
 	return NULL;
 }
 
-static int of_empty_ranges_quirk(void)
+static int of_empty_ranges_quirk(struct device_node *np)
 {
 	if (IS_ENABLED(CONFIG_PPC)) {
-		/* To save cycles, we cache the result */
+		/* To save cycles, we cache the result for global "Mac" setting */
 		static int quirk_state = -1;
 
+		/* PA-SEMI sdc DT bug */
+		if (of_device_is_compatible(np, "1682m-sdc"))
+			return true;
+
+		/* Make quirk cached */
 		if (quirk_state < 0)
 			quirk_state =
 				of_machine_is_compatible("Power Macintosh") ||
@@ -490,7 +495,7 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
 	 * This code is only enabled on powerpc. --gcl
 	 */
 	ranges = of_get_property(parent, rprop, &rlen);
-	if (ranges == NULL && !of_empty_ranges_quirk()) {
+	if (ranges == NULL && !of_empty_ranges_quirk(parent)) {
 		pr_debug("OF: no ranges; cannot translate\n");
 		return 1;
 	}
