Return-Path: <SRS0=wfc/=E2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B741C2D0E4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2020 16:12:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1451223BE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2020 16:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WoOpPsDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1451223BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cd1m11GFXzDqyk
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Nov 2020 03:12:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=nathanl@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=WoOpPsDa; dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cd1hL1X5fzDqyP
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2020 03:09:21 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0AKG2NfT142190
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2020 11:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=L5s/1MftXIulSMYU/LftwYpfQ8i8TybxAiqtsauZtYc=;
 b=WoOpPsDa5nriioXFRPNeotEbuibqRuQ/fS4olbk3y/Wyc2/nkvwtIJmke8wsI+MNXidd
 uzn7WTDPdCHXCHHyGL70CX7fM4nCnX/KgEGAChr/XxKMJi6BUAhbGTkOwKDVGIiX2PjF
 xvQIaJkQW+VSmVdouLCOaBOMiOfaTLvp9SJoZD529j1VPayNNlJJsFzEBwymGxTCEM2F
 Pfqx3SjRBnbchQi+GClTdkxy534vefr/0Cwbw4oFXUjoVrIa9f/CwIypodbeEuDgjeKt
 S6QxE8wmlrcFySn5X8xprRkoiMaRMwV9WvcmtpyQw/HLbFxNqlMpquXcg+ryoiaeKCvS MQ== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34xghf1fxa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2020 11:09:17 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AKG3VsF013392
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2020 16:09:16 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma05wdc.us.ibm.com with ESMTP id 34t6v9qmya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2020 16:09:16 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0AKG9GCt13763264
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Nov 2020 16:09:16 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36398AE060;
 Fri, 20 Nov 2020 16:09:16 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 122EBAE05C;
 Fri, 20 Nov 2020 16:09:16 +0000 (GMT)
Received: from localhost (unknown [9.80.199.213])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 20 Nov 2020 16:09:15 +0000 (GMT)
From: Nathan Lynch <nathanl@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 29/29] powerpc/pseries/mobility: refactor node lookup
 during DT update
In-Reply-To: <20201030011805.1224603-30-nathanl@linux.ibm.com>
References: <20201030011805.1224603-1-nathanl@linux.ibm.com>
 <20201030011805.1224603-30-nathanl@linux.ibm.com>
Date: Fri, 20 Nov 2020 10:09:15 -0600
Message-ID: <877dqgj9hw.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-20_08:2020-11-20,
 2020-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=3
 mlxlogscore=999 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011200106
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
Cc: tyreld@linux.ibm.com, ajd@linux.ibm.com, mmc@linux.vnet.ibm.com,
 cforno12@linux.vnet.ibm.com, drt@linux.vnet.ibm.com, brking@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nathan Lynch <nathanl@linux.ibm.com> writes:
> In pseries_devicetree_update(), with each call to ibm,update-nodes the
> partition firmware communicates the node to be deleted or updated by
> placing its phandle in the work buffer. Each of delete_dt_node(),
> update_dt_node(), and add_dt_node() have duplicate lookups using the
> phandle value and corresponding refcount management.

...

I noticed that this introduces a reference count imbalance in an error
path:

> -static int add_dt_node(__be32 parent_phandle, __be32 drc_index)
> +static int add_dt_node(struct device_node *parent_dn, __be32 drc_index)
>  {
>  	struct device_node *dn;
> -	struct device_node *parent_dn;
>  	int rc;
>  
> -	parent_dn = of_find_node_by_phandle(be32_to_cpu(parent_phandle));
> -	if (!parent_dn)
> -		return -ENOENT;
> -
>  	dn = dlpar_configure_connector(drc_index, parent_dn);
>  	if (!dn) {
>  		of_node_put(parent_dn);

here:           ^^^

> @@ -251,7 +230,6 @@ static int add_dt_node(__be32 parent_phandle, __be32 drc_index)
>  
>  	pr_debug("added node %pOFfp\n", dn);
>  
> -	of_node_put(parent_dn);
>  	return rc;
>  }

The change correctly removes the of_node_put() from the happy path but
the put in the error branch should have been removed too.
