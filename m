Return-Path: <SRS0=jaSx=T4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33AFC04AB6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 May 2019 14:12:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEAAF206E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 May 2019 14:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAAF206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45CwlC3kwrzDqNV
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 May 2019 00:12:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=zohar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45CwhY09XFzDqHj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2019 00:09:47 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x4SE8gZu013405
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 May 2019 10:09:43 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ss5w19uck-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 May 2019 10:09:42 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.ibm.com>;
 Tue, 28 May 2019 15:09:39 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 28 May 2019 15:09:34 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x4SE9XAf34406474
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 May 2019 14:09:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 606A0AE053;
 Tue, 28 May 2019 14:09:33 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4FED4AE051;
 Tue, 28 May 2019 14:09:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.109.224])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 28 May 2019 14:09:31 +0000 (GMT)
Subject: Re: [PATCH v10 12/12] ima: Store the measurement again when
 appraising a modsig
From: Mimi Zohar <zohar@linux.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 linux-integrity@vger.kernel.org
Date: Tue, 28 May 2019 10:09:20 -0400
In-Reply-To: <20190418035120.2354-13-bauerman@linux.ibm.com>
References: <20190418035120.2354-1-bauerman@linux.ibm.com>
 <20190418035120.2354-13-bauerman@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19052814-4275-0000-0000-0000033962A2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052814-4276-0000-0000-000038490AD0
Message-Id: <1559052560.4090.14.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-05-28_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905280092
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-doc@vger.kernel.org,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
 David Howells <dhowells@redhat.com>, "AKASHI,
 Takahiro" <takahiro.akashi@linaro.org>, linux-security-module@vger.kernel.org,
 keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
 Jessica Yu <jeyu@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 David Woodhouse <dwmw2@infradead.org>, "Serge E. Hallyn" <serge@hallyn.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Thiago,

On Thu, 2019-04-18 at 00:51 -0300, Thiago Jung Bauermann wrote:
> If the IMA template contains the "modsig" or "d-modsig" field, then the
> modsig should be added to the measurement list when the file is appraised.
> 
> And that is what normally happens, but if a measurement rule caused a file
> containing a modsig to be measured before a different rule causes it to be
> appraised, the resulting measurement entry will not contain the modsig
> because it is only fetched during appraisal. When the appraisal rule
> triggers, it won't store a new measurement containing the modsig because
> the file was already measured.
> 
> We need to detect that situation and store an additional measurement with
> the modsig. This is done by adding an IMA_MEASURE action flag if we read a
> modsig and the IMA template contains a modsig field.

With the new per policy rule "template" support being added, this
patch needs to be modified so that the per policy "template" format is
checked.  ima_template_has_modsig() should be called with the
template_desc being used.

thanks,

Mimi


> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 8e6475854351..f91ed4189f98 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -282,9 +282,17 @@ static int process_measurement(struct file *file, const struct cred *cred,
>  		/* read 'security.ima' */
>  		xattr_len = ima_read_xattr(file_dentry(file), &xattr_value);
>  
> -		/* Read the appended modsig if allowed by the policy. */
> -		if (iint->flags & IMA_MODSIG_ALLOWED)
> -			ima_read_modsig(func, buf, size, &modsig);
> +		/*
> +		 * Read the appended modsig, if allowed by the policy, and allow
> +		 * an additional measurement list entry, if needed, based on the
> +		 * template format.
> +		 */
> +		if (iint->flags & IMA_MODSIG_ALLOWED) {
> +			rc = ima_read_modsig(func, buf, size, &modsig);
> +
> +			if (!rc && ima_template_has_modsig())
> +				action |= IMA_MEASURE;
> +		}
> 

