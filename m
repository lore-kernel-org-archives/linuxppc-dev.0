Return-Path: <SRS0=3GPV=CK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E660C433E2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2020 15:42:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCCB620866
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2020 15:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CfPe+jOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCB620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BgrtN5FX8zDqZL
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2020 01:42:36 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BgrhL6HLDzDqXf
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2020 01:33:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=CfPe+jOl; dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 4BgrhH3TlCz8tYs
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2020 01:33:51 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 4BgrhG6ncFz9sVk; Wed,  2 Sep 2020 01:33:50 +1000 (AEST)
Authentication-Results: ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=sachinp@linux.vnet.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=linux.vnet.ibm.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=CfPe+jOl; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4BgrhG1rkyz9sVZ;
 Wed,  2 Sep 2020 01:33:48 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 081FXCdg055388; Tue, 1 Sep 2020 11:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=gpV/L2njA62LINCUtALCHUzidqR2WJz0LKEhhTHaX0g=;
 b=CfPe+jOlc25sEvdbxW9K6zsd3Fyr83gTKM5DF8n3cBlLn8NKrSFBOXJNtI4MqPBPyvP2
 ZTjEPDAAYOFGBJryl0GStDhowuaHrQ8+jU/DzxhSVTl9qB1JeQSyO1wa/m2qfHr21n07
 OlqG7PNaXXCGei+0kuNCjt/oeX01APYlgIVNJ9cDOLr/+ltDj16pA6IcFXV9Xlhcqv3n
 F2zIufUyrUWGW0POiXDsSqCorOe2DJyc16p7O7nbjmaGrJMEW6Q62b6UbjxTtoGNTJAy
 xBzF4RMcE6cLktj95FoOSa034/M16CazCNAdXe5GdSlQez9yESa/542Alz/MOmuEgw9Q 2g== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 339qyp2a2d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2020 11:33:45 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 081FRPVe020544;
 Tue, 1 Sep 2020 15:33:43 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma03ams.nl.ibm.com with ESMTP id 337en8bj92-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2020 15:33:43 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 081FXfeL19464470
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Sep 2020 15:33:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19AAF42041;
 Tue,  1 Sep 2020 15:33:41 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9415E4204F;
 Tue,  1 Sep 2020 15:33:40 +0000 (GMT)
Received: from [9.199.52.16] (unknown [9.199.52.16])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  1 Sep 2020 15:33:40 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: [PATCH] selftests/powerpc: Skip PROT_SAO test in guests/LPARS
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <20200901124653.523182-1-mpe@ellerman.id.au>
Date: Tue, 1 Sep 2020 21:03:39 +0530
Content-Transfer-Encoding: quoted-printable
Message-Id: <5E12FA66-4147-46E6-9D8A-358FFAFDC3FB@linux.vnet.ibm.com>
References: <20200901124653.523182-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>
X-Mailer: Apple Mail (2.3445.104.15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-01_10:2020-09-01,
 2020-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1011
 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009010128
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
Cc: linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



> On 01-Sep-2020, at 6:16 PM, Michael Ellerman <mpe@ellerman.id.au> =
wrote:
>=20
> In commit 9b725a90a8f1 ("powerpc/64s: Disallow PROT_SAO in LPARs by
> default") PROT_SAO was disabled in guests/LPARs by default. So skip
> the test if we are running in a guest to avoid a spurious failure.
>=20
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> =E2=80=94

Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>

With the fix test is skipped while running in a guest

# ./prot_sao=20
test: prot-sao
tags: git_version:unknown
[SKIP] Test skipped on line 25
skip: prot-sao
#

