Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DC7C64EBD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 21:06:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E6E208AE
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 21:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E6E208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PsBZ6py5zF3Hf
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 07:05:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Ps8K33HJzF37g
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 07:04:01 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w92Kx9J5105346
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Oct 2018 17:03:59 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mvdqgn7db-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2018 17:03:58 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Tue, 2 Oct 2018 15:03:58 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 2 Oct 2018 15:03:55 -0600
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w92L3sHi35323998
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 2 Oct 2018 14:03:54 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6DE59BE05D;
 Tue,  2 Oct 2018 15:03:54 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50F0DBE054;
 Tue,  2 Oct 2018 15:03:53 -0600 (MDT)
Received: from oc6857751186.ibm.com (unknown [9.85.193.168])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue,  2 Oct 2018 15:03:52 -0600 (MDT)
Subject: Re: [PATCH v03 3/5] migration/memory: Add hotplug READD_MULTIPLE
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20181001125846.2676.89826.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
 <20181001125952.2676.35168.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Tue, 2 Oct 2018 14:03:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181001125952.2676.35168.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18100221-0016-0000-0000-00000939F90E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009810; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01096950; UDB=6.00567255; IPR=6.00876993; 
 MB=3.00023593; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-02 21:03:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100221-0017-0000-0000-000040903DF2
Message-Id: <460b921e-269b-c7d2-9a31-522a1674faec@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-02_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810020197
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
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>, Juliet Kim <minkim@us.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/01/2018 05:59 AM, Michael Bringmann wrote:
> migration/memory: This patch adds a new pseries hotplug action
> for CPU and memory operations, PSERIES_HP_ELOG_ACTION_READD_MULTIPLE.
> This is a variant of the READD operation which performs the action
> upon multiple instances of the resource at one time.  The operation
> is to be triggered by device-tree analysis of updates by RTAS events
> analyzed by 'migation_store' during post-migration processing.  It
> will be used for memory updates, initially.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/rtas.h |    1 +
>  arch/powerpc/mm/drmem.c         |    1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
> index 71e393c..e510d82 100644
> --- a/arch/powerpc/include/asm/rtas.h
> +++ b/arch/powerpc/include/asm/rtas.h
> @@ -320,6 +320,7 @@ struct pseries_hp_errorlog {
>  #define PSERIES_HP_ELOG_ACTION_ADD	1
>  #define PSERIES_HP_ELOG_ACTION_REMOVE	2
>  #define PSERIES_HP_ELOG_ACTION_READD	3
> +#define PSERIES_HP_ELOG_ACTION_READD_MULTIPLE	4

I'm confused, you have only added a define and not the actual implementation. I really think this should be squashed into your 4th patch where the operation is actually implemented.

> 
>  #define PSERIES_HP_ELOG_ID_DRC_NAME	1
>  #define PSERIES_HP_ELOG_ID_DRC_INDEX	2
> diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
> index fd2cae92..2228586 100644
> --- a/arch/powerpc/mm/drmem.c
> +++ b/arch/powerpc/mm/drmem.c
> @@ -422,6 +422,7 @@ static void init_drmem_v2_lmbs(const __be32 *prop,
> 
>  			lmb->aa_index = dr_cell.aa_index;
>  			lmb->flags = dr_cell.flags;
> +			lmb->internal_flags = 0;

And this should have been squashed into the previous patch where you added the internal_flags field to the lmb struct.

-Tyrel 

>  		}
>  	}
>  }
> 

