Return-Path: <ilpo.jarvinen@helsinki.fi>
Received: from mail.cs.helsinki.fi (courier.cs.helsinki.fi [128.214.9.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 10D91DE128
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 08:07:49 +1000 (EST)
Date: Sat, 18 Apr 2009 01:07:43 +0300 (EEST)
From: "=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>
To: benh@kernel.crashing.org
Subject: Re: Proposed prom parse fix + moving.
In-Reply-To: <Pine.LNX.4.64.0904171601020.10088@wrl-59.cs.helsinki.fi>
Message-ID: <Pine.LNX.4.64.0904180057290.2522@wrl-59.cs.helsinki.fi>
References: <49E81CED.1000704@monstr.eu>
	<fa686aa40904162344y67115e50lf48c174501120b30@mail.gmail.com>
	<49E87D25.8090001@monstr.eu>
	<Pine.LNX.4.64.0904171601020.10088@wrl-59.cs.helsinki.fi>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; boundary="-696208474-14043735-1239973323=:10088"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Michal Simek <monstr@monstr.eu>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---696208474-14043735-1239973323=:10088
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0904180057292.2522@wrl-59.cs.helsinki.fi>

On Fri, 17 Apr 2009, Ilpo Järvinen wrote:

> On Fri, 17 Apr 2009, Michal Simek wrote:
> 
> > Grant Likely wrote:
> > > On Fri, Apr 17, 2009 at 12:08 AM, Michal Simek <monstr@monstr.eu> wrote:
> > >> Hi All,
> > >>
> > >> I have got email from Ilpo about prom_parse file.
> > >> I take this file from powerpc. Who did write prom_parse file and take care about?
> > > 
> > > Posting to the linuxppc-dev list is sufficient to start.  There are
> > > several people who may be interested.
> > > 
> > >> BTW: What about to move prom_parse file to any generic location as we discussed in past?
> > >> Any volunteer?
> > > 
> > > I'm kind of working on it.  More specifically, I'm looking at
> > > factoring out fdt stuff into common code (drivers/of/of_fdt.c). But I
> > > haven't made a whole lot of progress yet.
> > > 
> > >> -------- Original Message --------
> > >> Subject: [RFC!] [PATCH] microblaze: fix bug in error handling
> > >> Date: Thu, 16 Apr 2009 23:05:53 +0300 (EEST)
> > >> From: Ilpo Järvinen <ilpo.jarvinen@helsinki.fi>
> > >> To: monstr@monstr.eu
> > >> CC: microblaze-uclinux@itee.uq.edu.au
> > >>
> > >> While some version of the patches were on the lkml I read
> > >> some part of the code briefly through but my feedback got
> > >> stuck into postponed emails, so here's one correctness
> > >> related issue I might have found (the rest were just
> > >> cosmetic things).
> > >>
> > >> I'm not sure if the latter return needs the of_node_put or not
> > >> but it seems more likely than not.
> > > 
> > > Yes, it does.  This change is applicable to
> > > arch/powerpc/kernel/prom_parse.c too.
> > 
> > ok.
> > Ilpo: Can you create patch for both architectures?
> 
> Sure, but tomorrow as today is a deadline day :-).

Ok, here's combined patch for both. I came up with slightly
shorter and (IMHO) nicer variant for -EINVAL assignment than
in the first version.

--
[PATCH] powerpc & microblaze: add missing of_node_put to error handling

While reviewing some microblaze patches a while ago, I noticed
a suspicious error handling in of_irq_map_one(), which turned
out to be a copy from arch/powerpc. Grant Likely
<grant.likely@secretlab.ca> confirmed that this is a real bug.

Merge error handling paths using goto with the normal return
path.

Powerppc compile tested.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@helsinki.fi>
---
 arch/microblaze/kernel/prom_parse.c |   11 +++++------
 arch/powerpc/kernel/prom_parse.c    |   11 +++++------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/microblaze/kernel/prom_parse.c b/arch/microblaze/kernel/prom_parse.c
index ae0352e..d16c32f 100644
--- a/arch/microblaze/kernel/prom_parse.c
+++ b/arch/microblaze/kernel/prom_parse.c
@@ -903,7 +903,7 @@ int of_irq_map_one(struct device_node *device,
 	struct device_node *p;
 	const u32 *intspec, *tmp, *addr;
 	u32 intsize, intlen;
-	int res;
+	int res = -EINVAL;
 
 	pr_debug("of_irq_map_one: dev=%s, index=%d\n",
 			device->full_name, index);
@@ -926,21 +926,20 @@ int of_irq_map_one(struct device_node *device,
 
 	/* Get size of interrupt specifier */
 	tmp = of_get_property(p, "#interrupt-cells", NULL);
-	if (tmp == NULL) {
-		of_node_put(p);
-		return -EINVAL;
-	}
+	if (tmp == NULL)
+		goto out;
 	intsize = *tmp;
 
 	pr_debug(" intsize=%d intlen=%d\n", intsize, intlen);
 
 	/* Check index */
 	if ((index + 1) * intsize > intlen)
-		return -EINVAL;
+		goto out;
 
 	/* Get new specifier and map it */
 	res = of_irq_map_raw(p, intspec + index * intsize, intsize,
 				addr, out_irq);
+out:
 	of_node_put(p);
 	return res;
 }
diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index 8f0856f..8362620 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -971,7 +971,7 @@ int of_irq_map_one(struct device_node *device, int index, struct of_irq *out_irq
 	struct device_node *p;
 	const u32 *intspec, *tmp, *addr;
 	u32 intsize, intlen;
-	int res;
+	int res = -EINVAL;
 
 	DBG("of_irq_map_one: dev=%s, index=%d\n", device->full_name, index);
 
@@ -995,21 +995,20 @@ int of_irq_map_one(struct device_node *device, int index, struct of_irq *out_irq
 
 	/* Get size of interrupt specifier */
 	tmp = of_get_property(p, "#interrupt-cells", NULL);
-	if (tmp == NULL) {
-		of_node_put(p);
-		return -EINVAL;
-	}
+	if (tmp == NULL)
+		goto out;
 	intsize = *tmp;
 
 	DBG(" intsize=%d intlen=%d\n", intsize, intlen);
 
 	/* Check index */
 	if ((index + 1) * intsize > intlen)
-		return -EINVAL;
+		goto out;
 
 	/* Get new specifier and map it */
 	res = of_irq_map_raw(p, intspec + index * intsize, intsize,
 			     addr, out_irq);
+out:
 	of_node_put(p);
 	return res;
 }
-- 
1.5.6.5

---696208474-14043735-1239973323=:10088--
