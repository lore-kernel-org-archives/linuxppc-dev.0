Return-Path: <SRS0=TUcR=HG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F11C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Feb 2021 12:17:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2832364F5E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Feb 2021 12:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2832364F5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DWcxq3YSLzDrTG
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Feb 2021 23:17:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.vnet.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=VG8mgbfn; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DWcs31nzpzDrQP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2021 23:13:25 +1100 (AEDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 114CAiBW115660; Thu, 4 Feb 2021 07:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=4GAJZhNizxBRbf2qIUPcYo7KVCzd5Wbm8DB7a3X8g4k=;
 b=VG8mgbfneThGV0po27QCkYI8totRylHlFar0cnqF4NefSFM78xQoWedeln6hmv57uziA
 XyckzROlwxIUb/60iDXFWfuLOQCNemSbKbkWD9WFHX2diAfHUg9Fp15NhZlFYWOpcpvd
 3SI+L7pjp8439jpX5uuFvzur4FDrqljStZCL1eL7/m7yFtr0ak8IB4MuRqo/XZKlWuBu
 /x1LAPmvSgmrrC07JuAnX6P9m+RJa22Ek+36WXPn+wgTXjfIh1VepNY71cyBkUX+VlfN
 HE9QSX1iniOoiRgMlL0DiN5MGOyc75hIXQ+eAXHdSNIIlqCnJks5IuzIzINYguTVDi3n kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 36ggjv89jc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Feb 2021 07:13:22 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 114CBl5i121736;
 Thu, 4 Feb 2021 07:13:21 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 36ggjv89hq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Feb 2021 07:13:21 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 114CCAmW031287;
 Thu, 4 Feb 2021 12:13:19 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma03ams.nl.ibm.com with ESMTP id 36fwcw0w0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Feb 2021 12:13:19 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 114CDGDo39846332
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 4 Feb 2021 12:13:16 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72E1B4C044;
 Thu,  4 Feb 2021 12:13:16 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 191474C050;
 Thu,  4 Feb 2021 12:13:15 +0000 (GMT)
Received: from [9.79.225.8] (unknown [9.79.225.8])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu,  4 Feb 2021 12:13:14 +0000 (GMT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] tools/perf: Fix powerpc gap between kernel end and module
 start
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20210203153148.GC854763@kernel.org>
Date: Thu, 4 Feb 2021 17:41:06 +0530
Content-Transfer-Encoding: quoted-printable
Message-Id: <D40F01AF-BAE5-49BE-8974-4F4B10EF58F0@linux.vnet.ibm.com>
References: <1609208054-1566-1-git-send-email-atrajeev@linux.vnet.ibm.com>
 <20210112093811.GA1272772@krava>
 <dd8b772b-fa13-975b-be42-2b7bdf14b46d@linux.ibm.com>
 <1D564116-5FAC-4775-BEB2-4D5B837080D6@linux.vnet.ibm.com>
 <20210203153148.GC854763@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.737
 definitions=2021-02-04_06:2021-02-04,
 2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040077
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Kajol Jain <kjain@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



> On 03-Feb-2021, at 9:01 PM, Arnaldo Carvalho de Melo <acme@kernel.org> =
wrote:
>=20
> Thanks, collected the Tested-by from Kajol and the Acked-by from Jiri
> and applied to my local tree for testing, then up to my perf/core
> branch.
>=20
> - Arnaldo

Thanks Arnaldo for taking this fix.



