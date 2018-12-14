Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E939C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 21:59:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B04C22080F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 21:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04C22080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Gkwb1kNmzDrF2
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Dec 2018 08:59:27 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Gksc08ZDzDqdn
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Dec 2018 08:56:51 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBELsBMC066694
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 16:56:49 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2pckg239cw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 16:56:49 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Fri, 14 Dec 2018 21:56:48 -0000
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
 by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 14 Dec 2018 21:56:46 -0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBELujJS23330998
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Dec 2018 21:56:45 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1DA387805C;
 Fri, 14 Dec 2018 21:56:45 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7FB7C7805E;
 Fri, 14 Dec 2018 21:56:43 +0000 (GMT)
Received: from oc5000245537.ibm.com (unknown [9.80.196.120])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 14 Dec 2018 21:56:43 +0000 (GMT)
Subject: Re: [PATCH 2/2] of: __of_detach_node() - remove node from phandle
 cache
To: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
References: <1544769771-5468-1-git-send-email-frowand.list@gmail.com>
 <1544769771-5468-3-git-send-email-frowand.list@gmail.com>
 <CAL_JsqJN69kbLX=Fn-hYh1FwWoU-S+sB7wHjG-9H5=ihbo3hcg@mail.gmail.com>
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
Date: Fri, 14 Dec 2018 15:56:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJN69kbLX=Fn-hYh1FwWoU-S+sB7wHjG-9H5=ihbo3hcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18121421-8235-0000-0000-00000E38DF0C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010226; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000271; SDB=6.01131826; UDB=6.00588239; IPR=6.00911957; 
 MB=3.00024694; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-14 21:56:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121421-8236-0000-0000-000043B59D96
Message-Id: <68a9e834-b11d-8b9f-1669-466709257f37@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-14_13:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812140186
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
Cc: devicetree@vger.kernel.org, tlfalcon@linux.vnet.ibm.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 minkim@us.ibm.com, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12/14/2018 11:20 AM, Rob Herring wrote:
> On Fri, Dec 14, 2018 at 12:43 AM <frowand.list@gmail.com> wrote:
>>
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Non-overlay dynamic devicetree node removal may leave the node in
>> the phandle cache.  Subsequent calls to of_find_node_by_phandle()
>> will incorrectly find the stale entry.  Remove the node from the
>> cache.
>>
>> Add paranoia checks in of_find_node_by_phandle() as a second level
>> of defense (do not return cached node if detached, do not add node
>> to cache if detached).
>>
>> Reported-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>  drivers/of/base.c       | 29 ++++++++++++++++++++++++++++-
>>  drivers/of/dynamic.c    |  3 +++
>>  drivers/of/of_private.h |  4 ++++
>>  3 files changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index d599367cb92a..34a5125713c8 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -162,6 +162,27 @@ int of_free_phandle_cache(void)
>>  late_initcall_sync(of_free_phandle_cache);
>>  #endif
>>
>> +/*
>> + * Caller must hold devtree_lock.
>> + */
>> +void __of_free_phandle_cache_entry(phandle handle)
>> +{
>> +       phandle masked_handle;
>> +
>> +       if (!handle)
>> +               return;
>> +
>> +       masked_handle = handle & phandle_cache_mask;
>> +
>> +       if (phandle_cache) {
>> +               if (phandle_cache[masked_handle] &&
>> +                   handle == phandle_cache[masked_handle]->phandle) {
>> +                       of_node_put(phandle_cache[masked_handle]);
>> +                       phandle_cache[masked_handle] = NULL;
>> +               }
>> +       }
>> +}
>> +
>>  void of_populate_phandle_cache(void)
>>  {
>>         unsigned long flags;
>> @@ -1209,11 +1230,17 @@ struct device_node *of_find_node_by_phandle(phandle handle)
>>                 if (phandle_cache[masked_handle] &&
>>                     handle == phandle_cache[masked_handle]->phandle)
>>                         np = phandle_cache[masked_handle];
>> +               if (np && of_node_check_flag(np, OF_DETACHED)) {
>> +                       of_node_put(np);
>> +                       phandle_cache[masked_handle] = NULL;
> 
> This should never happen, right? Any time we set OF_DETACHED, the
> entry should get removed from the cache. I think we want a WARN here
> in case we're in an unexpected state.

We don't actually remove the pointer from the phandle cache when we set
OF_DETACHED in drivers/of/dynamic.c:__of_detach_node.  The phandle cache
is currently static within drivers/of/base.c.  There are a couple of
calls to of_populate_phandle_cache / of_free_phandle_cache within
drivers/of/overlay.c, but these are not involved in the device tree
updates that occur during LPAR migration.  A WARN here would only make
sense, if we also arrange to clear the handle.

> 
> Rob

Michael

> 
> 

-- 
Michael W. Bringmann
Linux I/O, Networking and Security Development
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com

