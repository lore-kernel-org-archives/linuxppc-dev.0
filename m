Return-Path: <mkravetz@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9F32367B63
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Jul 2006 09:39:23 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6ENdKLm031005
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 19:39:20 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6ENdKAs152288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 17:39:20 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6ENdJNE023858
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 17:39:20 -0600
Date: Fri, 14 Jul 2006 16:39:23 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/3] powerpc: Instrument Hypervisor Calls: merge headers
Message-ID: <20060714233923.GB11487@monkey.ibm.com>
References: <20060714233739.GA11487@monkey.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060714233739.GA11487@monkey.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Bryan Rosenburg <rosnbrg@us.ibm.com>,
	linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>,
	Christopher Yeoh <cyeoh@samba.org>
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

diff -Naupr linux-2.6.17.4/drivers/net/ibmveth.h linux-2.6.17.4.work/drivers/net/ibmveth.h
--- linux-2.6.17.4/drivers/net/ibmveth.h	2006-07-06 20:02:28.000000000 +0000
+++ linux-2.6.17.4.work/drivers/net/ibmveth.h	2006-07-14 23:05:37.000000000 +0000
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
diff -Naupr linux-2.6.17.4/include/asm-powerpc/hvcall.h linux-2.6.17.4.work/include/asm-powerpc/hvcall.h
--- linux-2.6.17.4/include/asm-powerpc/hvcall.h	2006-07-06 20:02:28.000000000 +0000
+++ linux-2.6.17.4.work/include/asm-powerpc/hvcall.h	2006-07-14 23:05:37.000000000 +0000
@@ -155,9 +155,15 @@
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
@@ -187,11 +193,14 @@
 #define H_GET_HCA_INFO          0x1B8
 #define H_GET_PERF_COUNT        0x1BC
 #define H_MANAGE_TRACE          0x1C0
+#define H_FREE_LOGICAL_LAN_BUFFER 0x1D4
 #define H_QUERY_INT_STATE       0x1E4
 #define H_POLL_PENDING		0x1D8
 #define H_JOIN			0x298
 #define H_ENABLE_CRQ		0x2B0
 
+#define MAX_HCALL_OPCODES	(H_ENABLE_CRQ >> 2)
+
 #ifndef __ASSEMBLY__
 
 /* plpar_hcall() -- Generic call interface using above opcodes
