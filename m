Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F302AC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 00:41:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 363AD2084A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 00:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363AD2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43J2Q64JG1zDqht
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 11:41:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=au1.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43J2Mr6RBFzDqbp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 11:39:01 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBH0Xlsf024307
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Dec 2018 19:38:58 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2pdfcqny2y-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Dec 2018 19:38:58 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Mon, 17 Dec 2018 00:38:57 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 17 Dec 2018 00:38:55 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBH0cspU40173588
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 17 Dec 2018 00:38:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F0EA711C04C;
 Mon, 17 Dec 2018 00:38:53 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 993FC11C04A;
 Mon, 17 Dec 2018 00:38:53 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 17 Dec 2018 00:38:53 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 41F1BA0190;
 Mon, 17 Dec 2018 11:38:52 +1100 (AEDT)
Subject: Re: [PATCH] ocxl: Fix endiannes bug in ocxl_link_update_pe()
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Greg Kurz <groug@kaod.org>, linuxppc-dev@lists.ozlabs.org
Date: Mon, 17 Dec 2018 11:38:51 +1100
In-Reply-To: <154499573000.310603.8247296576061305045.stgit@bahia.lan>
References: <154499573000.310603.8247296576061305045.stgit@bahia.lan>
Organization: IBM Australia
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
X-TM-AS-GCONF: 00
x-cbid: 18121700-0016-0000-0000-0000023769FF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121700-0017-0000-0000-0000328FB04C
Message-Id: <facf5e15f5791dd8ddf92d25aee0d2c0a0cdda95.camel@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-16_18:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=946 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812170004
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
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 2018-12-16 at 22:28 +0100, Greg Kurz wrote:
> All fields in the PE are big-endian. Use cpu_to_be32() like
> everywhere
> else something is written to the PE. Otherwise a wrong TID will be
> used
> by the NPU. If this TID happens to point to an existing thread
> sharing
> the same mm, it could be woken up by error. This is highly improbable
> though. The likely outcome of this is the NPU not finding the target
> thread and forcing the AFU into sending an interrupt, which userspace
> is supposed to handle anyway.
>=20
> Fixes: e948e06fc63a ("ocxl: Expose the thread_id needed for wait on
> POWER9")
> Cc: stable@vger.kernel.org      # v4.18
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>=20
> This bug remained unnoticed so far because the current OCXL test
> suite
> happens to call OCXL_IOCTL_ENABLE_P9_WAIT before attaching a context.
> This causes ocxl_link_update_pe() to be called before
> ocxl_link_add_pe()
> which re-writes the TID in the PE with the appropriate endianness.
>=20
> I have some patches that change the behavior of the OCXL test suite
> so that
> it can catch the issue:
>=20
> https://github.com/gkurz/libocxl/commits/wake-host-thread-rework
> ---
>  drivers/misc/ocxl/link.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
> index 31695a078485..646d16450066 100644
> --- a/drivers/misc/ocxl/link.c
> +++ b/drivers/misc/ocxl/link.c
> @@ -566,7 +566,7 @@ int ocxl_link_update_pe(void *link_handle, int
> pasid, __u16 tid)
>=20=20
>  	mutex_lock(&spa->spa_lock);
>=20=20
> -	pe->tid =3D tid;
> +	pe->tid =3D cpu_to_be32(tid);
>=20=20
>  	/*
>  	 * The barrier makes sure the PE is updated
>=20

Good catch, thanks.

Reviewed-by: Alastair D'Silva <alastair@d-silva.org>

--=20
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819

