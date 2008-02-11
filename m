Return-Path: <kyle@phobos.cabal.ca>
Received: from phobos.cabal.ca (206-248-169-182.dsl.ncf.ca [206.248.169.182])
	by ozlabs.org (Postfix) with ESMTP id 5201ADDEFF
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 09:57:03 +1100 (EST)
Resent-Message-ID: <20080211225126.GK4516@phobos.i.cabal.ca>
Date: Mon, 11 Feb 2008 17:45:05 -0500
From: Kyle McMartin <kyle@mcmartin.ca>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] fix swim3.c modular build
Message-ID: <20080211224505.GI4516@phobos.i.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

While updating Fedora to 2.6.25-rc1, I noticed this little gem...

This swim3 and mediabay dependancy is pretty grody. Commit
34394e45c3387bd66619d9a51b4be507e4222b02 moved the ifdef around, which
meant the EXPORT_SYMBOL wasn't happening, which was bad, since if swim3
is built modularly, and CONFIG_PMAC_MEDIABAY is defined the internal
replacement isn't used.

Anyway, a powerpc person should probably look at making this less than
completely broken, but at least it will now build.

I'm not entirely sure why this is conditional at all, really.

diff --git a/drivers/macintosh/mediabay.c b/drivers/macintosh/mediabay.c
index 9367882..635a140 100644
--- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -416,9 +416,9 @@ static void poll_media_bay(struct media_bay_info* bay)
 	}
 }
 
-#ifdef CONFIG_MAC_FLOPPY
 int check_media_bay(struct device_node *which_bay, int what)
 {
+#ifdef CONFIG_MAC_FLOPPY
 	int	i;
 
 	for (i=0; i<media_bay_count; i++)
@@ -428,10 +428,10 @@ int check_media_bay(struct device_node *which_bay, int what)
 			media_bays[i].cd_index = -1;
 			return -EINVAL;
 		}
+#endif /* CONFIG_MAC_FLOPPY */
 	return -ENODEV;
 }
 EXPORT_SYMBOL(check_media_bay);
-#endif /* CONFIG_MAC_FLOPPY */
 
 #ifdef CONFIG_BLK_DEV_IDE_PMAC
 int check_media_bay_by_base(unsigned long base, int what)
