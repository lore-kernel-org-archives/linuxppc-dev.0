Return-Path: <SRS0=8mJi=B6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C070DC433E1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Aug 2020 20:22:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DCDE207BB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Aug 2020 20:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tgeamce4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DCDE207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BXbfp52bJzDr2l
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 06:22:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=nathanl@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=Tgeamce4; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BXbct73L0zDqZ3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2020 06:20:46 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07KK31Ce059462; Thu, 20 Aug 2020 16:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=9GxF56lo1Xm+Z6UToXb4OXonqaIBpdvHxDaeXu/tsgo=;
 b=Tgeamce4neTCpdNHmqtcCmTCNkAuJ/cdFAcndDnhyTT7eTDdc/Xj4e8q9MBEdxNXVg+V
 O1MTQpzuBbsUxqOzwY38YtvqS56FJOAyVShlWp15p8s4L8XdtwWF+ZaFjEoJlha8ogfl
 61MikKohZ2RKD6gzpaau/fBlXSpf2JCo9oltENglBbS8eXRe9Ui+dEbEa3cGNe9fYar2
 5t7J4uzBpjq9gn3QGuDldkZqnQvQzar2NEjKQYOdSL2zpmhi4bVfjmDCSXqozhOt0NPt
 gyY2vq5ITZ1iYpSdA604i+HyFBhhh2/d41PXrdAsHJPENdc54huNKSqeo7pqe6Jh9+uW bw== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 331prhrf7f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2020 16:20:41 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07KKKban015310;
 Thu, 20 Aug 2020 20:20:40 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma05wdc.us.ibm.com with ESMTP id 3304th6ue4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2020 20:20:40 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07KKKbAp63242562
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Aug 2020 20:20:37 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE175BE051;
 Thu, 20 Aug 2020 20:20:39 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9388CBE04F;
 Thu, 20 Aug 2020 20:20:39 +0000 (GMT)
Received: from localhost (unknown [9.65.248.251])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 20 Aug 2020 20:20:39 +0000 (GMT)
From: Nathan Lynch <nathanl@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v2 3/4] powerpc/memhotplug: Make lmb size 64bit
In-Reply-To: <20200806162329.276534-3-aneesh.kumar@linux.ibm.com>
References: <20200806162329.276534-1-aneesh.kumar@linux.ibm.com>
 <20200806162329.276534-3-aneesh.kumar@linux.ibm.com>
Date: Thu, 20 Aug 2020 15:20:39 -0500
Message-ID: <87pn7lxe5k.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-20_06:2020-08-19,
 2020-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=1
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1015 mlxlogscore=728 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008200160
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
Cc: linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> @@ -322,12 +322,16 @@ static int pseries_remove_mem_node(struct device_node *np)
>  	/*
>  	 * Find the base address and size of the memblock
>  	 */
> -	regs = of_get_property(np, "reg", NULL);
> -	if (!regs)
> +	prop = of_get_property(np, "reg", NULL);
> +	if (!prop)
>  		return ret;
>  
> -	base = be64_to_cpu(*(unsigned long *)regs);
> -	lmb_size = be32_to_cpu(regs[3]);
> +	/*
> +	 * "reg" property represents (addr,size) tuple.
> +	 */
> +	base = of_read_number(prop, mem_addr_cells);
> +	prop += mem_addr_cells;
> +	lmb_size = of_read_number(prop, mem_size_cells);

Would of_n_size_cells() and of_n_addr_cells() work here?
