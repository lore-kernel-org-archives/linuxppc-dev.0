Return-Path: <mkravetz@us.ibm.com>
Received: from over.co.us.ibm.com (over.co.us.ibm.com [32.97.110.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ACCDE67BA6
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jul 2006 17:33:32 +1000 (EST)
Received: from e4.ny.us.ibm.com (e4.pok.ibm.com [9.56.232.144])
	by bldfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6L6dt47030787
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jul 2006 02:39:56 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6L6dqZj027559
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jul 2006 02:39:52 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6L6dqkC252096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jul 2006 02:39:52 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6L6dqRs027327
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jul 2006 02:39:52 -0400
Date: Thu, 20 Jul 2006 23:39:51 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/3] powerpc: Instrument Hypervisor Calls: merge headers
Message-ID: <20060721063951.GB8639@monkey.ibm.com>
References: <20060721063824.GA8639@monkey.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060721063824.GA8639@monkey.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move all the Hypervisor call definitions to to a single header file.
--
Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>

diff -Naupr powerpc/drivers/net/ibmveth.h powerpc.work/drivers/net/ibmveth.h
--- powerpc/drivers/net/ibmveth.h	2006-07-19 18:58:18.000000000 +0000
+++ powerpc.work/drivers/net/ibmveth.h	2006-07-21 07:03:44.000000000 +0000
@@ -41,16 +41,6 @@
 #define IbmVethMcastRemoveFilter     0x2UL
 #define IbmVethMcastClearFilterTable 0x3UL
 
-/* hcall numbers */
-#define H_VIO_SIGNAL             0x104
-#define H_REGISTER_LOGICAL_LAN   0x114
-#define H_FREE_LOGICAL_LAN       0x118
-#define H_ADD_LOGICAL_LAN_BUFFER 0x11C
-#define H_SEND_LOGICAL_LAN       0x120
-#define H_MULTICAST_CTRL         0x130
-#define H_CHANGE_LOGICAL_LAN_MAC 0x14C
-#define H_FREE_LOGICAL_LAN_BUFFER 0x1D4
-
 /* hcall macros */
 #define h_register_logical_lan(ua, buflst, rxq, fltlst, mac) \
   plpar_hcall_norets(H_REGISTER_LOGICAL_LAN, ua, buflst, rxq, fltlst, mac)
diff -Naupr powerpc/include/asm-powerpc/hvcall.h powerpc.work/include/asm-powerpc/hvcall.h
--- powerpc/include/asm-powerpc/hvcall.h	2006-07-19 18:58:18.000000000 +0000
+++ powerpc.work/include/asm-powerpc/hvcall.h	2006-07-21 07:03:44.000000000 +0000
@@ -164,9 +164,15 @@
 #define H_VIO_SIGNAL		0x104
 #define H_SEND_CRQ		0x108
 #define H_COPY_RDMA		0x110
+#define H_REGISTER_LOGICAL_LAN	0x114
+#define H_FREE_LOGICAL_LAN	0x118
+#define H_ADD_LOGICAL_LAN_BUFFER 0x11C
+#define H_SEND_LOGICAL_LAN	0x120
+#define H_MULTICAST_CTRL	0x130
 #define H_SET_XDABR		0x134
 #define H_STUFF_TCE		0x138
 #define H_PUT_TCE_INDIRECT	0x13C
+#define H_CHANGE_LOGICAL_LAN_MAC 0x14C
 #define H_VTERM_PARTNER_INFO	0x150
 #define H_REGISTER_VTERM	0x154
 #define H_FREE_VTERM		0x158
@@ -196,11 +202,13 @@
 #define H_GET_HCA_INFO          0x1B8
 #define H_GET_PERF_COUNT        0x1BC
 #define H_MANAGE_TRACE          0x1C0
+#define H_FREE_LOGICAL_LAN_BUFFER 0x1D4
 #define H_QUERY_INT_STATE       0x1E4
 #define H_POLL_PENDING		0x1D8
 #define H_JOIN			0x298
 #define H_VASI_STATE            0x2A4
 #define H_ENABLE_CRQ		0x2B0
+#define MAX_HCALL_OPCODES	(H_ENABLE_CRQ >> 2)
 
 #ifndef __ASSEMBLY__
 
