Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB40CC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 18:31:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F13DA2075B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 18:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13DA2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VjN56XvYzF1PQ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 05:31:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VjKz4MwFzF0ym
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 05:29:11 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9AIP5CD082794
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 14:29:08 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2n1kccrnwj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 14:29:08 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 10 Oct 2018 12:29:07 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 10 Oct 2018 12:29:05 -0600
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9AIT4dH40960100
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 10 Oct 2018 11:29:04 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03A8B6A04F;
 Wed, 10 Oct 2018 12:29:04 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 317646A047;
 Wed, 10 Oct 2018 12:29:03 -0600 (MDT)
Received: from oc5000245537.ibm.com (unknown [9.85.239.181])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 10 Oct 2018 12:29:02 -0600 (MDT)
Subject: Re: [PATCH v04 3/4] migration/memory: Evaluate LMB assoc changes
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20181009203520.26091.86781.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
 <20181009203651.26091.63890.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
 <a554b6b4-35fe-c830-98d1-ade9042f05a3@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mwb@linux.vnet.ibm.com; prefer-encrypt=mutual; keydata=
 xsBNBFcY7GcBCADzw3en+yzo9ASFGCfldVkIg95SAMPK0myXp2XJYET3zT45uBsX/uj9/2nA
 lBmXXeOSXnPfJ9V3vtiwcfATnWIsVt3tL6n1kqikzH9nXNxZT7MU/7gqzWZngMAWh/GJ9qyg
 DTOZdjsvdUNUWxtiLvBo7y+reA4HjlQhwhYxxvCpXBeRoF0qDWfQ8DkneemqINzDZPwSQ7zY
 t4F5iyN1I9GC5RNK8Y6jiKmm6bDkrrbtXPOtzXKs0J0FqWEIab/u3BDrRP3STDVPdXqViHua
 AjEzthQbGZm0VCxI4a7XjMi99g614/qDcXZCs00GLZ/VYIE8hB9C5Q+l66S60PLjRrxnABEB
 AAHNLU1pY2hhZWwgVy4gQnJpbmdtYW5uIDxtd2JAbGludXgudm5ldC5pYm0uY29tPsLAeAQT
 AQIAIgUCVxjsZwIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQSEdag3dpuTI0NAf8
 CKYTDKQLgOSjVrU2L5rM4lXaJRmQV6oidD3vIhKSnWRvPq9C29ifRG6ri20prTHAlc0vycgm
 41HHg0y2vsGgNXGTWC2ObemoZBI7mySXe/7Tq5mD/semGzOp0YWZ7teqrkiSR8Bw0p+LdE7K
 QmT7tpjjvuhrtQ3RRojUYcuy1nWUsc4D+2cxsnZslsx84FUKxPbLagDgZmgBhUw/sUi40s6S
 AkdViVCVS0WANddLIpG0cfdsV0kCae/XdjK3mRK6drFKv1z+QFjvOhc8QIkkxFD0da9w3tJj
 oqnqHFV5gLcHO6/wizPx/NV90y6RngeBORkQiRFWxTXS4Oj9GVI/Us7ATQRXGOxnAQgAmJ5Y
 ikTWrMWPfiveUacETyEhWVl7u8UhZcx3yy2te8O0ay7t9fYcZgIEfQPPVVus89acIXlG3wYL
 DDPvb21OprLxi+ZJ2a0S5we+LcSWN1jByxJlbWBq+/LcMtGAOhNLpysY1gD0Y4UW/eKS+TFZ
 562qKC3k1dBvnV9JXCgeS1taYFxRdVAn+2DwK3nuyG/DDq/XgJ5BtmyC3MMx8CiW3POj+O+l
 6SedIeAfZlZ7/xhijx82g93h07VavUQRwMZgZFsqmuxBxVGiav2HB+dNvs3PFB087Pvc9OHe
 qhajPWOP/gNLMmvBvknn1NToM9a8/E8rzcIZXoYs4RggRRYh6wARAQABwsBfBBgBAgAJBQJX
 GOxnAhsMAAoJEEhHWoN3abky+RUH/jE08/r5QzaNKYeVhu0uVbgXu5fsxqr2cAxhf+KuwT3T
 efhEP2alarxzUZdEh4MsG6c+X2NYLbD3cryiXxVx/7kSAJEFQJfA5P06g8NLR25Qpq9BLsN7
 ++dxQ+CLKzSEb1X24hYAJZpOhS8ev3ii+M/XIo+olDBKuTaTgB6elrg3CaxUsVgLBJ+jbRkW
 yQe2S5f/Ja1ThDpSSLLWLiLK/z7+gaqwhnwjQ8Z8Y9D2itJQcj4itHilwImsqwLG7SxzC0NX
 IQ5KaAFYdRcOgwR8VhhkOIVd70ObSZU+E4pTET1WDz4o65xZ89yfose1No0+r5ht/xWOOrh8
 53/hcWvxHVs=
Organization: IBM Linux Technology Center
Date: Wed, 10 Oct 2018 13:29:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a554b6b4-35fe-c830-98d1-ade9042f05a3@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18101018-0016-0000-0000-0000093F2656
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009855; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01100731; UDB=6.00569528; IPR=6.00880779; 
 MB=3.00023699; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-10 18:29:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101018-0017-0000-0000-000040A80CE5
Message-Id: <d6476e5f-83ab-4be8-5d18-1e3b3ed155a9@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-10_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810100172
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
Cc: Juliet Kim <minkim@us.ibm.com>, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/10/2018 12:24 PM, Nathan Fontenot wrote:
> On 10/09/2018 03:37 PM, Michael Bringmann wrote:

>
>> +static void pseries_update_ala_memory_aai(int aa_index)
>> +{
>> +	struct drmem_lmb *lmb;
>> +
>> +	/* Readd all LMBs which were previously using the
>> +	 * specified aa_index value.
>> +	 */
>> +	for_each_drmem_lmb(lmb) {
>> +		if ((lmb->aa_index == aa_index) &&
>> +			(lmb->flags & DRCONF_MEM_ASSIGNED)) {
>> +			drmem_mark_lmb_update(lmb);
>> +			dlpar_memory_pmt_changes_set();
>> +		}
>> +	}
>> +}
>> +
>> +struct assoc_arrays {
>> +	u32 n_arrays;
>> +	u32 array_sz;
>> +	const __be32 *arrays;
>> +};
> 
> This struct is also defined in arch/powerpc/mm/numa.c. May be a good idea to move the
> definition to common place.

Moving to topology.h in arch/powerpc/include/asm.

> 
>> +
>> +static int pseries_update_ala_memory(struct of_reconfig_data *pr)
>> +{
>> +	struct assoc_arrays new_ala, old_ala;
>> +	__be32 *p;
>> +	int i, lim;
>> +
>> +	if (rtas_hp_event)
>> +		return 0;
>> +
>> +	/*
>> +	 * The layout of the ibm,associativity-lookup-arrays
>> +	 * property is a number N indicating the number of
>> +	 * associativity arrays, followed by a number M
>> +	 * indicating the size of each associativity array,
>> +	 * followed by a list of N associativity arrays.
>> +	 */
>> +
>> +	p = (__be32 *) pr->old_prop->value;
>> +	if (!p)
>> +		return -EINVAL;
>> +	old_ala.n_arrays = of_read_number(p++, 1);
>> +	old_ala.array_sz = of_read_number(p++, 1);
>> +	old_ala.arrays = p;
>> +
>> +	p = (__be32 *) pr->prop->value;
>> +	if (!p)
>> +		return -EINVAL;
>> +	new_ala.n_arrays = of_read_number(p++, 1);
>> +	new_ala.array_sz = of_read_number(p++, 1);
>> +	new_ala.arrays = p;
>> +
>> +	lim = (new_ala.n_arrays > old_ala.n_arrays) ? old_ala.n_arrays :
>> +			new_ala.n_arrays;
>> +
>> +	if (old_ala.array_sz == new_ala.array_sz) {
>> +
>> +		/* Reset any entries where the old and new rows
>> +		 * the array have changed.
> 
> Small nit, the wording in that comment could be clearer.

Right.

> 
> -Nathan

Michael

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com

