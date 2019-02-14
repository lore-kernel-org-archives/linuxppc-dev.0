Return-Path: <SRS0=RHZ4=QV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CE3C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 04:25:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3855222A4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 04:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3855222A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440Nbk59XXzDqVq
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 15:25:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440NZ24Q3HzDqV5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 15:23:54 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1E4NT9e115946
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 23:23:51 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qmvxgsbdh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 23:23:51 -0500
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Thu, 14 Feb 2019 04:23:51 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
 by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 14 Feb 2019 04:23:47 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1E4NkSD23592984
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Feb 2019 04:23:46 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9979FB2065;
 Thu, 14 Feb 2019 04:23:46 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1AC99B205F;
 Thu, 14 Feb 2019 04:23:45 +0000 (GMT)
Received: from [9.199.48.88] (unknown [9.199.48.88])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 14 Feb 2019 04:23:44 +0000 (GMT)
Subject: Re: [PATCH v3 2/2] drivers/mtd: Fix device registration error
To: Boris Brezillon <boris.brezillon@collabora.com>
References: <20190211133338.30399-1-aneesh.kumar@linux.ibm.com>
 <20190211133338.30399-2-aneesh.kumar@linux.ibm.com>
 <20190213142833.2b2999fd@collabora.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Thu, 14 Feb 2019 09:53:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190213142833.2b2999fd@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19021404-0072-0000-0000-000003F9C2EC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010592; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01160759; UDB=6.00605854; IPR=6.00941315; 
 MB=3.00025572; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-14 04:23:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021404-0073-0000-0000-00004B2CDC83
Message-Id: <62e6e593-0a39-0210-d114-5b76e9acee3d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-14_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902140030
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
Cc: linuxppc-dev@lists.ozlabs.org, Alban Bedel <albeu@free.fr>,
 linux-mtd@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2/13/19 6:58 PM, Boris Brezillon wrote:
> Subject prefix should be "mtd: powernv_flash: "
> 
> On Mon, 11 Feb 2019 19:03:38 +0530
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
> 
>> This change helps me to get multiple mtd device registered. Without this
>> I get
>>
>> sysfs: cannot create duplicate filename '/bus/nvmem/devices/flash0'
>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc2-00557-g1ef20ef21f22 #13
>> Call Trace:
>> [c0000000b38e3220] [c000000000b58fe4] dump_stack+0xe8/0x164 (unreliable)
>> [c0000000b38e3270] [c0000000004cf074] sysfs_warn_dup+0x84/0xb0
>> [c0000000b38e32f0] [c0000000004cf6c4] sysfs_do_create_link_sd.isra.0+0x114/0x150
>> [c0000000b38e3340] [c000000000726a84] bus_add_device+0x94/0x1e0
>> [c0000000b38e33c0] [c0000000007218f0] device_add+0x4d0/0x830
>> [c0000000b38e3480] [c0000000009d54a8] nvmem_register.part.2+0x1c8/0xb30
>> [c0000000b38e3560] [c000000000834530] mtd_nvmem_add+0x90/0x120
>> [c0000000b38e3650] [c000000000835bc8] add_mtd_device+0x198/0x4e0
>> [c0000000b38e36f0] [c00000000083619c] mtd_device_parse_register+0x11c/0x280
>> [c0000000b38e3780] [c000000000840830] powernv_flash_probe+0x180/0x250
>> [c0000000b38e3820] [c00000000072c120] platform_drv_probe+0x60/0xf0
>> [c0000000b38e38a0] [c0000000007283c8] really_probe+0x138/0x4d0
>> [c0000000b38e3930] [c000000000728acc] driver_probe_device+0x13c/0x1b0
>> [c0000000b38e39b0] [c000000000728c7c] __driver_attach+0x13c/0x1c0
>> [c0000000b38e3a30] [c000000000725130] bus_for_each_dev+0xa0/0x120
>> [c0000000b38e3a90] [c000000000727b2c] driver_attach+0x2c/0x40
>> [c0000000b38e3ab0] [c0000000007270f8] bus_add_driver+0x228/0x360
>> [c0000000b38e3b40] [c00000000072a2e0] driver_register+0x90/0x1a0
>> [c0000000b38e3bb0] [c00000000072c020] __platform_driver_register+0x50/0x70
>> [c0000000b38e3bd0] [c00000000105c984] powernv_flash_driver_init+0x24/0x38
>> [c0000000b38e3bf0] [c000000000010904] do_one_initcall+0x84/0x464
>> [c0000000b38e3cd0] [c000000001004548] kernel_init_freeable+0x530/0x634
>> [c0000000b38e3db0] [c000000000011154] kernel_init+0x1c/0x168
>> [c0000000b38e3e20] [c00000000000bed4] ret_from_kernel_thread+0x5c/0x68
>> mtd mtd1: Failed to register NVMEM device
>>
>> With the change we now have
>>
>> root@(none):/sys/bus/nvmem/devices# ls -al
>> total 0
>> drwxr-xr-x 2 root root 0 Feb  6 20:49 .
>> drwxr-xr-x 4 root root 0 Feb  6 20:49 ..
>> lrwxrwxrwx 1 root root 0 Feb  6 20:49 flash@0 -> ../../../devices/platform/ibm,opal:flash@0/mtd/mtd0/flash@0
>> lrwxrwxrwx 1 root root 0 Feb  6 20:49 flash@1 -> ../../../devices/platform/ibm,opal:flash@1/mtd/mtd1/flash@1
>>
>> Fixes: acfe63ec1c59 ("mtd: Convert to using %pOFn instead of device_node.name")
> 
> Actually it's not this commit that is at fault as mtd->name was already
> given the value of device_node->name before that. I think you're
> actually fixing 1cbb4a1c433a ("mtd: powernv: Add powernv flash MTD
> abstraction driver").
> 
> No need to send a new version, I can fix that when applying, just let
> me know if you're okay with the changes I suggested.
> 

The suggested changes looks good.

Thanks
-aneesh

