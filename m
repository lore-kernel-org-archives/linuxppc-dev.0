Return-Path: <SRS0=+31F=RA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B07C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 23:22:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D783020C01
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 23:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D783020C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447dJG2fy4zDqKs
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 10:22:06 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 447dGC5x09zDqLP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 10:20:19 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1PNJG1u030396
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 18:20:16 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qvqsu5h1j-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 18:20:16 -0500
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Mon, 25 Feb 2019 23:20:14 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 25 Feb 2019 23:20:12 -0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1PNKBE018481266
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Feb 2019 23:20:11 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 612C9112067;
 Mon, 25 Feb 2019 23:20:11 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5BA6112061;
 Mon, 25 Feb 2019 23:20:10 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.80.233.229])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 25 Feb 2019 23:20:10 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] arch: powerpc/kexec: Add missing of_node-put() in
 default_machine_kexec_prepare()
To: Himadri Pandya <himadri18.07@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
References: <20190224080209.15969-1-himadri18.07@gmail.com>
 <20190225090056.19055-1-himadri18.07@gmail.com>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Mon, 25 Feb 2019 15:20:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190225090056.19055-1-himadri18.07@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19022523-2213-0000-0000-00000358D835
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010664; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01166360; UDB=6.00609243; IPR=6.00946963; 
 MB=3.00025740; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-25 23:20:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022523-2214-0000-0000-00005D7AFB67
Message-Id: <3b7ddc53-dc33-54e5-0826-9147b27ab02b@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-25_13:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902250161
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 02/25/2019 01:00 AM, Himadri Pandya wrote:
> Decrement the reference count on device_node "node" while breaking out
> of the loop. Issue identified by Coccinelle.
> 
> Signed-off-by: Himadri Pandya <himadri18.07@gmail.com>
> ---
> Changes in V2:
> 	- Change subject line
> ---
>  arch/powerpc/kernel/machine_kexec_64.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
> index a0f6f45005bd..46edde582984 100644
> --- a/arch/powerpc/kernel/machine_kexec_64.c
> +++ b/arch/powerpc/kernel/machine_kexec_64.c
> @@ -65,6 +65,7 @@ int default_machine_kexec_prepare(struct kimage *image)
>  			end = begin + image->segment[i].memsz;
> 
>  			if ((begin < high) && (end > low))
> +				of_node_put(node);
>  				return -ETXTBSY;

I think the kbuild robot already caught this, but you need to add { } block
around this if now. Previously it was a one line statement, but adding the
of_node_put() makes it multiple lines that now require { }.

-Tyrel

>  		}
>  	}
> 

