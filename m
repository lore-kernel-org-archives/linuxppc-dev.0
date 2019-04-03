Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EF2C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 21:50:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9B82084B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 21:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9B82084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZKWQ2BDSzDqMP
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 08:50:26 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZKTd1KDCzDq9s
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 08:48:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44ZKTc25NTz8sxG
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 08:48:52 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44ZKTc164Fz9sSh; Thu,  4 Apr 2019 08:48:52 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=cclaudio@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44ZKTb4HTcz9sSW
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Apr 2019 08:48:50 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x33LPJir093883
 for <linuxppc-dev@ozlabs.org>; Wed, 3 Apr 2019 17:48:48 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rn3heuxa0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 03 Apr 2019 17:48:48 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cclaudio@linux.ibm.com>;
 Wed, 3 Apr 2019 22:48:47 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
 by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 3 Apr 2019 22:48:43 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x33LmgcQ23855318
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 3 Apr 2019 21:48:42 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72014AE05C;
 Wed,  3 Apr 2019 21:48:42 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C770BAE05F;
 Wed,  3 Apr 2019 21:48:40 +0000 (GMT)
Received: from [9.18.235.111] (unknown [9.18.235.111])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed,  3 Apr 2019 21:48:40 +0000 (GMT)
Subject: Re: [PATCH 0/4] Enabling secure boot on PowerNV systems
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20190402181505.25037-1-cclaudio@linux.ibm.com>
 <87r2aj1ayf.fsf@concordia.ellerman.id.au>
From: Claudio Carvalho <cclaudio@linux.ibm.com>
Date: Wed, 3 Apr 2019 18:48:39 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <87r2aj1ayf.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19040321-0060-0000-0000-00000328157A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010869; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01183908; UDB=6.00619853; IPR=6.00964659; 
 MB=3.00026284; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-03 21:48:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040321-0061-0000-0000-000048D370DC
Message-Id: <3befcee7-0b65-c312-1f14-daa56afeb176@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-03_13:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904030141
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Nayna Jain <nayna@linux.ibm.com>, Matthew Garret <matthew.garret@nebula.com>,
 Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On 4/3/19 10:21 AM, Michael Ellerman wrote:
> Hi Claudio,
>
> Thanks for posting this.
>
> Claudio Carvalho <cclaudio@linux.ibm.com> writes:
>> This patch set is part of a series that implements secure boot on
>> PowerNV systems.
>>
>> In order to verify the OS kernel on PowerNV, secure boot requires X.509
>> certificates trusted by the platform, the secure boot modes, and several
>> other pieces of information. These are stored in secure variables
>> controlled by OPAL, also known as OPAL secure variables.
>>
>> This patch set adds the following features:
>>
>> 1. Enable efivarfs by selecting CONFIG_EFI in the CONFIG_OPAL_SECVAR
>>    introduced in this patch set. With CONFIG_EFIVAR_FS, userspace tools can
>>    be used to manage the secure variables.
>> 2. Add support for OPAL secure variables by overwriting the EFI hooks
>>    (get_variable, get_next_variable, set_variable and query_variable_info)
>>    with OPAL call wrappers. There is probably a better way to add this
>>    support, for example, we are investigating if we could register the
>>    efivar_operations rather than overwriting the EFI hooks. In this patch
>>    set, CONFIG_OPAL_SECVAR selects CONFIG_EFI. If, instead, we registered
>>    efivar_operations, CONFIG_EFIVAR_FS would need to depend on
>>    CONFIG_EFI|| CONFIG_OPAL_SECVAR. Comments or suggestions on the
>>    preferred technique would be greatly appreciated.
> I am *very* reluctant to start selecting CONFIG_EFI on powerpc.
>
> Simply because we don't actually have EFI, and I worry we're going to
> both break assumptions in the EFI code as well as impose requirements on
> the powerpc code that aren't really necessary.

Yes, we agree. We are working on the v2 and it is not going to depend on
CONFIG_EFI. Rather, the IMA arch policies will make the OPAL calls directly.


>
> So I'd definitely prefer we go the route of enabling efivarfs with an
> alternate backend.

Right, I'm investigating how we can do that, but it looks like we should
post that as a separate patchset to avoid delaying upstreaming signature
verification based on the secure boot variables.

Thanks,
Claudio


>
> Better still would be a generic secure variable interface as Matt
> suggests, if the userspace tools can be relatively easily adapted to use
> that interface.
>
> cheers
>

