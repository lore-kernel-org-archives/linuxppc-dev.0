Return-Path: <SRS0=nAOP=6W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2072C38A2A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2020 13:53:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A35F220708
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2020 13:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35F220708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49JWy6090yzDr49
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2020 23:53:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.vnet.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49JWFS45VvzDr0w
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2020 23:21:48 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 048D2DV0054976; Fri, 8 May 2020 09:21:38 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30vtsemp3t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2020 09:21:38 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 048DKffI028238;
 Fri, 8 May 2020 13:21:35 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma04fra.de.ibm.com with ESMTP id 30s0g65exx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2020 13:21:35 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 048DLXTK66716056
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 May 2020 13:21:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64268A405B;
 Fri,  8 May 2020 13:21:33 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5854CA4055;
 Fri,  8 May 2020 13:21:31 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Fri,  8 May 2020 13:21:31 +0000 (GMT)
Date: Fri, 8 May 2020 18:51:30 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Christopher Lameter <cl@linux.com>
Subject: Re: [PATCH v3 1/3] powerpc/numa: Set numa_node for all possible cpus
Message-ID: <20200508132130.GC1961@linux.vnet.ibm.com>
References: <20200501031128.19584-1-srikar@linux.vnet.ibm.com>
 <20200501031128.19584-2-srikar@linux.vnet.ibm.com>
 <alpine.DEB.2.21.2005022254170.28355@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2005022254170.28355@www.lameter.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-08_12:2020-05-08,
 2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080111
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
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Vlastimil Babka <vbabka@suse.cz>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

* Christopher Lameter <cl@linux.com> [2020-05-02 22:55:16]:

> On Fri, 1 May 2020, Srikar Dronamraju wrote:
> 
> > -	for_each_present_cpu(cpu)
> > -		numa_setup_cpu(cpu);
> > +	for_each_possible_cpu(cpu) {
> > +		/*
> > +		 * Powerpc with CONFIG_NUMA always used to have a node 0,
> > +		 * even if it was memoryless or cpuless. For all cpus that
> > +		 * are possible but not present, cpu_to_node() would point
> > +		 * to node 0. To remove a cpuless, memoryless dummy node,
> > +		 * powerpc need to make sure all possible but not present
> > +		 * cpu_to_node are set to a proper node.
> > +		 */
> > +		if (cpu_present(cpu))
> > +			numa_setup_cpu(cpu);
> > +		else
> > +			set_cpu_numa_node(cpu, first_online_node);
> > +	}
> >  }
> 
> 
> Can this be folded into numa_setup_cpu?
> 
> This looks more like numa_setup_cpu needs to change?
> 

We can fold this into numa_setup_cpu().

However till now we were sure that numa_setup_cpu() would be called only for
a present cpu. That assumption will change.
+ (non-consequential) an additional check everytime cpu is hotplugged in.

If Michael Ellerman is okay with the change, I can fold it in.

-- 
Thanks and Regards
Srikar Dronamraju
