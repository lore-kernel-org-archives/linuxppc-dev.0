Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD12C282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 18:25:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED2C521741
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 18:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED2C521741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pJ3L04SpzDqPM
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 05:25:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pJ1D18TCzDqLp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 05:23:59 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0SIJVk6016025
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 13:23:57 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qa5j24kf3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 13:23:57 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 28 Jan 2019 18:23:56 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
 by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 28 Jan 2019 18:23:54 -0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0SINrxo23658702
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Jan 2019 18:23:53 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F847124052;
 Mon, 28 Jan 2019 18:23:53 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 96955124054;
 Mon, 28 Jan 2019 18:23:52 +0000 (GMT)
Received: from oc8380061452.ibm.com (unknown [9.53.179.224])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 28 Jan 2019 18:23:52 +0000 (GMT)
Subject: Re: [RFC 1/6] powerpc:/drc Define interface to acquire arch-specific
 drc info
To: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20181214204914.16435.59083.stgit@powerkvm6.aus.stglabs.ibm.com>
 <20181214204957.16435.29255.stgit@powerkvm6.aus.stglabs.ibm.com>
 <e7030879-59e4-88fd-3785-fdd98b7f0a3b@gmail.com>
 <63da6cfa-5272-0c78-ae91-0ad1130db3f1@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mwb@linux.vnet.ibm.com; prefer-encrypt=mutual; keydata=
 mQENBFcY7GcBCADzw3en+yzo9ASFGCfldVkIg95SAMPK0myXp2XJYET3zT45uBsX/uj9/2nA
 lBmXXeOSXnPfJ9V3vtiwcfATnWIsVt3tL6n1kqikzH9nXNxZT7MU/7gqzWZngMAWh/GJ9qyg
 DTOZdjsvdUNUWxtiLvBo7y+reA4HjlQhwhYxxvCpXBeRoF0qDWfQ8DkneemqINzDZPwSQ7zY
 t4F5iyN1I9GC5RNK8Y6jiKmm6bDkrrbtXPOtzXKs0J0FqWEIab/u3BDrRP3STDVPdXqViHua
 AjEzthQbGZm0VCxI4a7XjMi99g614/qDcXZCs00GLZ/VYIE8hB9C5Q+l66S60PLjRrxnABEB
 AAG0LU1pY2hhZWwgVy4gQnJpbmdtYW5uIDxtd2JAbGludXgudm5ldC5pYm0uY29tPokBOAQT
 AQIAIgUCVxjsZwIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQSEdag3dpuTI0NAf8
 CKYTDKQLgOSjVrU2L5rM4lXaJRmQV6oidD3vIhKSnWRvPq9C29ifRG6ri20prTHAlc0vycgm
 41HHg0y2vsGgNXGTWC2ObemoZBI7mySXe/7Tq5mD/semGzOp0YWZ7teqrkiSR8Bw0p+LdE7K
 QmT7tpjjvuhrtQ3RRojUYcuy1nWUsc4D+2cxsnZslsx84FUKxPbLagDgZmgBhUw/sUi40s6S
 AkdViVCVS0WANddLIpG0cfdsV0kCae/XdjK3mRK6drFKv1z+QFjvOhc8QIkkxFD0da9w3tJj
 oqnqHFV5gLcHO6/wizPx/NV90y6RngeBORkQiRFWxTXS4Oj9GVI/UrkBDQRXGOxnAQgAmJ5Y
 ikTWrMWPfiveUacETyEhWVl7u8UhZcx3yy2te8O0ay7t9fYcZgIEfQPPVVus89acIXlG3wYL
 DDPvb21OprLxi+ZJ2a0S5we+LcSWN1jByxJlbWBq+/LcMtGAOhNLpysY1gD0Y4UW/eKS+TFZ
 562qKC3k1dBvnV9JXCgeS1taYFxRdVAn+2DwK3nuyG/DDq/XgJ5BtmyC3MMx8CiW3POj+O+l
 6SedIeAfZlZ7/xhijx82g93h07VavUQRwMZgZFsqmuxBxVGiav2HB+dNvs3PFB087Pvc9OHe
 qhajPWOP/gNLMmvBvknn1NToM9a8/E8rzcIZXoYs4RggRRYh6wARAQABiQEfBBgBAgAJBQJX
 GOxnAhsMAAoJEEhHWoN3abky+RUH/jE08/r5QzaNKYeVhu0uVbgXu5fsxqr2cAxhf+KuwT3T
 efhEP2alarxzUZdEh4MsG6c+X2NYLbD3cryiXxVx/7kSAJEFQJfA5P06g8NLR25Qpq9BLsN7
 ++dxQ+CLKzSEb1X24hYAJZpOhS8ev3ii+M/XIo+olDBKuTaTgB6elrg3CaxUsVgLBJ+jbRkW
 yQe2S5f/Ja1ThDpSSLLWLiLK/z7+gaqwhnwjQ8Z8Y9D2itJQcj4itHilwImsqwLG7SxzC0NX
 IQ5KaAFYdRcOgwR8VhhkOIVd70ObSZU+E4pTET1WDz4o65xZ89yfose1No0+r5ht/xWOOrh8
 53/hcWvxHVs=
Organization: IBM Linux Technology Center
Date: Mon, 28 Jan 2019 12:23:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <63da6cfa-5272-0c78-ae91-0ad1130db3f1@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19012818-0040-0000-0000-000004B8BCB2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010494; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01153088; UDB=6.00593882; IPR=6.00933451; 
 MB=3.00025327; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-28 18:23:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012818-0041-0000-0000-000008C3D099
Message-Id: <d881d17c-1157-a6a0-0784-33510a4ee674@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-28_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901280137
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
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, nathanl@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 1/25/19 10:09 AM, Michael Bringmann wrote:
> Adding Nathan Lynch
> 
> On 1/24/19 6:04 PM, Tyrel Datwyler wrote:
>> On 12/14/2018 12:50 PM, Michael Bringmann wrote:
>>> Define interface to acquire arch-specific drc info to match against
>>> hotpluggable devices.  The current implementation exposes several
>>> pseries-specific dynamic memory properties in generic kernel code.
>>> This patch set provides an interface to pull that code out of the
>>> generic kernel.
>>>
>>> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
>>> ---
>>>  include/linux/topology.h |    9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/include/linux/topology.h b/include/linux/topology.h
>>> index cb0775e..df97f5f 100644
>>> --- a/include/linux/topology.h
>>> +++ b/include/linux/topology.h
>>> @@ -44,6 +44,15 @@
>>
>> As far as I know pseries is the only platform that uses DR connectors, and I
>> highly doubt that any other powerpc platform or arch ever will. So, I'm not sure
>> that this is really generic enough to belong in topology.h. If anything I would
>> suggest putting this in an include in arch/powerpc/include/ named something like
>> drcinfo.h or pseries-drc.h. That will make it visible to modules like rpaphp
>> that want/need to use this functionality.

It looks like the 'rpaphp' and 'rpadlpar_io' modules are also dependent upon the
powerpc platform.  Shouldn't the relevant source files be moved completely to the
powerpc-specific directories out of drivers/pci/hotplug as well?

drivers/pci/hotplug/Kconfig has:

config HOTPLUG_PCI_RPA
        tristate "RPA PCI Hotplug driver"
        depends on PPC_PSERIES && EEH
        help
          Say Y here if you have a RPA system that supports PCI Hotplug.

          To compile this driver as a module, choose M here: the
          module will be called rpaphp.

          When in doubt, say N.

config HOTPLUG_PCI_RPA_DLPAR
        tristate "RPA Dynamic Logical Partitioning for I/O slots"
        depends on HOTPLUG_PCI_RPA
        help
          Say Y here if your system supports Dynamic Logical Partitioning
          for I/O slots.

          To compile this driver as a module, choose M here: the
          module will be called rpadlpar_io.

          When in doubt, say N.

Michael

>>
>> -Tyrel
>>
>>>  
>>>  int arch_update_cpu_topology(void);
>>>  
>>> +int arch_find_drc_match(struct device_node *dn,
>>> +			bool (*usercb)(struct device_node *dn,
>>> +				u32 drc_index, char *drc_name,
>>> +				char *drc_type, u32 drc_power_domain,
>>> +				void *data),
>>> +			char *opt_drc_type, char *opt_drc_name,
>>> +			bool match_drc_index, bool ck_php_type,
>>> +			void *data);
>>> +
>>>  /* Conform to ACPI 2.0 SLIT distance definitions */
>>>  #define LOCAL_DISTANCE		10
>>>  #define REMOTE_DISTANCE		20
>>>
>>
>>
> 

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com

