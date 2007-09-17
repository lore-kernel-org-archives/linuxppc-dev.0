Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 375A1DDE9D
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 08:34:52 +1000 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <11900663131073-git-send-email-Emilian.Medve@Freescale.com>
References: <11900663131073-git-send-email-Emilian.Medve@Freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Subject: Re: [PATCH] [POWERPC] Fix build errors when BLOCK=n
Date: Mon, 17 Sep 2007 23:34:42 +0100
Message-ID: <16939.1190068482@redhat.com>
Sender: dhowells@redhat.com
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, kumar.gala@Freescale.com,
	linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Try the attached.

David
---
[PATCH] VFS: Make BSG declarations dependent on CONFIG_BLOCK

From: David Howells <dhowells@redhat.com>

Make BSG function declarations dependent on CONFIG_BLOCK as they are not
compilable if the block layer is compiled out.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/bsg.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/bsg.h b/include/linux/bsg.h
index 60e377b..28f5d44 100644
--- a/include/linux/bsg.h
+++ b/include/linux/bsg.h
@@ -52,6 +52,7 @@ struct sg_io_v4 {
 };
 
 #ifdef __KERNEL__
+#ifdef CONFIG_BLOCK
 
 #if defined(CONFIG_BLK_DEV_BSG)
 struct bsg_class_device {
@@ -73,6 +74,7 @@ static inline void bsg_unregister_queue(struct request_queue *rq)
 }
 #endif
 
+#endif /* CONFIG_BLOCK */
 #endif /* __KERNEL__ */
 
 #endif
