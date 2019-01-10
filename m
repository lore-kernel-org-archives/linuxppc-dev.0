Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B5FC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 23:17:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE854213F2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 23:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE854213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bMN65xtPzDqyG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 10:17:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=tyreld@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bML86pF7zDqwV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 10:15:44 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x0AN93Ho129019
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 18:15:42 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pxa9x4gc1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 18:15:42 -0500
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 10 Jan 2019 23:15:41 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 10 Jan 2019 23:15:38 -0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0ANFbHo20185194
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 10 Jan 2019 23:15:37 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27F77112065;
 Thu, 10 Jan 2019 23:15:37 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F1E7112064;
 Thu, 10 Jan 2019 23:15:36 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.85.156.211])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 10 Jan 2019 23:15:36 +0000 (GMT)
Subject: Re: [PATCH] ibmvscsi: use GFP_ATOMIC with dma_alloc_coherent in
 map_sg_data
To: Christoph Hellwig <hch@infradead.org>
References: <1547089136-20264-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <20190110150703.GA26696@infradead.org>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Thu, 10 Jan 2019 15:15:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190110150703.GA26696@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19011023-2213-0000-0000-0000033A6ED5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010381; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144652; UDB=6.00596015; IPR=6.00924917; 
 MB=3.00025075; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-10 23:15:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011023-2214-0000-0000-00005CEBBE7B
Message-Id: <4c5a470e-fa98-1ffd-7f55-5a4ffb3a692a@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-10_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=591 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901100176
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
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 stable@vger.kernel.org, james.bottomley@hansenpartnership.com,
 brking@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 01/10/2019 07:07 AM, Christoph Hellwig wrote:
> On Wed, Jan 09, 2019 at 06:58:56PM -0800, Tyrel Datwyler wrote:
>> While mapping DMA for scatter list when a scsi command is queued the
>> existing call to dma_alloc_coherent() in our map_sg_data() function
>> passes zero for the gfp_flags parameter. We are most definitly in atomic
>> context at this point as queue_command() is called in softirq context
>> and further we have a spinlock holding the scsi host lock.
>>
>> Fix this by passing GFP_ATOMIC to dma_alloc_coherent() to prevent any
>> sort of sleeping in atomic context deadlock.
> 
> This is a pretty clear sign you should not be using dma_alloc_coherent
> to start with.  GFP_ATOMIC support in many of the implementations either
> doesn't work at all or is severly constrained.  

On a secondary note I was unaware of the GFP_ATOMIC limitations. Should this be
added to the documentation somewhere? I don't see any mention here form
DMA-API-HOWTO.txt.

Using Consistent DMA mappings
=============================

To allocate and map large (PAGE_SIZE or so) consistent DMA regions,
you should do::

        dma_addr_t dma_handle;

        cpu_addr = dma_alloc_coherent(dev, size, &dma_handle, gfp);

where device is a ``struct device *``. This may be called in interrupt
context with the GFP_ATOMIC flag.

-Tyrel

Given that the
> descriptor is written by the OS and read by the hardware exactly once
> there is no point in having the coherent mapping to start with.
> 

