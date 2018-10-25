Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF845C46475
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 20:28:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C06F2054F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 20:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C06F2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gzGC6RhNzF3CD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 07:28:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=naveen.n.rao@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gzD20XbDzF3CD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 07:26:09 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9PKOdQj008935
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 16:26:07 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2nbkj9bhh0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 16:26:06 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 25 Oct 2018 21:26:05 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 25 Oct 2018 21:26:02 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9PKQ1BI7405898
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 25 Oct 2018 20:26:01 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 889395204E;
 Thu, 25 Oct 2018 20:26:01 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.79.235.97])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BE88F52054;
 Thu, 25 Oct 2018 20:25:59 +0000 (GMT)
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>, 
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Jeremy Kerr <jk@ozlabs.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v1 0/5] Add dtl_entry tracepoint
Date: Fri, 26 Oct 2018 01:55:41 +0530
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18102520-0012-0000-0000-000002BDCD07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102520-0013-0000-0000-000020F1DF62
Message-Id: <cover.1540488386.git.naveen.n.rao@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-25_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810250167
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

This is v1 of the patches for providing a tracepoint for processing the 
dispatch trace log entries from the hypervisor in a shared processor 
LPAR. The previous RFC can be found here:
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=66340

Since the RFC, this series has been expanded/generalized to support 
!CONFIG_VIRT_CPU_ACCOUNTING_NATIVE and has been tested in different 
configurations. The dispatch distance calculation has also been updated 
to use the platform provided information better.

Also, patch 3 is new and fixes an issue with stolen time accounting when 
the dtl debugfs interface is in use.

- Naveen


Naveen N. Rao (5):
  powerpc/pseries: Use macros for referring to the DTL enable mask
  powerpc/pseries: Do not save the previous DTL mask value
  powerpc/pseries: Fix stolen time accounting when dtl debugfs is used
  powerpc/pseries: Factor out DTL buffer allocation and registration
    routines
  powerpc/pseries: Introduce dtl_entry tracepoint

 arch/powerpc/include/asm/lppaca.h         |  11 +
 arch/powerpc/include/asm/plpar_wrappers.h |   9 +
 arch/powerpc/include/asm/trace.h          |  55 +++++
 arch/powerpc/kernel/entry_64.S            |  39 ++++
 arch/powerpc/kernel/time.c                |   7 +-
 arch/powerpc/mm/numa.c                    | 144 ++++++++++++-
 arch/powerpc/platforms/pseries/dtl.c      |  22 +-
 arch/powerpc/platforms/pseries/lpar.c     | 249 ++++++++++++++++++++--
 arch/powerpc/platforms/pseries/setup.c    |  34 +--
 9 files changed, 502 insertions(+), 68 deletions(-)

-- 
2.19.1

