Return-Path: <SRS0=INWp=NY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56427C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 21:58:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3EAC223D0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 21:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3EAC223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vhMS2jBtzF3NS
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 08:58:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=gromero@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vhKJ2h8czF3Jw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 08:56:17 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wADLs7AE025576
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 16:56:15 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nr6uer8ra-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 16:56:14 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gromero@linux.vnet.ibm.com>;
 Tue, 13 Nov 2018 21:56:14 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 13 Nov 2018 21:56:12 -0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wADLuBKA29949998
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 13 Nov 2018 21:56:11 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44B65C605F;
 Tue, 13 Nov 2018 21:56:11 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A29CC6055;
 Tue, 13 Nov 2018 21:56:10 +0000 (GMT)
Received: from oc6336877782.ibm.com (unknown [9.80.225.70])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 13 Nov 2018 21:56:09 +0000 (GMT)
To: Michael Ellerman <mpe@ellerman.id.au>
From: Gustavo Romero <gromero@linux.vnet.ibm.com>
Subject: It looks like that wild_bctr on powerpc/fixes is still not compiling
Date: Tue, 13 Nov 2018 19:56:08 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18111321-0016-0000-0000-00000952D4AE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010044; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01117015; UDB=6.00577116; IPR=6.00897123; 
 MB=3.00024147; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-13 21:56:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111321-0017-0000-0000-0000410C825B
Message-Id: <4dddbc2a-fc3f-5ea5-54be-8e2a5375db76@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-13_15:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811130196
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi mpe,

Even after the latest fix for the wild_bctr selftest I'm still getting the
following compilation (actually, an assembling error) because UL is not
understood by the assembler:

BUILD_TARGET=/home/gromero/git/linux/tools/testing/selftests/powerpc/mm; mkdir -p $BUILD_TARGET; make OUTPUT=$BUILD_TARGET -k -C mm all
make[1]: Entering directory '/home/gromero/git/linux/tools/testing/selftests/powerpc/mm'
gcc -std=gnu99 -O2 -Wall -Werror -DGIT_VERSION='"v4.20-rc1-8-g2c7645b"' -I/home/gromero/git/linux/tools/testing/selftests/powerpc/include  -m64    wild_bctr.c ../harness.c  -o /home/gromero/git/linux/tools/testing/selftests/powerpc/mm/wild_bctr
/tmp/cctUajlx.s: Assembler messages:
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
/tmp/cctUajlx.s:270: Error: syntax error; found `U', expected `,'
/tmp/cctUajlx.s:270: Error: junk at end of line: `UL'
../../lib.mk:152: recipe for target '/home/gromero/git/linux/tools/testing/selftests/powerpc/mm/wild_bctr' failed
make[1]: *** [/home/gromero/git/linux/tools/testing/selftests/powerpc/mm/wild_bctr] Error 1
make[1]: Target 'all' not remade because of errors.
make[1]: Leaving directory '/home/gromero/git/linux/tools/testing/selftests/powerpc/mm'
Makefile:39: recipe for target 'mm' failed
make: *** [mm] Error 2

For:
git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git (powerpc/fixes)
$ git describe
v4.20-rc1-8-g2c7645b

This is gcc:
$ gcc --version
gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609

but it should not make a difference, so  I'm wondering if anybody else is
getting the same error too...

The following trivial workaround can solve it by forcing a type promotion on
the compiler side whilst leaving the macro taken into the asm code without
the UL string:

diff --git a/tools/testing/selftests/powerpc/mm/wild_bctr.c b/tools/testing/selftests/powerpc/mm/wild_bctr.c
index 90469a9..d2772f4 100644
--- a/tools/testing/selftests/powerpc/mm/wild_bctr.c
+++ b/tools/testing/selftests/powerpc/mm/wild_bctr.c
@@ -47,8 +47,9 @@ static int ok(void)
         return 0;
  }
  
-#define REG_POISON     0x5a5aUL
-#define POISONED_REG(n)        ((REG_POISON << 48) | ((n) << 32) | (REG_POISON << 16) | (n))
+#define REG_POISON     0x5a5a
+#define POISONED_REG(n)        (((REG_POISON+0UL) << 48) | ((n) << 32) | ((REG_POISON+0UL) << 16) | (n))
  
  static inline void poison_regs(void)
  {


Should I contribute such a fix?

Thank you.


Best regards,
Gustavo

