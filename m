Return-Path: <rutger@wingding.demon.nl>
Received: from post-26.mail.nl.demon.net (post-26.mail.nl.demon.net
	[194.159.73.196]) by ozlabs.org (Postfix) with ESMTP id C4A51DDECC
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jul 2007 07:28:51 +1000 (EST)
Received: from wingding.demon.nl ([82.161.27.36]:35724)
	by post-26.mail.nl.demon.net with esmtp (Exim 4.51)
	id 1ICMVN-000DnI-4V
	for linuxppc-dev@ozlabs.org; Sat, 21 Jul 2007 21:28:49 +0000
Received: from rutger by wingding.demon.nl with local (Exim 4.63)
	(envelope-from <rutger@wingding.demon.nl>) id 1ICMVJ-00036B-3H
	for linuxppc-dev@ozlabs.org; Sat, 21 Jul 2007 23:28:45 +0200
Date: Sat, 21 Jul 2007 23:28:45 +0200
From: Rutger Nijlunsing <rutger@nospam.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Re: 2.6.22-git hangs during boot on PowerBook G3 in 0.0
	seconds
Message-ID: <20070721212845.GA30977@nospam.com>
References: <20070721192143.GA12144@nospam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070721192143.GA12144@nospam.com>
Reply-To: linuxppc-dev@tux.tmfweb.nl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jul 21, 2007 at 09:21:43PM +0200, Rutger Nijlunsing wrote:
> Hi,
> 
> I'm trying to boot a new git kernel (2.6.22-g589f1e81), but it hangs
> very early (the timestamp is still on 0.000000).

After hours bisecting, I found the one-liner which results in the
hang. Now it takes someone else to find out _why_ it causes a hang :)


>From 6c13e1b55c1f87ed19f3c4623de3df881779edd7 Mon Sep 17 00:00:00 2001
From: Rutger Nijlunsing <git-commit@tux.tmfweb.nl>
Date: Sat, 21 Jul 2007 23:01:22 +0200
Subject: [PATCH] Revert "[POWERPC] Don't complain if size-cells == 0 in prom_parse()"
Status: RO
Content-Length: 866
Lines: 24

After hours of fun git bisecting, finally found the commit to revert
to make my PowerBook G3 Lombard boot again. This does not result in
the complains the reverted commit was revering to.

This reverts commit fd6e9d3945ee122eb513ada8b17296d243c1ce5e.
---
 arch/powerpc/kernel/prom_parse.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index 3786dcc..b5c96af 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -24,7 +24,7 @@
 /* Max address size we deal with */
 #define OF_MAX_ADDR_CELLS	4
 #define OF_CHECK_COUNTS(na, ns)	((na) > 0 && (na) <= OF_MAX_ADDR_CELLS && \
-			(ns) >= 0)
+			(ns) > 0)
 
 static struct of_bus *of_match_bus(struct device_node *np);
 static int __of_address_to_resource(struct device_node *dev,
-- 
1.5.2.2



-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
