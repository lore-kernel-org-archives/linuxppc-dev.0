Return-Path: <SRS0=uIst=63=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B83C2D0F9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2020 07:48:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7CD0206F5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2020 07:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7CD0206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49MRcg65JszDqs2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2020 17:48:35 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 49MRZG32txzDqMp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2020 17:46:29 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04D7VvTK109329; Wed, 13 May 2020 03:46:20 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3101kxh48u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 May 2020 03:46:20 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04D7Y1Q4128184;
 Wed, 13 May 2020 03:46:20 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3101kxh48c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 May 2020 03:46:20 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04D7jDdU024666;
 Wed, 13 May 2020 07:46:18 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma03fra.de.ibm.com with ESMTP id 3100ub0ekd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 May 2020 07:46:18 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04D7kGQl590302
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 May 2020 07:46:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC412AE04D;
 Wed, 13 May 2020 07:46:15 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 82408AE051;
 Wed, 13 May 2020 07:46:13 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Wed, 13 May 2020 07:46:13 +0000 (GMT)
Date: Wed, 13 May 2020 13:16:12 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Christopher Lameter <cl@linux.com>
Subject: Re: [PATCH v4 3/3] mm/page_alloc: Keep memoryless cpuless node 0
 offline
Message-ID: <20200513074612.GA22908@linux.vnet.ibm.com>
References: <20200512132937.19295-1-srikar@linux.vnet.ibm.com>
 <20200512132937.19295-4-srikar@linux.vnet.ibm.com>
 <alpine.DEB.2.22.394.2005121627340.98180@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2005121627340.98180@www.lameter.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-13_02:2020-05-11,
 2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 cotscore=-2147483648 phishscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005130065
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
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>, Michal Hocko <mhocko@suse.com>,
 David Hildenbrand <david@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
 Mel Gorman <mgorman@suse.de>, "Kirill A. Shutemov" <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Vlastimil Babka <vbabka@suse.cz>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

* Christopher Lameter <cl@linux.com> [2020-05-12 16:31:26]:

> On Tue, 12 May 2020, Srikar Dronamraju wrote:
> 
> > +#ifdef CONFIG_NUMA
> > +	[N_ONLINE] = NODE_MASK_NONE,
> 
> Again. Same issue as before. If you do this then you do a global change
> for all architectures. You need to put something in the early boot
> sequence (in a non architecture specific way) that sets the first node
> online by default.
> 

I did respond to that earlier.

> You have fixed the issue in your earlier patches for the powerpc
> archicture. What about the other architectures?
> 
> Or did I miss something?
> 

Here are my assumptions, please do correct me if any of them are wrong.
1. My other patches for Powerpc, don't change when the nodes are being
onlined. They only change how the cpu_to_node numbering of the offline cpus.
In this respect Powerpc due to its PAPR compliance may be slightly unique
from other archs where the cpu binding of the node is not known till CPUs
are onlined.

2. Currently the nodes are onlined (in all arch specific code) as soon as
they are detected. This is unconditional onlining as in there are no checks
to see the node number is 0. i.e I don't see any special checks that
restrict or allow node 0 from being onlined / offlined. Its considered no
special than any other online node.

3. If we were to expect node 0 to be always online, then why do we have
first_online_node. We could always hard code it to 0.

4. I tried enabling CONFIG_MEMORYLESS_NODE on x86, but that's seems to be
not possible. And it looks to me that something like that is only possible
on powerpc and IA64.

5. Without my patch on a regular numa system, node 0 would be onlined by
default during structure initialization. When the nodes get detected, node 0
and other nodes would again be onlined. The only drawback being if node 0
wasn't suppose to be online, it will still end up being marked online.
With the proposed patch, when the nodes get detected, any nodes detected
would be onlined.

I think the node onlining is already pretty early in boot. I don't know of
any other mechanism to move the onlining further up and in a non
architecture specific way. However if you have ideas, please do let me know.

-- 
Thanks and Regards
Srikar Dronamraju
