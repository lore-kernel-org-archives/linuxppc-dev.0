Return-Path: <osstklei@de.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 30360679FD
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 01:05:33 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.7/8.13.7) with ESMTP id k7AF5TDa031276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 15:05:29 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k7AF7ITh138000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 16:07:18 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7AF5TmE018341
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 16:05:29 +0100
Message-ID: <44DB4B38.9030502@de.ibm.com>
Date: Thu, 10 Aug 2006 17:05:28 +0200
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

Kind regards
Thomas


Signed-off-by: Thomas Klein <tklein@de.ibm.com>


  include/asm-powerpc/hvcall.h |   13 +++++++++++++
  1 file changed, 13 insertions(+)


diff -Nurp -X dontdiff linux-2.6.18-rc4/include/asm-powerpc/hvcall.h patched_kernel/include/asm-powerpc/hvcall.h
--- linux-2.6.18-rc4/include/asm-powerpc/hvcall.h	2006-08-06 11:20:11.000000000 -0700
+++ patched_kernel/include/asm-powerpc/hvcall.h	2006-08-10 06:26:33.018907062 -0700
@@ -201,6 +201,19 @@
  #define H_JOIN			0x298
  #define H_VASI_STATE            0x2A4
  #define H_ENABLE_CRQ		0x2B0
+#define H_ALLOC_HEA_RESOURCE	0x278
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
+#define H_ADD_CONN		0x284
+#define H_DEL_CONN		0x288

  #ifndef __ASSEMBLY__
