Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330E7C433F5
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Apr 2022 17:32:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KZlg930HBz3bWG
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Apr 2022 03:32:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LCLzJds+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=LCLzJds+; dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KZlfL3JLRz2ypD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2022 03:31:22 +1000 (AEST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 238FW8ll024139; 
 Fri, 8 Apr 2022 17:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Mz/wMfXsW8ZUB3Zb9nIQWX22qe/zmsQosxnViFKlzKM=;
 b=LCLzJds+CsKdcSaMQJmLIRyOdDNfo3N0djyWqeIhcC4dmmjs1hL/wYMjvpHlmnES6Ees
 M+If5TlF8Eqc619nW+TOuQFBUfW4TLgrPZgJ+H0DEVLf2oRGwXcTmO/i3hwRvbKTYiG2
 eqqz1fVsuvQFwNdvmhVnRmgrF6CHPjuxV6839i60QK2AyNK02YU9+sl24eKQedrxfY9D
 tLSWh0ixfUOtZjDZfWmg1x5/FQYn0VBbYVLpPEqotPdw7RtE3tN/cXGdJjpTUwCSToEC
 C80TzCFrztzQvrNdzp+OYzoanq6GDJorLr9NaZwfZ4bSGMbnPnkMFd7XDNbNeWhRQWgs TQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3faeqqdh6k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Apr 2022 17:31:14 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 238HHTwV028103;
 Fri, 8 Apr 2022 17:31:13 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma06ams.nl.ibm.com with ESMTP id 3f6drhv73n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Apr 2022 17:31:12 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 238HVA1s40239558
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Apr 2022 17:31:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 914C4AE04D;
 Fri,  8 Apr 2022 17:31:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C45D3AE045;
 Fri,  8 Apr 2022 17:31:09 +0000 (GMT)
Received: from sig-9-65-90-167.ibm.com (unknown [9.65.90.167])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri,  8 Apr 2022 17:31:09 +0000 (GMT)
Message-ID: <05e8ec5c0f471b17eeec417285a0691a61377d51.camel@linux.ibm.com>
Subject: Re: [PATCH] powerpc: Mark arch_get_ima_policy() and
 is_ppc_trustedboot_enabled() as __init
From: Mimi Zohar <zohar@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Date: Fri, 08 Apr 2022 13:31:09 -0400
In-Reply-To: <ebfa96c9cdcd48b28c524af0fb4e10bcb5a7acb9.camel@linux.ibm.com>
References: <20220407141520.733735-1-mpe@ellerman.id.au>
 <ebfa96c9cdcd48b28c524af0fb4e10bcb5a7acb9.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 75XcmiX6BDNhMHG7gY4alh0JUOCrtCZC
X-Proofpoint-ORIG-GUID: 75XcmiX6BDNhMHG7gY4alh0JUOCrtCZC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_05,2022-04-08_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=875 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204080087
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
Cc: nayna@linux.ibm.com, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2022-04-08 at 12:05 -0400, Mimi Zohar wrote:
> On Fri, 2022-04-08 at 00:15 +1000, Michael Ellerman wrote:
> > We can mark arch_get_ima_policy() as __init because it's only caller
> > ima_init_arch_policy() is __init. We can then mark
> > is_ppc_trustedboot_enabled() __init because its only caller is
> > arch_get_ima_policy().
> > 
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> I assume you want to upstream this via power,
> 
>     Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Sorry, I just noticed that is_ppc_trustedboot_enabled() is also called
by arch_ima_get_secureboot().

Mimi

