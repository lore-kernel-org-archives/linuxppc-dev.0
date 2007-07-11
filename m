Return-Path: <ossthema@de.ibm.com>
Received: from mtagate4.uk.ibm.com (mtagate4.uk.ibm.com [195.212.29.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 59C17DDFB6
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 00:47:39 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate4.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l6BElZgx112428
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 14:47:35 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l6BElZnO3125482
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 15:47:35 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6BElYVk001270
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 15:47:34 +0100
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [RFC 2/3] lro: Kconfig and Makefile
Date: Wed, 11 Jul 2007 16:21:41 +0200
MIME-Version: 1.0
To: netdev <netdev@vger.kernel.org>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707111621.41800.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kconfig and Makefile changes for LRO

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
---
 net/ipv4/Kconfig  |    9 +++++++++
 net/ipv4/Makefile |    1 +
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 010fbb2..25279f4 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -436,6 +436,15 @@ config INET_XFRM_MODE_BEET
 
 	  If unsure, say Y.
 
+config INET_LRO
+	tristate "Large Receive Offload (tcp)"
+	default y
+
+	---help---
+	  Support for Large Receive Offload (tcp).
+
+	  if unsure, say Y.
+
 config INET_DIAG
 	tristate "INET: socket monitoring interface"
 	default y
diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index 4ff6c15..a8f6d51 100644
--- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_INET_ESP) += esp4.o
 obj-$(CONFIG_INET_IPCOMP) += ipcomp.o
 obj-$(CONFIG_INET_XFRM_TUNNEL) += xfrm4_tunnel.o
 obj-$(CONFIG_INET_XFRM_MODE_BEET) += xfrm4_mode_beet.o
+obj-$(CONFIG_INET_LRO) += inet_lro.o
 obj-$(CONFIG_INET_TUNNEL) += tunnel4.o
 obj-$(CONFIG_INET_XFRM_MODE_TRANSPORT) += xfrm4_mode_transport.o
 obj-$(CONFIG_INET_XFRM_MODE_TUNNEL) += xfrm4_mode_tunnel.o
-- 
1.5.2
