Return-Path: <srs0=dnnd=dp=concordia.ellerman.id.au=michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1HHp2VC3zDx5w
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 23:28:22 +1100 (AEDT)
From: Michael Ellerman <michael@concordia.ellerman.id.au>
To: "Johannes Berg" <johannes@sipsolutions.net>
Cc: "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
 "Jouni Malinen" <j@w1.fi>, "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 "Johannes Berg" <johannes.berg@intel.com>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [net] Revert "net: core: maybe return -EEXIST in __dev_alloc_name"
References: <20171202074155.29146-1-johannes@sipsolutions.net>
Date: Tue, 19 Dec 2017 23:28:21 +1100
In-Reply-To: <20171202074155.29146-1-johannes@sipsolutions.net> (Johannes
 Berg's message of "Sat, 2 Dec 2017 08:41:55 +0100")
Message-ID: <87vah29a1m.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Johannes,

> From: Johannes Berg <johannes.berg@intel.com>
> 
> This reverts commit d6f295e9def0; some userspace (in the case
> we noticed it's wpa_supplicant), is relying on the current
> error code to determine that a fixed name interface already
> exists.
> 
> Reported-by: Jouni Malinen <j@w1.fi>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  net/core/dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This revert seems to have broken networking on one of my powerpc
machines, according to git bisect.

The symptom is DHCP fails and I don't get a link, I didn't dig any
further than that. I can if it's helpful.

I think the problem is that 87c320e51519 ("net: core: dev_get_valid_name
is now the same as dev_alloc_name_ns") only makes sense while
d6f295e9def0 remains in the tree.

ie. before the entire series, dev_get_valid_name() would return EEXIST,
and that was retained when 87c320e51519 was merged, but now that
d6f295e9def0 has been reverted dev_get_valid_name() is returning ENFILE.

I can get the network up again if I also revert 87c320e51519 ("net:
core: dev_get_valid_name is now the same as dev_alloc_name_ns"), or with
the gross patch below.

cheers

diff --git a/net/core/dev.c b/net/core/dev.c
index f47e96b62308..d0304461ad32 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1146,7 +1146,11 @@ EXPORT_SYMBOL(dev_alloc_name);
 int dev_get_valid_name(struct net *net, struct net_device *dev,
 		       const char *name)
 {
-	return dev_alloc_name_ns(net, dev, name);
+	int rc = dev_alloc_name_ns(net, dev, name);
+	if (rc == -ENFILE)
+		rc = -EEXIST;
+
+	return rc;
 }
 EXPORT_SYMBOL(dev_get_valid_name);
 
