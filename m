Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0598D1A01F4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 11:45:49 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 529CC1400B6
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2014 11:45:48 +1100 (AEDT)
Message-ID: <1415839522.5124.58.camel@kernel.crashing.org>
Subject: Re: [PATCH]  of/base: Fix PowerPC address parsing hack
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 13 Nov 2014 11:45:22 +1100
In-Reply-To: <1415833725.5124.53.camel@kernel.crashing.org>
References: <1415771461.5124.33.camel@kernel.crashing.org>
 <20141113091036.4e9ec43d@canb.auug.org.au>
 <1415833725.5124.53.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Olof Johansson <olof@lixom.net>, Rob Herring <robherring2@gmail.com>,
 Grant Likely <grant.likely@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

What about this one instead ? I want to cache it because that function
can be called quite a while and doing two additional property lookup
and string compares every time might hurt some platforms.

----

We have a historical hack that treats missing ranges properties as the
equivalent of an empty one. This is needed for ancient PowerMac "bad"
device-trees, and shouldn't be enabled for any other PowerPC platform,
otherwise we get some nasty layout of devices in sysfs or even
duplication when a set of otherwise identically named devices is
created multiple times under a different parent node with no ranges
property.

This fix is needed for the PowerNV i2c busses to be exposed properly
and will fix a number of other embedded cases.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: <stable@vger.kernel.org>

diff --git a/drivers/of/address.c b/drivers/of/address.c
index e371825..5eae0cd 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -403,6 +403,17 @@ static struct of_bus *of_match_bus(struct device_node *np)
 	return NULL;
 }
 
+static int of_empty_ranges_quirk(void)
+{
+	/* To save cycles, we cache the result */
+	static int quirk_state = -1;
+
+	if (quirk_state < 0)
+		quirk_state = of_machine_is_compatible("Power Macintosh") ||
+			of_machine_is_compatible("MacRISC");
+	return quirk_state;
+}
+
 static int of_translate_one(struct device_node *parent, struct of_bus *bus,
 			    struct of_bus *pbus, __be32 *addr,
 			    int na, int ns, int pna, const char *rprop)
@@ -428,12 +439,10 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
 	 * This code is only enabled on powerpc. --gcl
 	 */
 	ranges = of_get_property(parent, rprop, &rlen);
-#if !defined(CONFIG_PPC)
-	if (ranges == NULL) {
+	if (ranges == NULL && !of_empty_ranges_quirk()) {
 		pr_err("OF: no ranges; cannot translate\n");
 		return 1;
 	}
-#endif /* !defined(CONFIG_PPC) */
 	if (ranges == NULL || rlen == 0) {
 		offset = of_read_number(addr, na);
 		memset(addr, 0, pna * 4);
