Return-Path: <osstklei@de.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5226A67B56
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 19:40:37 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.7/8.13.7) with ESMTP id k7B9eWRd070414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 09:40:33 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k7B9gMf2145848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 10:42:22 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7B9eW0s005049
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 10:40:32 +0100
Message-ID: <44DC508F.8040100@de.ibm.com>
Date: Fri, 11 Aug 2006 11:40:31 +0200
From: Thomas Klein <osstklei@de.ibm.com>
MIME-Version: 1.0
To: linux-ppc <linuxppc-dev@ozlabs.org>
Subject: [PATCH] ehea: PPC - New hcall opcode defines
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

this patch adds additional hcall opcode defines in asm-powerpc/hvcall.h
which are required for the IBM eHEA Ethernet Device Driver which is
targeted for kernel inclusion in the near future.

Including those defines in hvcall.h was a request we got in reply to
posting our driver.

Driver post: http://ozlabs.org/pipermail/linuxppc-dev/2006-August/024947.html
Reply: http://ozlabs.org/pipermail/linuxppc-dev/2006-August/024971.html

I'm aware this does not fix a bug and we're already at rc4 but since it
adds only a few innocent defines it would be great if it could be included
in 2.6.18-rc5.

This patch replaces yesterday's patch with the same title. It contains
the modification requested by a comment I got.

Kind regards
Thomas


Signed-off-by: Thomas Klein <tklein@de.ibm.com>
Changelog-by:  Thomas Klein <tklein@de.ibm.com>

Differences to patch
http://ozlabs.org/pipermail/linuxppc-dev/2006-August/025000.html

Changelog:
- New defines rearranged according to their numerical value



  include/asm-powerpc/hvcall.h |   13 +++++++++++++
  1 file changed, 13 insertions(+)



diff -Nurp -X dontdiff linux-2.6.18-rc4/include/asm-powerpc/hvcall.h patched_kernel/include/asm-powerpc/hvcall.h
--- linux-2.6.18-rc4/include/asm-powerpc/hvcall.h	2006-08-06 11:20:11.000000000 -0700
+++ patched_kernel/include/asm-powerpc/hvcall.h	2006-08-11 01:54:49.696514466 -0700
@@ -198,6 +198,19 @@
  #define H_MANAGE_TRACE          0x1C0
  #define H_QUERY_INT_STATE       0x1E4
  #define H_POLL_PENDING		0x1D8
+#define H_MODIFY_HEA_QP		0x250
+#define H_QUERY_HEA_QP		0x254
+#define H_QUERY_HEA		0x258
+#define H_QUERY_HEA_PORT	0x25C
+#define H_MODIFY_HEA_PORT	0x260
+#define H_REG_BCMC		0x264
+#define H_DEREG_BCMC		0x268
+#define H_REGISTER_HEA_RPAGES	0x26C
+#define H_DISABLE_AND_GET_HEA	0x270
+#define H_GET_HEA_INFO		0x274
+#define H_ALLOC_HEA_RESOURCE	0x278
+#define H_ADD_CONN		0x284
+#define H_DEL_CONN		0x288
  #define H_JOIN			0x298
  #define H_VASI_STATE            0x2A4
  #define H_ENABLE_CRQ		0x2B0
