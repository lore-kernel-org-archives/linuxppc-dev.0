Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD185C0044C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 00:44:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F4BA2082D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 00:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="DulVHpGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4BA2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kXm96Y0VzDsDx
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 11:44:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="DulVHpGA";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p00-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5300::5; helo=mo6-p00-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="DulVHpGA"; 
 dkim-atps=neutral
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kXjd3t96zDrYb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 11:42:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1540860125;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=RZ28OwjWb0LsjOFO4zy4nPiKwHMH+IT7iOoJEQffT8I=;
 b=DulVHpGAxTNVBqEFf9jKpsAWTB5Xi7TTLoLfov9iVFISKy4S0CGpQO6f7wHoepAOPt
 NR5tzW/BAaNoTKBUJtuZhpohgSH6eIKEUoFleSOpdkoZmUmqAdhRkyI2xb900piWWrny
 bG7Dmze2swyiiQfnSl8g20nn+N3jqc0M7G4gaDq5dI/xWevDqTbtAzRJDVF9qxldLdlf
 GlbyrwQHzh+AHZ2W9YCWzOaFeHzjw8s/ImpZtLQV0xQ1BN9074Xu0nn35yKWJiBJoAZo
 trRUK0g1/fNcQpxyxwendNek9HGePb2FR8LtC43l4JqZBOoWdn5JwcG5/dgOzrJMyacL
 Xo6w==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7Claj5g1PFUMuPaOFFHIlc73iVjE"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:e1e0:2a1f:8ec:6b80]
 by smtp.strato.de (RZmta 44.3 AUTH) with ESMTPSA id Z0624cu9U0ft9jU
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Tue, 30 Oct 2018 01:41:55 +0100 (CET)
Subject: Re: NXP P50XX/e5500: SMP doesn't work anymore with the latest Git
 kernel
To: Scott Wood <oss@buserror.net>, LEROY Christophe <christophe.leroy@c-s.fr>
References: <6bcb4b23-bb78-d1a5-7fd0-5f892115d302@xenosoft.de>
 <99266ac6-640c-b2a9-eef3-4e89ee1e0ad5@xenosoft.de>
 <f6ca1728-d312-1267-d9d7-18d2369f1bf7@xenosoft.de>
 <20181029191321.Horde.fxo4MJUhTstCq8zaw1lK7Q3@messagerie.si.c-s.fr>
 <77061E9A-AFC9-437A-AB42-F47266FD9721@xenosoft.de>
 <074997be051a5684b5b8593c3c3ce2a2e06147fa.camel@buserror.net>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <d13090a2-902e-e18c-c97f-79cddb277454@xenosoft.de>
Date: Tue, 30 Oct 2018 01:41:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <074997be051a5684b5b8593c3c3ce2a2e06147fa.camel@buserror.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 30 October 2018 at 00:04AM, Scott Wood wrote:
> On Mon, 2018-10-29 at 21:12 +0100, Christian Zigotzky wrote:
>> Hello Christophe,
>>
>> Bisecting isn’t necessary because the problem is in the following files.
>>
>> drivers/of/base.c
>> drivers/of/device.c
>> drivers/of/of_mdio.c
>> drivers/of/of_numa.c
>> drivers/of/of_private.h
>> drivers/of/overlay.c
>> drivers/of/platform.c
>> drivers/of/unittest-data/overlay_15.dts
>> drivers/of/unittest-data/tests-overlay.dtsi
>> drivers/of/unittest.c
>> include/linux/of.h
>>
>> I removed the OF modifications from the merge commit 'devicetree-for-4.20'
>> and SMP works again.
> Bisecting to get the specific non-merge commit that broke things would be much
> more useful than simply identifying the affected file (especially if it's a
> smallish change).
>
> -Scott
>
>
You're right but I had no luck with bisecting in the past. I think I 
have to learn it more.

I found the problematic code and I created a patch today. SMP works with 
this patch again.

Link: http://www.xenosoft.de/of.patch

of.patch 
-------------------------------------------------------------------------------

diff -rupN a/drivers/of/base.c b/drivers/of/base.c
--- a/drivers/of/base.c    2018-10-30 01:00:59.814808778 +0100
+++ b/drivers/of/base.c    2018-10-30 01:00:27.990741603 +0100
@@ -394,7 +394,7 @@ struct device_node *of_get_cpu_node(int
  {
      struct device_node *cpun;

-    for_each_of_cpu_node(cpun) {
+    for_each_node_by_type(cpun, "cpu") {
          if (arch_find_n_match_cpu_physical_id(cpun, cpu, thread))
              return cpun;
      }
@@ -749,45 +749,6 @@ struct device_node *of_get_next_availabl
  EXPORT_SYMBOL(of_get_next_available_child);

  /**
- *    of_get_next_cpu_node - Iterate on cpu nodes
- *    @prev:    previous child of the /cpus node, or NULL to get first
- *
- *    Returns a cpu node pointer with refcount incremented, use 
of_node_put()
- *    on it when done. Returns NULL when prev is the last child. Decrements
- *    the refcount of prev.
- */
-struct device_node *of_get_next_cpu_node(struct device_node *prev)
-{
-    struct device_node *next = NULL;
-    unsigned long flags;
-    struct device_node *node;
-
-    if (!prev)
-        node = of_find_node_by_path("/cpus");
-
-    raw_spin_lock_irqsave(&devtree_lock, flags);
-    if (prev)
-        next = prev->sibling;
-    else if (node) {
-        next = node->child;
-        of_node_put(node);
-    }
-    for (; next; next = next->sibling) {
-        if (!(of_node_name_eq(next, "cpu") ||
-              (next->type && !of_node_cmp(next->type, "cpu"))))
-            continue;
-        if (!__of_device_is_available(next))
-            continue;
-        if (of_node_get(next))
-            break;
-    }
-    of_node_put(prev);
-    raw_spin_unlock_irqrestore(&devtree_lock, flags);
-    return next;
-}
-EXPORT_SYMBOL(of_get_next_cpu_node);
-
-/**
   * of_get_compatible_child - Find compatible child node
   * @parent:    parent node
   * @compatible:    compatible string
diff -rupN a/include/linux/of.h b/include/linux/of.h
--- a/include/linux/of.h    2018-10-30 01:01:01.034811355 +0100
+++ b/include/linux/of.h    2018-10-30 00:56:18.054216284 +0100
@@ -347,7 +347,6 @@ extern const void *of_get_property(const
                  const char *name,
                  int *lenp);
  extern struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
-extern struct device_node *of_get_next_cpu_node(struct device_node *prev);

  #define for_each_property_of_node(dn, pp) \
      for (pp = dn->properties; pp != NULL; pp = pp->next)
@@ -754,11 +753,6 @@ static inline struct device_node *of_get
      return NULL;
  }

-static inline struct device_node *of_get_next_cpu_node(struct 
device_node *prev)
-{
-    return NULL;
-}
-
  static inline int of_n_addr_cells(struct device_node *np)
  {
      return 0;
@@ -1229,10 +1223,6 @@ static inline int of_property_read_s32(c
      for (child = of_get_next_available_child(parent, NULL); child != 
NULL; \
           child = of_get_next_available_child(parent, child))

-#define for_each_of_cpu_node(cpu) \
-    for (cpu = of_get_next_cpu_node(NULL); cpu != NULL; \
-         cpu = of_get_next_cpu_node(cpu))
-
  #define for_each_node_with_property(dn, prop_name) \
      for (dn = of_find_node_with_property(NULL, prop_name); dn; \
           dn = of_find_node_with_property(dn, prop_name))

-------------------------------------------------------------------------------------------------------


