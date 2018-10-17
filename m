Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D99FECDE32
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 08:35:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BBD720658
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 08:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BBD720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Zlqf2LPJzF3Zh
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 19:35:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=zurich.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=lch@zurich.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=zurich.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZlnZ3ZSjzDrNV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 19:33:34 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9H8Suph070059
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 04:33:33 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n60144qje-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 04:33:32 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <LCH@zurich.ibm.com>;
 Wed, 17 Oct 2018 09:33:30 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 17 Oct 2018 09:33:29 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9H8XSYt66715662
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 08:33:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C330342049
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 08:33:28 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B615742042
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 08:33:28 +0000 (GMT)
Received: from d06ml359.portsmouth.uk.ibm.com (unknown [9.149.76.147])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 08:33:28 +0000 (GMT)
Subject: help
X-KeepSent: 2E1784F7:5A472205-C1258329:002EF388;
 type=4; name=$KeepSent
To: linuxppc-dev@lists.ozlabs.org
X-Mailer: IBM Notes Release 9.0.1FP10 SHF68 March 06, 2018
From: Lorenzo Chelini <LCH@zurich.ibm.com>
Date: Wed, 17 Oct 2018 10:33:28 +0200
X-MIMETrack: Serialize by Router on D06ML359/06/M/IBM(Release 9.0.1FP10HF192 |
 April 16, 2018) at 17/10/2018 10:33:28
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18101708-0008-0000-0000-00000280AE8F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101708-0009-0000-0000-000021EA1343
Message-Id: <OF2E1784F7.5A472205-ONC1258329.002EF388-C1258329.002F029F@ch.ibm.com>
Content-type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-16_14:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=615 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810170077
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Hi All,

I am a PhD at IBM Zurich. I am playing around with the new POWER9 servers.
I am interested in plotting a roofline model for a given application, but I
need
to measure the traffic to and from the memory.
Ideally, what I would like to measure is the traffic at the memory
controller level.

Do you know if this is possible using perf? If yes, which performance
counters I should
query to have an estimate on the memory traffic?

Thanks for your time.
Looking forward to hearing from you.
Best regards,
Lorenzo Chelini

