Date: Sat, 19 Jan 2002 14:17:37 +0100
From: Harald Welte <laforge@gnumonks.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] source.mvista.com::linuxppc_2_4 rtnetlink fixes
Message-ID: <20020119141737.T2801@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tT3UgwmDxwvOMqfu"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--tT3UgwmDxwvOMqfu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

Something went wrong while committing 2.4.18-pre4 changes to the
abovementioned tree.  I'm unable to even compile it !


There are still references to CONFIG_RTNETLINK in net/core/neighbour.c and
net/core/rtnetlink.c.

The files net/core/skbuff.c and net/core/sock.c have still old versions,
the patch below updates them to the official 2.4.18-pre4  versions.

--
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/

--tT3UgwmDxwvOMqfu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linuxppc-190102-net_core.patch"

diff -Nru linuxppc-190102-plain/net/core/neighbour.c linuxppc-190102-nfpom/net/core/neighbour.c
--- linuxppc-190102-plain/net/core/neighbour.c	Sun Jul  1 01:17:03 2001
+++ linuxppc-190102-nfpom/net/core/neighbour.c	Sat Jan 19 14:00:47 2002
@@ -1172,8 +1172,6 @@
 	return 0;
 }

-#ifdef CONFIG_RTNETLINK
-

 int neigh_delete(struct sk_buff *skb, struct nlmsghdr *nlh, void *arg)
 {
@@ -1442,8 +1440,6 @@

 #endif

-
-#endif

 #ifdef CONFIG_SYSCTL

diff -Nru linuxppc-190102-plain/net/core/rtnetlink.c linuxppc-190102-nfpom/net/core/rtnetlink.c
--- linuxppc-190102-plain/net/core/rtnetlink.c	Sun Jul  1 01:12:58 2001
+++ linuxppc-190102-nfpom/net/core/rtnetlink.c	Sat Jan 19 13:59:56 2002
@@ -77,7 +77,6 @@
 	return 0;
 }

-#ifdef CONFIG_RTNETLINK
 struct sock *rtnl;

 struct rtnetlink_link * rtnetlink_links[NPROTO];
@@ -536,4 +535,3 @@



-#endif
diff -Nru linuxppc-190102-plain/net/core/skbuff.c linuxppc-190102-nfpom/net/core/skbuff.c
--- linuxppc-190102-plain/net/core/skbuff.c	Sun Jul  1 01:16:34 2001
+++ linuxppc-190102-nfpom/net/core/skbuff.c	Sat Jan 19 14:07:22 2002
@@ -4,7 +4,7 @@
  *	Authors:	Alan Cox <iiitac@pyr.swan.ac.uk>
  *			Florian La Roche <rzsfl@rz.uni-sb.de>
  *
- *	Version:	$Id: skbuff.c,v 1.87 2001/03/06 22:09:50 davem Exp $
+ *	Version:	$Id: skbuff.c,v 1.90 2001/11/07 05:56:19 davem Exp $
  *
  *	Fixes:
  *		Alan Cox	:	Fixed the worst of the load balancer bugs.
@@ -49,15 +49,14 @@
 #include <linux/string.h>
 #include <linux/skbuff.h>
 #include <linux/cache.h>
+#include <linux/rtnetlink.h>
 #include <linux/init.h>
 #include <linux/highmem.h>

-#include <net/ip.h>
 #include <net/protocol.h>
 #include <net/dst.h>
-#include <net/tcp.h>
-#include <net/udp.h>
 #include <net/sock.h>
+#include <net/checksum.h>

 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -180,7 +179,7 @@
 	/* Get the HEAD */
 	skb = skb_head_from_pool();
 	if (skb == NULL) {
-		skb = kmem_cache_alloc(skbuff_head_cache, gfp_mask);
+		skb = kmem_cache_alloc(skbuff_head_cache, gfp_mask & ~__GFP_DMA);
 		if (skb == NULL)
 			goto nohead;
 	}
@@ -1149,6 +1148,32 @@
 	return csum;
 }

+void skb_copy_and_csum_dev(const struct sk_buff *skb, u8 *to)
+{
+	unsigned int csum;
+	long csstart;
+
+	if (skb->ip_summed == CHECKSUM_HW)
+		csstart = skb->h.raw - skb->data;
+	else
+		csstart = skb->len - skb->data_len;
+
+	if (csstart > skb->len - skb->data_len)
+		BUG();
+
+	memcpy(to, skb->data, csstart);
+
+	csum = 0;
+	if (csstart != skb->len)
+		csum = skb_copy_and_csum_bits(skb, csstart, to+csstart,
+				skb->len-csstart, 0);
+
+	if (skb->ip_summed == CHECKSUM_HW) {
+		long csstuff = csstart + skb->csum;
+
+		*((unsigned short *)(to + csstuff)) = csum_fold(csum);
+	}
+}

 #if 0
 /*
Binary files linuxppc-190102-plain/net/core/skbuff.o and linuxppc-190102-nfpom/net/core/skbuff.o differ
diff -Nru linuxppc-190102-plain/net/core/sock.c linuxppc-190102-nfpom/net/core/sock.c
--- linuxppc-190102-plain/net/core/sock.c	Sun Jul  1 01:18:51 2001
+++ linuxppc-190102-nfpom/net/core/sock.c	Sat Jan 19 14:08:12 2002
@@ -7,7 +7,7 @@
  *		handler for protocols to use and generic option handler.
  *
  *
- * Version:	$Id: sock.c,v 1.111 2001/06/26 23:29:17 davem Exp $
+ * Version:	$Id: sock.c,v 1.116 2001/11/08 04:20:06 davem Exp $
  *
  * Authors:	Ross Biro, <bir7@leland.Stanford.Edu>
  *		Fred N. van Kempen, <waltje@uWalt.NL.Mugnet.ORG>
@@ -113,25 +113,19 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>

-#include <linux/inet.h>
 #include <linux/netdevice.h>
-#include <net/ip.h>
 #include <net/protocol.h>
-#include <net/arp.h>
-#include <net/route.h>
-#include <net/tcp.h>
-#include <net/udp.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
-#include <net/raw.h>
-#include <net/icmp.h>
 #include <linux/ipsec.h>

 #ifdef CONFIG_FILTER
 #include <linux/filter.h>
 #endif

-#define min(a,b)	((a)<(b)?(a):(b))
+#ifdef CONFIG_INET
+#include <net/tcp.h>
+#endif

 /* Run time adjustable parameters. */
 __u32 sysctl_wmem_max = SK_WMEM_MAX;
@@ -232,7 +226,10 @@
 				val = sysctl_wmem_max;

 			sk->userlocks |= SOCK_SNDBUF_LOCK;
-			sk->sndbuf = max(val*2,SOCK_MIN_SNDBUF);
+			if ((val * 2) < SOCK_MIN_SNDBUF)
+				sk->sndbuf = SOCK_MIN_SNDBUF;
+			else
+				sk->sndbuf = (val * 2);

 			/*
 			 *	Wake up sending tasks if we
@@ -252,7 +249,10 @@

 			sk->userlocks |= SOCK_RCVBUF_LOCK;
 			/* FIXME: is this lower bound the right one? */
-			sk->rcvbuf = max(val*2,SOCK_MIN_RCVBUF);
+			if ((val * 2) < SOCK_MIN_RCVBUF)
+				sk->rcvbuf = SOCK_MIN_RCVBUF;
+			else
+				sk->rcvbuf = (val * 2);
 			break;

 		case SO_KEEPALIVE:
@@ -533,9 +533,9 @@
 			break;

 		case SO_PEERCRED:
-			lv=sizeof(sk->peercred);
-			len=min(len, lv);
-			if(copy_to_user((void*)optval, &sk->peercred, len))
+			if (len > sizeof(sk->peercred))
+				len = sizeof(sk->peercred);
+			if (copy_to_user(optval, &sk->peercred, len))
 				return -EFAULT;
 			goto lenout;

@@ -562,11 +562,12 @@
 		default:
 			return(-ENOPROTOOPT);
 	}
-	len=min(len,lv);
-	if(copy_to_user(optval,&v,len))
+	if (len > lv)
+		len = lv;
+	if (copy_to_user(optval, &v, len))
 		return -EFAULT;
 lenout:
-  	if(put_user(len, optlen))
+  	if (put_user(len, optlen))
   		return -EFAULT;
   	return 0;
 }
@@ -754,48 +755,62 @@
  *	Generic send/receive buffer handlers
  */

-struct sk_buff *sock_alloc_send_skb(struct sock *sk, unsigned long size,
-			int noblock, int *errcode)
+struct sk_buff *sock_alloc_send_pskb(struct sock *sk, unsigned long header_len,
+				     unsigned long data_len, int noblock, int *errcode)
 {
-	int err;
 	struct sk_buff *skb;
 	long timeo;
+	int err;

 	timeo = sock_sndtimeo(sk, noblock);
-
 	while (1) {
-		unsigned long try_size = size;
-
 		err = sock_error(sk);
 		if (err != 0)
 			goto failure;

-		/*
-		 *	We should send SIGPIPE in these cases according to
-		 *	1003.1g draft 6.4. If we (the user) did a shutdown()
-		 *	call however we should not.
-		 *
-		 *	Note: This routine isnt just used for datagrams and
-		 *	anyway some datagram protocols have a notion of
-		 *	close down.
-		 */
-
 		err = -EPIPE;
-		if (sk->shutdown&SEND_SHUTDOWN)
+		if (sk->shutdown & SEND_SHUTDOWN)
 			goto failure;

 		if (atomic_read(&sk->wmem_alloc) < sk->sndbuf) {
-			skb = alloc_skb(try_size, sk->allocation);
-			if (skb)
+			skb = alloc_skb(header_len, sk->allocation);
+			if (skb) {
+				int npages;
+				int i;
+
+				/* No pages, we're done... */
+				if (!data_len)
+					break;
+
+				npages = (data_len + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
+				skb->truesize += data_len;
+				skb_shinfo(skb)->nr_frags = npages;
+				for (i = 0; i < npages; i++) {
+					struct page *page;
+					skb_frag_t *frag;
+
+					page = alloc_pages(sk->allocation, 0);
+					if (!page) {
+						err = -ENOBUFS;
+						kfree_skb(skb);
+						goto failure;
+					}
+
+					frag = &skb_shinfo(skb)->frags[i];
+					frag->page = page;
+					frag->page_offset = 0;
+					frag->size = (data_len >= PAGE_SIZE ?
+						      PAGE_SIZE :
+						      data_len);
+					data_len -= PAGE_SIZE;
+				}
+
+				/* Full success... */
 				break;
+			}
 			err = -ENOBUFS;
 			goto failure;
 		}
-
-		/*
-		 *	This means we have too many buffers for this socket already.
-		 */
-
 		set_bit(SOCK_ASYNC_NOSPACE, &sk->socket->flags);
 		set_bit(SOCK_NOSPACE, &sk->socket->flags);
 		err = -EAGAIN;
@@ -814,6 +829,12 @@
 failure:
 	*errcode = err;
 	return NULL;
+}
+
+struct sk_buff *sock_alloc_send_skb(struct sock *sk, unsigned long size,
+				    int noblock, int *errcode)
+{
+	return sock_alloc_send_pskb(sk, size, 0, noblock, errcode);
 }

 void __lock_sock(struct sock *sk)

--tT3UgwmDxwvOMqfu--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
