Return-Path: <SRS0=nVWd=XH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E303C4CEC6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Sep 2019 16:44:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF7202084D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Sep 2019 16:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7202084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Tl3J66XNzF4k9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Sep 2019 02:44:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=nathanl@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Tl1C3HWzzF4bm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Sep 2019 02:42:23 +1000 (AEST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8CGfukm182988; Thu, 12 Sep 2019 12:42:16 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uyp18yk99-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2019 12:42:15 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8CGg6YK183365;
 Thu, 12 Sep 2019 12:42:10 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uyp18yk4y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2019 12:42:10 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8CGeK9c010572;
 Thu, 12 Sep 2019 16:41:59 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma04dal.us.ibm.com with ESMTP id 2uyqd8sdkw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2019 16:41:59 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8CGfwI158720524
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Sep 2019 16:41:58 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A8107805C;
 Thu, 12 Sep 2019 16:41:58 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F95B78060;
 Thu, 12 Sep 2019 16:41:58 +0000 (GMT)
Received: from localhost (unknown [9.41.101.192])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 12 Sep 2019 16:41:58 +0000 (GMT)
From: Nathan Lynch <nathanl@linux.ibm.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 3/5] powerpc/numa: Use cpu node map of first sibling
 thread
In-Reply-To: <20190911165845.GA31643@linux.vnet.ibm.com>
References: <20190906135020.19772-1-srikar@linux.vnet.ibm.com>
 <20190906135020.19772-4-srikar@linux.vnet.ibm.com>
 <87lfuurirh.fsf@linux.ibm.com> <20190911165845.GA31643@linux.vnet.ibm.com>
Date: Thu, 12 Sep 2019 11:41:57 -0500
Message-ID: <87ftl1qxey.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-12_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909120174
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
Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Srikar,

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
>> > @@ -496,6 +501,16 @@ static int numa_setup_cpu(unsigned long lcpu)
>> >  	if (nid < 0 || !node_possible(nid))
>> >  		nid = first_online_node;
>> >  
>> > +	/*
>> > +	 * Update for the first thread of the core. All threads of a core
>> > +	 * have to be part of the same node. This not only avoids querying
>> > +	 * for every other thread in the core, but always avoids a case
>> > +	 * where virtual node associativity change causes subsequent threads
>> > +	 * of a core to be associated with different nid.
>> > +	 */
>> > +	if (fcpu != lcpu)
>> > +		map_cpu_to_node(fcpu, nid);
>> > +
>> 
>> OK, I see that this somewhat addresses my concern above. But changing
>> this mapping for a remote cpu is unsafe except under specific
>> circumstances. I think this should first assert:
>> 
>> * numa_cpu_lookup_table[fcpu] == NUMA_NO_NODE
>> * cpu_online(fcpu) == false
>> 
>> to document and enforce the conditions that must hold for this to be OK.
>
> I do understand that we shouldn't be modifying the nid for a different cpu.
>
> We just checked above that the mapping for the first cpu doesnt exist.
> If the first cpu (or remote cpu as you coin it) was online, then its
> mapping should have existed and we return even before we come here.

I agree that is how the code will work with your change, and I'm fine
with simply warning if fcpu is offline.

The point is to make this rule more explicit in the code for the benefit
of future readers and to catch violations of it by future changes. There
is a fair amount of code remaining in this file and elsewhere in
arch/powerpc that was written under the impression that changing the
cpu-node relationship at runtime is OK.


> nid = numa_cpu_lookup_table[fcpu];
> if (nid >= 0) {
> 	map_cpu_to_node(lcpu, nid);
> 	return nid;
> }
>
> Currently numa_setup_cpus is only called at very early boot and in cpu
> hotplug. At hotplug time, the oneline of cpus is serialized. Right? Do we 
> see a chance of remote cpu changing its state as we set its nid here?
>
> Also lets say if we assert and for some unknown reason the assertion fails.
> How do we handle the failure case?  We cant get out without setting
> the nid. We cant continue setting the nid. Should we panic the system given
> that the check a few lines above is now turning out to be false? Probably
> no, as I think we can live with it.
>
> Any thoughts?

I think just WARN_ON(cpu_online(fcpu)) would be satisfactory. In my
experience, the downstream effects of violating this condition are
varied and quite difficult to debug. Seems only appropriate to emit a
warning and stack trace before the OS inevitably becomes unstable.
