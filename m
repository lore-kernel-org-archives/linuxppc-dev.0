Return-Path: <julia@diku.dk>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw2.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 63D87DE0DD
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Jun 2008 22:20:24 +1000 (EST)
Date: Mon, 9 Jun 2008 14:20:04 +0200 (CEST)
From: Julia Lawall <julia@diku.dk>
To: paulus@samba.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/4] arch/powerpc: add missing of_node_put
Message-ID: <Pine.LNX.4.64.0806091418340.16009@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Julia Lawall <julia@diku.dk>

of_node_put is needed before discarding a value received from
of_find_node_by_type, eg in error handling code.

The semantic patch that makes the change is as follows:
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@@
struct device_node *n;
struct device_node *n1;
struct device_node *n2;
statement S;
identifier f1,f2;
expression E1,E2;
constant C;
@@

n = of_find_node_by_type(...)
...
if (!n) S
... when != of_node_put(n)
    when != n1 = f1(n,...)
    when != E1 = n
    when any
    when strict
(
+ of_node_put(n);
  return -C;
|
  of_node_put(n);
|
  n2 = f2(n,...)
|
  E2 = n
|
  return ...;
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---

diff -u -p a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -131,8 +131,10 @@ int __init pSeries_nvram_init(void)
 		return -ENODEV;
 
 	nbytes_p = of_get_property(nvram, "#bytes", &proplen);
-	if (nbytes_p == NULL || proplen != sizeof(unsigned int))
+	if (nbytes_p == NULL || proplen != sizeof(unsigned int)) {
+		of_node_put(nvram);
 		return -EIO;
+	}
 
 	nvram_size = *nbytes_p;
 
