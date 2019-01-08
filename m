Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153DEC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 20:28:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EE7920827
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 20:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE7920827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Z3k23tqMzDqb9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 07:28:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=212.227.126.134; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Z3Kb45CyzDqZl
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 07:10:41 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MDv1A-1gX6KU3TJk-009yhV; Tue, 08 Jan 2019 21:10:10 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH] socket: move compat timeout handling into sock.c
Date: Tue,  8 Jan 2019 21:09:36 +0100
Message-Id: <20190108200959.1686520-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <CAK8P3a2T=dWgD1mvi77fbdKEsm=ZUwsQENv-btjhECjf+Y5wcg@mail.gmail.com>
References: <CAK8P3a2T=dWgD1mvi77fbdKEsm=ZUwsQENv-btjhECjf+Y5wcg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uPC0a5Rt4wtHOcL29nyURWhdIfWA6ffq44oOAaPdDhc4Ye86EoB
 HYLVNMSb5rBC59ylQPOL1GHFQ4eKRfhge93q3C7gaeWyx7tA/DJ21qV0RfrnqlT88qs6Vx5
 Wy0abp6eU/9++bVRqIbgf4Zt/iKwEh4XQKNysX3HdrXMw5Lig4O82oYaLrkfBILB0tISaik
 BESvecJlj0op65bTRceUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z1hmhFbP734=:bum3G09Y9kTwLx51FEvxdl
 G5DOKBqFXJUIHrfg21S5Im7xqv3ABMXGKWM9YA7xEo0wA8Bi4AkltZbYqcTPw/ppmBlmJrCjC
 Jp580nfPgExPoHJqP2jZY6Y7NVUHvy6g7rN7sb6eMh8K+pXyFthSyq3XK3BqSf2e3TF6KiUex
 zWAk37/8kAw6k3ueAxu5qoFMU66tRcSkmy8IY+1dAXaVRJ+TQ7A3CZNIIMtfBRi32kiCkff5o
 gYUuq3+RisN4YOs2Ob/F328FeL9fTOdXOzV8JyH4RLpzP62HRtaH7CK10fOrzU44SJglAZQ8B
 iTbT5Hyfwy5GGQO0XOUZyTzkqnlrL8znvfF7HwiFPAurNpcFdDIdCOjflOhLAoXkwvnec7BUS
 9YipPEkr++Iwrn+QWnQ0ECe7kfxf1luHZsbVbW+ZS3XjmSpSBJgdQX8pTXqt3Z1yBh8uX+y/3
 8TvIvtTkXpixmHqE5HlmXS2xb2nWWjulGzmxt+zsafF6w2OfBmUwICiQmghID2dckSBQPVzRG
 O8jZXSkSBG927Zh/aI+RW7N0QuxRa6U2GrmgGEJqlrxI0GKNT/0fj1Js4OmMZGDHiwyJJZFcF
 qNwwQcYIFecH0+SfV6Cb1EVuquvV/fVCRlHmdjYDkgnI19mauEmAqaiLXOOgOdNZ6lJr1ymdn
 fXoRBN7rL6MARitGODEQby43mPuqMjJXTRsdcriZivBS5XXr1tVOgjdn0LtdLkSg+49XAGRM+
 bJgzgt9dhuOLkHbpX2JhhqzBojAuQAT/NtgGqg==
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Parisc List <linux-parisc@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Networking <netdev@vger.kernel.org>, Helge Deller <deller@gmx.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
 cluster-devel@redhat.com, ccaulfie@redhat.com,
 Paul Mackerras <paulus@samba.org>, linux-alpha@vger.kernel.org,
 sparclinux <sparclinux@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>, Richard Henderson <rth@twiddle.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is a cleanup to prepare for the addition of 64-bit time_t
in O_SNDTIMEO/O_RCVTIMEO. The existing compat handler seems
unnecessarily complex and error-prone, moving it all into the
main setsockopt()/getsockopt() implementation requires half
as much code and is easier to extend.

32-bit user space can now use old_timeval32 on both 32-bit
and 64-bit machines, while 64-bit code can use
__old_kernel_timeval.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/compat.c    | 66 +------------------------------------------------
 net/core/sock.c | 65 +++++++++++++++++++++++++++++++-----------------
 2 files changed, 44 insertions(+), 87 deletions(-)

diff --git a/net/compat.c b/net/compat.c
index 959d1c51826d..ce8f6e8cdcd2 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -348,28 +348,6 @@ static int do_set_attach_filter(struct socket *sock, int level, int optname,
 			      sizeof(struct sock_fprog));
 }
 
-static int do_set_sock_timeout(struct socket *sock, int level,
-		int optname, char __user *optval, unsigned int optlen)
-{
-	struct compat_timeval __user *up = (struct compat_timeval __user *)optval;
-	struct timeval ktime;
-	mm_segment_t old_fs;
-	int err;
-
-	if (optlen < sizeof(*up))
-		return -EINVAL;
-	if (!access_ok(up, sizeof(*up)) ||
-	    __get_user(ktime.tv_sec, &up->tv_sec) ||
-	    __get_user(ktime.tv_usec, &up->tv_usec))
-		return -EFAULT;
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	err = sock_setsockopt(sock, level, optname, (char *)&ktime, sizeof(ktime));
-	set_fs(old_fs);
-
-	return err;
-}
-
 static int compat_sock_setsockopt(struct socket *sock, int level, int optname,
 				char __user *optval, unsigned int optlen)
 {
@@ -377,10 +355,6 @@ static int compat_sock_setsockopt(struct socket *sock, int level, int optname,
 	    optname == SO_ATTACH_REUSEPORT_CBPF)
 		return do_set_attach_filter(sock, level, optname,
 					    optval, optlen);
-	if (!COMPAT_USE_64BIT_TIME &&
-	    (optname == SO_RCVTIMEO || optname == SO_SNDTIMEO))
-		return do_set_sock_timeout(sock, level, optname, optval, optlen);
-
 	return sock_setsockopt(sock, level, optname, optval, optlen);
 }
 
@@ -417,44 +391,6 @@ COMPAT_SYSCALL_DEFINE5(setsockopt, int, fd, int, level, int, optname,
 	return __compat_sys_setsockopt(fd, level, optname, optval, optlen);
 }
 
-static int do_get_sock_timeout(struct socket *sock, int level, int optname,
-		char __user *optval, int __user *optlen)
-{
-	struct compat_timeval __user *up;
-	struct timeval ktime;
-	mm_segment_t old_fs;
-	int len, err;
-
-	up = (struct compat_timeval __user *) optval;
-	if (get_user(len, optlen))
-		return -EFAULT;
-	if (len < sizeof(*up))
-		return -EINVAL;
-	len = sizeof(ktime);
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	err = sock_getsockopt(sock, level, optname, (char *) &ktime, &len);
-	set_fs(old_fs);
-
-	if (!err) {
-		if (put_user(sizeof(*up), optlen) ||
-		    !access_ok(up, sizeof(*up)) ||
-		    __put_user(ktime.tv_sec, &up->tv_sec) ||
-		    __put_user(ktime.tv_usec, &up->tv_usec))
-			err = -EFAULT;
-	}
-	return err;
-}
-
-static int compat_sock_getsockopt(struct socket *sock, int level, int optname,
-				char __user *optval, int __user *optlen)
-{
-	if (!COMPAT_USE_64BIT_TIME &&
-	    (optname == SO_RCVTIMEO || optname == SO_SNDTIMEO))
-		return do_get_sock_timeout(sock, level, optname, optval, optlen);
-	return sock_getsockopt(sock, level, optname, optval, optlen);
-}
-
 int compat_sock_get_timestamp(struct sock *sk, struct timeval __user *userstamp)
 {
 	struct compat_timeval __user *ctv;
@@ -527,7 +463,7 @@ static int __compat_sys_getsockopt(int fd, int level, int optname,
 		}
 
 		if (level == SOL_SOCKET)
-			err = compat_sock_getsockopt(sock, level,
+			err = sock_getsockopt(sock, level,
 					optname, optval, optlen);
 		else if (sock->ops->compat_getsockopt)
 			err = sock->ops->compat_getsockopt(sock, level,
diff --git a/net/core/sock.c b/net/core/sock.c
index 6aa2e7e0b4fb..e50b9a2abc92 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -335,14 +335,48 @@ int __sk_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(__sk_backlog_rcv);
 
+static int sock_get_timeout(long timeo, void *optval)
+{
+	struct __kernel_old_timeval tv;
+
+	if (timeo == MAX_SCHEDULE_TIMEOUT) {
+		tv.tv_sec = 0;
+		tv.tv_usec = 0;
+	} else {
+		tv.tv_sec = timeo / HZ;
+		tv.tv_usec = ((timeo % HZ) * USEC_PER_SEC) / HZ;
+	}
+
+	if (in_compat_syscall() && !COMPAT_USE_64BIT_TIME) {
+		struct old_timeval32 tv32 = { tv.tv_sec, tv.tv_usec };
+		*(struct old_timeval32 *)optval = tv32;
+		return sizeof(tv32);
+	}
+
+	*(struct __kernel_old_timeval *)optval = tv;
+	return sizeof(tv);
+}
+
 static int sock_set_timeout(long *timeo_p, char __user *optval, int optlen)
 {
-	struct timeval tv;
+	struct __kernel_old_timeval tv;
 
-	if (optlen < sizeof(tv))
-		return -EINVAL;
-	if (copy_from_user(&tv, optval, sizeof(tv)))
-		return -EFAULT;
+	if (in_compat_syscall() && !COMPAT_USE_64BIT_TIME) {
+		struct old_timeval32 tv32;
+
+		if (optlen < sizeof(tv32))
+			return -EINVAL;
+
+		if (copy_from_user(&tv, optval, sizeof(tv)))
+			return -EFAULT;
+		tv.tv_sec = tv32.tv_sec;
+		tv.tv_usec = tv32.tv_usec;
+	} else {
+		if (optlen < sizeof(tv))
+			return -EINVAL;
+		if (copy_from_user(&tv, optval, sizeof(tv)))
+			return -EFAULT;
+	}
 	if (tv.tv_usec < 0 || tv.tv_usec >= USEC_PER_SEC)
 		return -EDOM;
 
@@ -1099,7 +1133,8 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		int val;
 		u64 val64;
 		struct linger ling;
-		struct timeval tm;
+		struct old_timeval32 tm32;
+		struct __kernel_old_timeval tm;
 		struct sock_txtime txtime;
 	} v;
 
@@ -1200,25 +1235,11 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_RCVTIMEO:
-		lv = sizeof(struct timeval);
-		if (sk->sk_rcvtimeo == MAX_SCHEDULE_TIMEOUT) {
-			v.tm.tv_sec = 0;
-			v.tm.tv_usec = 0;
-		} else {
-			v.tm.tv_sec = sk->sk_rcvtimeo / HZ;
-			v.tm.tv_usec = ((sk->sk_rcvtimeo % HZ) * USEC_PER_SEC) / HZ;
-		}
+		lv = sock_get_timeout(sk->sk_rcvtimeo, optval);
 		break;
 
 	case SO_SNDTIMEO:
-		lv = sizeof(struct timeval);
-		if (sk->sk_sndtimeo == MAX_SCHEDULE_TIMEOUT) {
-			v.tm.tv_sec = 0;
-			v.tm.tv_usec = 0;
-		} else {
-			v.tm.tv_sec = sk->sk_sndtimeo / HZ;
-			v.tm.tv_usec = ((sk->sk_sndtimeo % HZ) * USEC_PER_SEC) / HZ;
-		}
+		lv = sock_get_timeout(sk->sk_sndtimeo, optval);
 		break;
 
 	case SO_RCVLOWAT:
-- 
2.20.0

