Return-Path: <SRS0=/SFz=QJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C442C282D7
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 15:42:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F376C2085A
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 15:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpimryTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F376C2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43sJB82DJnzDqNC
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 Feb 2019 02:42:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=deepa.kernel@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="dpimryTQ"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43sJ3K2mmxzDqLW
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Feb 2019 02:36:12 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id u18so4769887plq.7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 02 Feb 2019 07:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sjG3pmoRTTFYFdvwEJac2XT1gh4h8TOarYdBhlzv53c=;
 b=dpimryTQNpsUOD95NqhZDMT1JPUKsvNjscDYIHOC81SEYLmAJyQ2xsiyh7x5XyNUDy
 HBodHK5OWKteeK2UxOtMka/l7DPuuaPUZDlVMLEBI6WK6J3YBMTv4/MiBTXk7+FKg3Ie
 5e5gbU1vcHvbQE/Tcka4JyH8gkhu0VBO20ahcL57hLGmC64+p7m/2Fv3Ij0Q8JsOHxxc
 yHfaoeZCAneDIuYsiRjwoygptvbu4N39ZYBQCKoH0G8zWXkGe2NuFzEel9ifunV6HCiu
 TbCJ0LlAiXTCO7IH87jU5+3EMu3a+Ul1NvZzBs9KYB7ffPPtqMPiOWrgCx1mIMn4K0GK
 W/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sjG3pmoRTTFYFdvwEJac2XT1gh4h8TOarYdBhlzv53c=;
 b=n2O+QYwIKB1WyD5fgPJnHChgZmkVEdAsmhDlZWVQAUAbMT4dia2agVL9DovlRXLRwf
 B9kJ+B47YpqFhOSH9liJTGXoSYHl6kRStxd+hZgdsLCou7TSa3kOIshKzom9pf+E/bLr
 brbOmTN7iw2ZXXBTmsS0RNgBeejfhlpdbta9zNnMrXQ8O6FgEdy1JGbQupXHbRbcp5oh
 dt5lZsWSsDIEE4HO60Ss2ouaRtr3rUQs6e1s+iHu0GQIXTE7ROzNY4nOZI1029C/F6Tc
 RnlbNYZoPiaYiBmFrLur4CylKojIN6lC2HAdnKE1VnyYoaW5+A/uwHBB4T8X1IS3Xqyv
 OoHw==
X-Gm-Message-State: AJcUukfQUGG7yynUDmS2e8neRoGWQ5FekJ81KzTxafttCboXN1b2sz23
 q8RTOfGxjSIwTKms0Nf7ZbM=
X-Google-Smtp-Source: ALg8bN66fiKMbSwIYo4Kfpfln/AoBeYvKVdXYAjGBDRt5vzMAgnTB0MvDtyLMgzFS/YB4HD8YxQ3mg==
X-Received: by 2002:a17:902:584:: with SMTP id
 f4mr45545544plf.28.1549121766215; 
 Sat, 02 Feb 2019 07:36:06 -0800 (PST)
Received: from localhost.localdomain ([49.206.15.111])
 by smtp.gmail.com with ESMTPSA id m20sm16221611pgb.56.2019.02.02.07.35.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 02 Feb 2019 07:36:05 -0800 (PST)
From: Deepa Dinamani <deepa.kernel@gmail.com>
To: davem@davemloft.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 11/12] socket: Rename SO_RCVTIMEO/ SO_SNDTIMEO
 with _OLD suffixes
Date: Sat,  2 Feb 2019 07:34:53 -0800
Message-Id: <20190202153454.7121-12-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190202153454.7121-1-deepa.kernel@gmail.com>
References: <20190202153454.7121-1-deepa.kernel@gmail.com>
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
Cc: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org, arnd@arndb.de,
 y2038@lists.linaro.org, netdev@vger.kernel.org, deller@gmx.de,
 linux-mips@vger.kernel.org, ralf@linux-mips.org, cluster-devel@redhat.com,
 ccaulfie@redhat.com, paulus@samba.org, linux-alpha@vger.kernel.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, rth@twiddle.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SO_RCVTIMEO and SO_SNDTIMEO socket options use struct timeval
as the time format. struct timeval is not y2038 safe.
The subsequent patches in the series add support for new socket
timeout options with _NEW suffix that will use y2038 safe
data structures. Although the existing struct timeval layout
is sufficiently wide to represent timeouts, because of the way
libc will interpret time_t based on user defined flag, these
new flags provide a way of having a structure that is the same
for all architectures consistently.
Rename the existing options with _OLD suffix forms so that the
right option is enabled for userspace applications according
to the architecture and time_t definition of libc.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Cc: ccaulfie@redhat.com
Cc: deller@gmx.de
Cc: paulus@samba.org
Cc: ralf@linux-mips.org
Cc: rth@twiddle.net
Cc: cluster-devel@redhat.com
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: sparclinux@vger.kernel.org
---
 arch/alpha/include/uapi/asm/socket.h   | 7 +++++--
 arch/mips/include/uapi/asm/socket.h    | 6 ++++--
 arch/parisc/include/uapi/asm/socket.h  | 6 ++++--
 arch/powerpc/include/uapi/asm/socket.h | 4 ++--
 arch/sparc/include/uapi/asm/socket.h   | 7 +++++--
 fs/dlm/lowcomms.c                      | 4 ++--
 include/uapi/asm-generic/socket.h      | 6 ++++--
 net/core/sock.c                        | 4 ++--
 8 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index 934ea6268f1a..9826d1db71d0 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -31,8 +31,8 @@
 #define SO_RCVBUFFORCE	0x100b
 #define	SO_RCVLOWAT	0x1010
 #define	SO_SNDLOWAT	0x1011
-#define	SO_RCVTIMEO	0x1012
-#define	SO_SNDTIMEO	0x1013
+#define	SO_RCVTIMEO_OLD	0x1012
+#define	SO_SNDTIMEO_OLD	0x1013
 #define SO_ACCEPTCONN	0x1014
 #define SO_PROTOCOL	0x1028
 #define SO_DOMAIN	0x1029
@@ -121,6 +121,9 @@
 
 #if !defined(__KERNEL__)
 
+#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
+#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
+
 #if __BITS_PER_LONG == 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 110f9506d64f..96cc0e907f12 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -39,8 +39,8 @@
 #define SO_RCVBUF	0x1002	/* Receive buffer. */
 #define SO_SNDLOWAT	0x1003	/* send low-water mark */
 #define SO_RCVLOWAT	0x1004	/* receive low-water mark */
-#define SO_SNDTIMEO	0x1005	/* send timeout */
-#define SO_RCVTIMEO	0x1006	/* receive timeout */
+#define SO_SNDTIMEO_OLD	0x1005	/* send timeout */
+#define SO_RCVTIMEO_OLD	0x1006	/* receive timeout */
 #define SO_ACCEPTCONN	0x1009
 #define SO_PROTOCOL	0x1028	/* protocol type */
 #define SO_DOMAIN	0x1029	/* domain/socket family */
@@ -132,6 +132,8 @@
 
 #if !defined(__KERNEL__)
 
+#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
+#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
 #if __BITS_PER_LONG == 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index bee2a9dde656..046f0cd9cce4 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -22,8 +22,8 @@
 #define SO_RCVBUFFORCE	0x100b
 #define SO_SNDLOWAT	0x1003
 #define SO_RCVLOWAT	0x1004
-#define SO_SNDTIMEO	0x1005
-#define SO_RCVTIMEO	0x1006
+#define SO_SNDTIMEO_OLD	0x1005
+#define SO_RCVTIMEO_OLD	0x1006
 #define SO_ERROR	0x1007
 #define SO_TYPE		0x1008
 #define SO_PROTOCOL	0x1028
@@ -113,6 +113,8 @@
 
 #if !defined(__KERNEL__)
 
+#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
+#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
 #if __BITS_PER_LONG == 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
diff --git a/arch/powerpc/include/uapi/asm/socket.h b/arch/powerpc/include/uapi/asm/socket.h
index 94de465e0920..12aa0c43e775 100644
--- a/arch/powerpc/include/uapi/asm/socket.h
+++ b/arch/powerpc/include/uapi/asm/socket.h
@@ -11,8 +11,8 @@
 
 #define SO_RCVLOWAT	16
 #define SO_SNDLOWAT	17
-#define SO_RCVTIMEO	18
-#define SO_SNDTIMEO	19
+#define SO_RCVTIMEO_OLD	18
+#define SO_SNDTIMEO_OLD	19
 #define SO_PASSCRED	20
 #define SO_PEERCRED	21
 
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 2b38dda51426..342ffdc3b424 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -21,8 +21,8 @@
 #define SO_BSDCOMPAT    0x0400
 #define SO_RCVLOWAT     0x0800
 #define SO_SNDLOWAT     0x1000
-#define SO_RCVTIMEO     0x2000
-#define SO_SNDTIMEO     0x4000
+#define SO_RCVTIMEO_OLD     0x2000
+#define SO_SNDTIMEO_OLD     0x4000
 #define SO_ACCEPTCONN	0x8000
 
 #define SO_SNDBUF	0x1001
@@ -114,6 +114,9 @@
 
 #if !defined(__KERNEL__)
 
+#define SO_RCVTIMEO              SO_RCVTIMEO_OLD
+#define SO_SNDTIMEO              SO_SNDTIMEO_OLD
+
 #if __BITS_PER_LONG == 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 76976d6e50f9..c98ad9777ad9 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1089,12 +1089,12 @@ static void sctp_connect_to_sock(struct connection *con)
 	 * since O_NONBLOCK argument in connect() function does not work here,
 	 * then, we should restore the default value of this attribute.
 	 */
-	kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, (char *)&tv,
+	kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO_OLD, (char *)&tv,
 			  sizeof(tv));
 	result = sock->ops->connect(sock, (struct sockaddr *)&daddr, addr_len,
 				   0);
 	memset(&tv, 0, sizeof(tv));
-	kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, (char *)&tv,
+	kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO_OLD, (char *)&tv,
 			  sizeof(tv));
 
 	if (result == -EINPROGRESS)
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 2713e0fa68ef..c56b8b487c12 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -30,8 +30,8 @@
 #define SO_PEERCRED	17
 #define SO_RCVLOWAT	18
 #define SO_SNDLOWAT	19
-#define SO_RCVTIMEO	20
-#define SO_SNDTIMEO	21
+#define SO_RCVTIMEO_OLD	20
+#define SO_SNDTIMEO_OLD	21
 #endif
 
 /* Security levels - as per NRL IPv6 - don't actually do anything */
@@ -116,6 +116,8 @@
 
 #if !defined(__KERNEL__)
 
+#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
+#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
 /* on 64-bit and x32, avoid the ?: operator */
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
diff --git a/net/core/sock.c b/net/core/sock.c
index a9d1ecce96e5..27b40002b780 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -941,11 +941,11 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 			sk->sk_rcvlowat = val ? : 1;
 		break;
 
-	case SO_RCVTIMEO:
+	case SO_RCVTIMEO_OLD:
 		ret = sock_set_timeout(&sk->sk_rcvtimeo, optval, optlen);
 		break;
 
-	case SO_SNDTIMEO:
+	case SO_SNDTIMEO_OLD:
 		ret = sock_set_timeout(&sk->sk_sndtimeo, optval, optlen);
 		break;
 
-- 
2.17.1

