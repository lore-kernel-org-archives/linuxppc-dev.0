Return-Path: <SRS0=Bl8b=VI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A8DC71142
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jul 2019 18:02:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B954520872
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jul 2019 18:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B954520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45l3m62RQ6zDqlh
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jul 2019 04:01:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=nayna@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45l3jx0mQNzDqhm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2019 04:00:04 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6BHwllB026432
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2019 14:00:00 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tp8sjtw89-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2019 14:00:00 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nayna@linux.vnet.ibm.com>;
 Thu, 11 Jul 2019 18:59:59 +0100
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 11 Jul 2019 18:59:57 +0100
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6BHxtwO53543170
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jul 2019 17:59:55 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6EED3136051;
 Thu, 11 Jul 2019 17:59:55 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4506913604F;
 Thu, 11 Jul 2019 17:59:54 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.41.99.131])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 11 Jul 2019 17:59:54 +0000 (GMT)
Subject: Re: [PATCH v2] tpm: tpm_ibm_vtpm: Fix unallocated banks
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 Sachin Sant <sachinp@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.de>
References: <1562458725-15999-1-git-send-email-nayna@linux.ibm.com>
 <586c629b6d3c718f0c1585d77fe175fe007b27b1.camel@linux.intel.com>
 <1562624644.11461.66.camel@linux.ibm.com>
 <20190708224304.GA25838@infradead.org>
 <20190709163827.2u6jeflrhg44q7dy@linux.intel.com>
From: Nayna <nayna@linux.vnet.ibm.com>
Date: Thu, 11 Jul 2019 13:59:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190709163827.2u6jeflrhg44q7dy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19071117-0016-0000-0000-000009CCE165
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011410; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01230730; UDB=6.00648275; IPR=6.01012006; 
 MB=3.00027681; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-11 17:59:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071117-0017-0000-0000-000043F9EA3D
Message-Id: <0b705972-c483-a469-562c-f0d26aaa0471@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-11_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907110197
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
Cc: Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Mimi Zohar <zohar@linux.ibm.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
 George Wilson <gcwilson@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Peter Huewe <peterhuewe@gmx.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Jarkko,


On 07/09/2019 12:38 PM, Jarkko Sakkinen wrote:
> On Mon, Jul 08, 2019 at 03:43:04PM -0700, Christoph Hellwig wrote:
>> On Mon, Jul 08, 2019 at 06:24:04PM -0400, Mimi Zohar wrote:
>>>> static int tpm_get_pcr_allocation(struct tpm_chip *chip)
>>>> {
>>>> 	int rc;
>>>>
>>>> 	rc = (chip->flags & TPM_CHIP_FLAG_TPM2) ?
>>>>       	     tpm2_get_pcr_allocation(chip) :
>>>>       	     tpm1_get_pcr_allocation(chip);
>>>> 	return rc > 0 ? -ENODEV : rc;
>>>> }
>>>>
>>>> This addresses the issue that Stefan also pointed out. You have to
>>>> deal with the TPM error codes.
>>> Hm, in the past I was told by Christoph not to use the ternary
>>> operator.  Have things changed?  Other than removing the comment, the
>>> only other difference is the return.
>> In the end it is a matter of personal preference, but I find the
>> quote version above using the ternary horribly obsfucated.
> I fully agree that the return statement is an obsfucated mess and
> not a good place at all for using ternary operator.

I have posted the v3 version that includes the suggested corrections by 
you and Stefan. Sorry for some delay.

Michal and Sachin, I would appreciate if you can test the v3 version, 
please ?

Thanks & Regards,
      - Nayna

