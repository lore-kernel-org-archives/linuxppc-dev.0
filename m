Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EEBC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 00:03:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7493B2084D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 00:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7493B2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43J1ZP2q4szDqVM
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 11:03:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=au1.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=andrew.donnellan@au1.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43J1Wp0nhqzDqTn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 11:00:53 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBGNxGJG080675
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Dec 2018 19:00:51 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pdfx5cbf3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Dec 2018 19:00:50 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 17 Dec 2018 00:00:49 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 17 Dec 2018 00:00:46 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBH00j8c55378068
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 17 Dec 2018 00:00:45 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 957D2A4053;
 Mon, 17 Dec 2018 00:00:45 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 40586A4040;
 Mon, 17 Dec 2018 00:00:45 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 17 Dec 2018 00:00:45 +0000 (GMT)
Received: from [10.61.2.125] (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 2680DA0173;
 Mon, 17 Dec 2018 11:00:42 +1100 (AEDT)
Subject: Re: [PATCH] ocxl: Fix endiannes bug in ocxl_link_update_pe()
To: Greg Kurz <groug@kaod.org>, linuxppc-dev@lists.ozlabs.org
References: <154499573000.310603.8247296576061305045.stgit@bahia.lan>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 17 Dec 2018 11:00:42 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
In-Reply-To: <154499573000.310603.8247296576061305045.stgit@bahia.lan>
Content-Language: en-AU
X-TM-AS-GCONF: 00
x-cbid: 18121700-0028-0000-0000-0000032B6D6C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121700-0029-0000-0000-000023E7C1E7
Message-Id: <0a075ae6-07c8-c66b-2c8e-7fd673338e3b@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-16_17:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=905 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812160224
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
Cc: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, stable@vger.kernel.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Alastair D'Silva <alastair@d-silva.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 17/12/18 8:28 am, Greg Kurz wrote:
> All fields in the PE are big-endian. Use cpu_to_be32() like everywhere
> else something is written to the PE. Otherwise a wrong TID will be used
> by the NPU. If this TID happens to point to an existing thread sharing
> the same mm, it could be woken up by error. This is highly improbable
> though. The likely outcome of this is the NPU not finding the target
> thread and forcing the AFU into sending an interrupt, which userspace
> is supposed to handle anyway.
>=20
> Fixes: e948e06fc63a ("ocxl: Expose the thread_id needed for wait on POWER=
9")
> Cc: stable@vger.kernel.org      # v4.18
> Signed-off-by: Greg Kurz <groug@kaod.org>

If only we read our sparse warnings which would have told us this. One=20
warning down :)

Thanks for finding this!

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>=20
> This bug remained unnoticed so far because the current OCXL test suite
> happens to call OCXL_IOCTL_ENABLE_P9_WAIT before attaching a context.
> This causes ocxl_link_update_pe() to be called before ocxl_link_add_pe()
> which re-writes the TID in the PE with the appropriate endianness.
>=20
> I have some patches that change the behavior of the OCXL test suite so th=
at
> it can catch the issue:
>=20
> https://github.com/gkurz/libocxl/commits/wake-host-thread-rework
> ---
>   drivers/misc/ocxl/link.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
> index 31695a078485..646d16450066 100644
> --- a/drivers/misc/ocxl/link.c
> +++ b/drivers/misc/ocxl/link.c
> @@ -566,7 +566,7 @@ int ocxl_link_update_pe(void *link_handle, int pasid,=
 __u16 tid)
>=20=20=20
>   	mutex_lock(&spa->spa_lock);
>=20=20=20
> -	pe->tid =3D tid;
> +	pe->tid =3D cpu_to_be32(tid);
>=20=20=20
>   	/*
>   	 * The barrier makes sure the PE is updated
>=20
>=20

--=20
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

