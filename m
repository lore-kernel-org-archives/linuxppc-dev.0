Return-Path: <SRS0=vFFG=MY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDC7C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 07:48:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77C7C2087D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 07:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C7C2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Wg1m2rVkzF3J1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 18:48:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=abdhalee@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Wfyf0X68zF3Hc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 18:45:45 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9C7j9Px092381
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 03:45:42 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n2nay4y4b-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 03:45:42 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Fri, 12 Oct 2018 01:45:41 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
 by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 12 Oct 2018 01:45:38 -0600
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9C7jbJD36700338
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 12 Oct 2018 00:45:37 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C35466A04D;
 Fri, 12 Oct 2018 01:45:37 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B7AAC6A047;
 Fri, 12 Oct 2018 01:45:33 -0600 (MDT)
Received: from [9.84.221.36] (unknown [9.84.221.36])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 12 Oct 2018 01:45:33 -0600 (MDT)
Subject: [BUG][linux-next][ppc] kernel panic - not syncing: stack-protector:
 Kernel stack is corrupted in: __schedule+0x978/0xa80
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 12 Oct 2018 13:15:31 +0530
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18101207-8235-0000-0000-00000E1337A8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009864; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01101476; UDB=6.00569976; IPR=6.00881522; 
 MB=3.00023725; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-12 07:45:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101207-8236-0000-0000-000042F8428D
Message-Id: <1539330331.17569.32.camel@abdul.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-12_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=755 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810120078
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
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-kernel <linux-kernel@vger.kernel.org>, npiggin <npiggin@gmail.com>,
 linux-next <linux-next@vger.kernel.org>,
 manvanth <manvanth@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Greeting's

Today's linux-next fails to boot on powerpc bare-metal with this error

POWER8 performance monitor hardware support registered
rcu: Hierarchical SRCU implementation.
smp: Bringing up secondary CPUs ...
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: __schedule+0x978/0xa80
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.0-rc7-next-20181010-autotest-autotest #1
Call Trace:
[c000001fed5b3bf0] [c000000000a0ef3c] dump_stack+0xb0/0xf4 (unreliable)
[c000001fed5b3c30] [c0000000000f9d68] panic+0x140/0x308
[c000001fed5b3cc0] [c0000000000f9844] __stack_chk_fail+0x24/0x30
[c000001fed5b3d20] [c000000000a2c3a8] __schedule+0x978/0xa80
[c000001fed5b3e00] [c000000000a2c9b4] schedule_idle+0x34/0x60
[c000001fed5b3e30] [c00000000013d344] do_idle+0x224/0x3d0
[c000001fed5b3ec0] [c00000000013d6e0] cpu_startup_entry+0x30/0x50
[c000001fed5b3ef0] [c000000000047f34] start_secondary+0x4d4/0x520
[c000001fed5b3f90] [c00000000000b370] start_secondary_prolog+0x10/0x14
Rebooting in 10 seconds..

Machine: Power 8 bare-metal
kernel version: 4.19.0-rc7-next-20181010
gcc version: 4.8.5 20150623
config attach

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre



