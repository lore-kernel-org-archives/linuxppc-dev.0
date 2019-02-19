Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147BBC4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 20:05:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73C0521738
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 20:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C0521738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443sCz0VwvzDqKW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 07:05:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=tyreld@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443s9j3bFvzDqH6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 07:03:21 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1JJx5DL055210
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 15:03:18 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qrr1qhc4h-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 15:03:18 -0500
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Tue, 19 Feb 2019 20:03:17 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 19 Feb 2019 20:03:13 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1JK3CQ519005648
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Feb 2019 20:03:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9458AB2068;
 Tue, 19 Feb 2019 20:03:12 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A6FFB2065;
 Tue, 19 Feb 2019 20:03:11 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.80.225.63])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 19 Feb 2019 20:03:11 +0000 (GMT)
Subject: Re: [PATCH] powerpc/pseries: Fix dn reference error in
 dlpar_cpu_remove_by_index
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
References: <cc20c5cc-cf8e-d125-cac9-5d1b938a1d86@linux.vnet.ibm.com>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Tue, 19 Feb 2019 12:03:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cc20c5cc-cf8e-d125-cac9-5d1b938a1d86@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19021920-2213-0000-0000-000003546BFC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010627; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01163442; UDB=6.00607479; IPR=6.00944025; 
 MB=3.00025659; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-19 20:03:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021920-2214-0000-0000-00005D68C804
Message-Id: <a7986146-f09d-6d40-63f9-8e7307fc2609@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-19_13:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902190140
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
Cc: Rob Herring <robh@kernel.org>, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Nathan Lynch <nathanl@linux.vnet.ibm.com>,
 "Juliet M. Kim" <minkim@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 02/19/2019 07:46 AM, Michael Bringmann wrote:
> powerpc/pseries: Fix dn reference error in dlpar_cpu_remove_by_index()
> 
> A reference to the device node of the CPU to be removed is released
> upon successful removal of the associated CPU device.  If the call
> to remove the CPU device fails, dlpar_cpu_remove_by_index() still
> frees the reference and this leads to miscomparisons and/or
> addressing errors later on.
> 
> This problem may be observed when trying to DLPAR 'hot-remove' a CPU
> from a system that has only a single CPU.  The operation will fail
> because there is no other CPU to which the kernel operations may be
> migrated, but the refcount will still be decremented.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> 
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index 97feb6e..9537bb9 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -635,7 +635,8 @@ static int dlpar_cpu_remove_by_index(u32 drc_index)
>  	}
> 
>  	rc = dlpar_cpu_remove(dn, drc_index);
> -	of_node_put(dn);
> +	if (!rc)
> +		of_node_put(dn);
>  	return rc;
>  }
> 

NACK!

The logic here is wrong. Here is the full function.

static int dlpar_cpu_remove_by_index(u32 drc_index)
{
        struct device_node *dn;
        int rc;

        dn = cpu_drc_index_to_dn(drc_index);
        if (!dn) {
                pr_warn("Cannot find CPU (drc index %x) to remove\n",
                        drc_index);
                return -ENODEV;
        }

        rc = dlpar_cpu_remove(dn, drc_index);
        of_node_put(dn);
        return rc;
}

The call to cpu_drc_index_to_dn() returns a device_node with the reference count
incremented. So, regardless of the success or failure of the call to
dlpar_cpu_remove() you need to release that reference.

If there is a reference counting issue it is somewhere else.

-Tyrel

