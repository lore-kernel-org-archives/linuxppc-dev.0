Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id C6EE4DDE27
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 00:47:23 +1000 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1189800008.3343.21.camel@localhost.localdomain>
References: <1189800008.3343.21.camel@localhost.localdomain>
	<598D5675D34BE349929AF5EDE9B03E27015558EA@az33exm24.fsl.freescale.net>
To: James Bottomley <James.Bottomley@SteelEye.com>, akpm@osdl.org,
	jens.axboe@oracle.com
Subject: Re: CONFIG_BLK_DEV_BSG=n
Date: Mon, 17 Sep 2007 15:46:30 +0100
Message-ID: <19650.1190040390@redhat.com>
Sender: dhowells@redhat.com
Cc: fujita.tomonori@lab.ntt.co.jp, linux-scsi@vger.kernel.org,
	Gala Kumar-B11780 <kumar.gala@freescale.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


James Bottomley <James.Bottomley@SteelEye.com> wrote:

> > Which solution would you be more comfortable with?
> 
> The one which is currently in -mm is this one:
> 
> http://git.kernel.org/?p=linux/kernel/git/jejb/scsi-misc-2.6.git;a=commit;h=49892223f7d3a2333ef9e6cbdd526676e1fc517a

In my opinion, this is the wrong fix.  There shouldn't be anything in the
kernel using stuff from bsg.h if CONFIG_BLOCK=n, so there should be an error if
anything tries to.  The correct fix is to exclude the non-userspace-visible
contents of bsg.h with #ifdef CONFIG_BLOCK, not to declare things that we've
tried to make sure specifically aren't declared.

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
