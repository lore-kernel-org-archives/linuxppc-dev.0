Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 27BE8DDEC7
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 13:40:54 +1000 (EST)
Date: Sun, 13 May 2007 13:40:53 +1000
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Fix Kconfig undefined symbol 'IBM_NEW_EMAC_ZMII'
Message-ID: <20070513034053.GG15955@bakeyournoodle.com>
References: <20070511070006.GF15955@bakeyournoodle.com>
	<1178870202.32247.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1178870202.32247.15.camel@localhost.localdomain>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 11, 2007 at 05:56:42PM +1000, Benjamin Herrenschmidt wrote:
 
> Can you comment it out instead ?

Sure.

Fix Kconfig undefined symbol 'IBM_NEW_EMAC_ZMII'

An allmodconfig on the current powerpc tree yields:
arch/powerpc/platforms/44x/Kconfig:41:warning: 'select' used by config symbol '440GP' refers to undefined symbol 'IBM_NEW_EMAC_ZMII'

Hide the select until the driver exists.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
CC: David Gibson <david@gibson.dropbear.id.au>
---

 arch/powerpc/platforms/44x/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: working/arch/powerpc/platforms/44x/Kconfig
===================================================================
--- working.orig/arch/powerpc/platforms/44x/Kconfig
+++ working/arch/powerpc/platforms/44x/Kconfig
@@ -38,7 +38,8 @@ config 440EP
 
 config 440GP
 	bool
-	select IBM_NEW_EMAC_ZMII
+# Disabled until the new EMAC Driver is merged.
+#	select IBM_NEW_EMAC_ZMII
 
 config 440GX
 	bool

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
