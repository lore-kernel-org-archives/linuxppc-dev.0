Return-Path: <SRS0=Ik3v=5D=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA71C10DCE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2020 07:39:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6432420768
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2020 07:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6432420768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48j24056wQzDqsv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2020 18:39:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.vnet.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48j1sF4hFKzDqth
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2020 18:30:09 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02I73tHg166788
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2020 03:30:06 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yucv4v7rj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2020 03:30:06 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Wed, 18 Mar 2020 07:30:04 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 18 Mar 2020 07:30:01 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 02I7U0PE34275644
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Mar 2020 07:30:00 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2046152051;
 Wed, 18 Mar 2020 07:30:00 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id F1E0F5205A;
 Wed, 18 Mar 2020 07:29:57 +0000 (GMT)
Date: Wed, 18 Mar 2020 12:59:57 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 2/4] mm/slub: Use mem_node to allocate a new slab
References: <3381CD91-AB3D-4773-BA04-E7A072A63968@linux.vnet.ibm.com>
 <20200317131753.4074-1-srikar@linux.vnet.ibm.com>
 <20200317131753.4074-3-srikar@linux.vnet.ibm.com>
 <ef34b0bb-4dfa-cb0e-1830-9ad59119da5e@suse.cz>
 <20200317134523.GB4334@linux.vnet.ibm.com>
 <3d9629d4-4a6d-d2b5-28b7-58af497671c7@suse.cz>
 <20200317145105.GA27520@linux.vnet.ibm.com>
 <abeaec0d-e9ea-28ce-5b9a-9a6d41ab38c9@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <abeaec0d-e9ea-28ce-5b9a-9a6d41ab38c9@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 20031807-0008-0000-0000-0000035F2E4F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031807-0009-0000-0000-00004A8087CC
Message-Id: <20200318072957.GD4879@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-18_02:2020-03-17,
 2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003180032
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
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>, Michal Hocko <mhocko@kernel.org>,
 linux-mm@kvack.org, Kirill Tkhai <ktkhai@virtuozzo.com>,
 Mel Gorman <mgorman@suse.de>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bharata B Rao <bharata@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Christopher Lameter <cl@linux.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

* Vlastimil Babka <vbabka@suse.cz> [2020-03-17 16:29:21]:

> > If we pass this node 0 (which is memoryless/cpuless) to
> > alloc_pages_node. Please note I am only setting node_numa_mem only
> > for offline nodes. However we could change this to set for all offline and
> > memoryless nodes.
> 
> That would indeed make sense.
> 
> But I guess that alloc_pages would still crash as the result of
> numa_to_mem_node() is not passed down to alloc_pages() without this patch. In
> __alloc_pages_node() we currently have "The node must be valid and online" so
> offline nodes don't have zonelists. Either they get them, or we indeed need
> something like this patch. But in order to not make get_any_partial() dead code,
> the final replacement of invalid node with a valid one should be done in
> alloc_slab_page() I guess?
> 

I am posting v2 with this change.

> >> node_to_mem_node() could be just a shortcut for the first zone's node in the
> >> zonelist, so that fallback follows the topology.

-- 
Thanks and Regards
Srikar Dronamraju

