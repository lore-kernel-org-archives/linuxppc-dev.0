Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF53C00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 11:22:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85DCB2098A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 11:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DCB2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QDCN6fhmzF37g
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 21:22:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=ego@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QD7K1TNczF39S
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 21:19:25 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w93B9v6X127500
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Oct 2018 07:19:23 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mvsgx89uw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Oct 2018 07:19:22 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 3 Oct 2018 05:19:22 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 3 Oct 2018 05:19:18 -0600
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w93BJHDD66322522
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Oct 2018 04:19:17 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 463D213604F;
 Wed,  3 Oct 2018 05:19:17 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC75C136059;
 Wed,  3 Oct 2018 05:19:16 -0600 (MDT)
Received: from sofia.ibm.com (unknown [9.124.35.51])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed,  3 Oct 2018 05:19:16 -0600 (MDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
 id 5C3BB2E4C72; Wed,  3 Oct 2018 16:49:13 +0530 (IST)
Date: Wed, 3 Oct 2018 16:49:13 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v9 0/3] powerpc: Detection and scheduler optimization for
 POWER9 bigcore
References: <1538399802-23582-1-git-send-email-ego@linux.vnet.ibm.com>
 <994106db-7f79-7d22-0d4e-f458bd85bb64@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <994106db-7f79-7d22-0d4e-f458bd85bb64@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18100311-0016-0000-0000-0000093A538C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009814; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01097236; UDB=6.00567426; IPR=6.00877278; 
 MB=3.00023598; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-03 11:19:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100311-0017-0000-0000-00004091F6F9
Message-Id: <20181003111913.GA9055@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-03_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810030112
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
Reply-To: ego@linux.vnet.ibm.com
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Oliver O'Halloran <oohall@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello Dave,

On Mon, Oct 01, 2018 at 07:05:11AM -0700, Dave Hansen wrote:
> On 10/01/2018 06:16 AM, Gautham R. Shenoy wrote:
> > 
> > Patch 3: Creates a pair of sysfs attributes named
> > 	  /sys/devices/system/cpu/cpuN/topology/smallcore_thread_siblings
> > 	  and
> > 	  /sys/devices/system/cpu/cpuN/topology/smallcore_thread_siblings_list
> > 	  exposing the small-core siblings that share the L1 cache
> > 	  to the userspace.
> 
> I really don't think you've justified the existence of a new user/kernel
> interface here.  We already have information about threads share L1
> caches in here:
> 
> 	/sys/devices/system/cpu/cpu0/cache/index0/shared_cpu_list


Hmmm. My bad, I wasn't aware of this sysfs interface. We can use this
to share information about L1 cache. And currently on the upstream
kernel we report incorrect value on POWER9 SMT8 core. I will fix
this. Thanks for calling this out.

> 
> The only question would be if anything would break because it assumes
> that all SMT siblings share all caches.  But, it breaks if your new
> interface is there or not; it's old software that we care about.
>

Up until POWER9 SMT8 cores, this assumption was true that all SMT
siblings share all caches. POWER9 SMT8 cores are the only exception. 

--
Thanks and Regards
gautham.

