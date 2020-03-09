Return-Path: <SRS0=0QC4=42=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D845C10F27
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Mar 2020 10:31:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 052C420828
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Mar 2020 10:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052C420828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48bZJG0ZWnzDr0x
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Mar 2020 21:31:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48bZGY0cv7zDqMK
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Mar 2020 21:29:40 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 029ATaM5023105
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Mar 2020 06:29:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ym7t6ha80-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Mar 2020 06:29:38 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 029ATbgP023184
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Mar 2020 06:29:37 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ym7t6ha33-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2020 06:29:36 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 029APDMs023138;
 Mon, 9 Mar 2020 10:29:20 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma04wdc.us.ibm.com with ESMTP id 2ym386hh6h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2020 10:29:20 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 029ATHco56033702
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2020 10:29:17 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 181986E054;
 Mon,  9 Mar 2020 10:29:17 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 253DD6E04E;
 Mon,  9 Mar 2020 10:29:15 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.204.201.20])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2020 10:29:14 +0000 (GMT)
X-Mailer: emacs 27.0.90 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/8] powerpc/papr_scm: Fetch dimm performance stats from
 PHYP
In-Reply-To: <20200220095805.197229-4-vaibhav@linux.ibm.com>
References: <20200220095805.197229-1-vaibhav@linux.ibm.com>
 <20200220095805.197229-4-vaibhav@linux.ibm.com>
Date: Mon, 09 Mar 2020 15:58:57 +0530
Message-ID: <877dztzus6.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-09_02:2020-03-08,
 2020-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 bulkscore=0 mlxscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090075
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
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
 Michael Ellerman <ellerman@au1.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
 Alastair D'Silva <alastair@au1.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Vaibhav Jain <vaibhav@linux.ibm.com> writes:

> Implement support for fetching dimm performance metrics via
> H_SCM_PERFORMANCE_HEALTH hcall as documented in Ref[1]. The hcall
> returns a structure as described in Ref[1] and defined as newly
> introduced 'struct papr_scm_perf_stats'. The struct has a header
> followed by key-value pairs of performance attributes. The 'key' part
> is a 8-byte char array naming the attribute encoded as a __be64
> integer. This makes the output buffer format for the hcall self
> describing and can be easily interpreted.
>
> This patch implements functionality to fetch these performance stats
> and reporting them via a nvdimm sysfs attribute named
> 'papr_perf_stats'.
>
> A new function drc_pmem_query_stats() is implemented that issues hcall
> H_SCM_PERFORMANCE_HEALTH ,requesting PHYP to store performance stats
> in pre-allocated 'struct papr_scm_perf_stats' buffer. During nvdimm
> initialization in papr_scm_nvdimm_init() this function is called with
> an empty buffer to know the max buffer size needed for issuing the
> H_SCM_PERFORMANCE_HEALTH hcall. The buffer size retrieved is stored in
> newly introduced 'struct papc_scm_priv.len_stat_buffer' for later
> retrival.
>

You are not using this hcall in the series? If so can you drop it from
the series and add it when you want to use hcall returned value.

> [1]: commit 58b278f568f0 ("powerpc: Provide initial documentation for
> PAPR hcalls")
>


-aneesh
