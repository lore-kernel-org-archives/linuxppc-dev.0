Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C0EC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 06:05:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E290D20657
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 06:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E290D20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gD7x1xsBzDqmM
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 17:05:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=ego@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gD5x3VvtzDqlc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 17:03:32 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x0H5x8N5019323
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 01:03:26 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q2kj38y6n-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 01:03:26 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 17 Jan 2019 06:03:25 -0000
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
 by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 17 Jan 2019 06:03:22 -0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0H63MuV17235986
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 17 Jan 2019 06:03:22 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E74CDBE051;
 Thu, 17 Jan 2019 06:03:21 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5DA60BE056;
 Thu, 17 Jan 2019 06:03:21 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.124.35.138])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 17 Jan 2019 06:03:21 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
 id 378F82E3D42; Thu, 17 Jan 2019 11:33:17 +0530 (IST)
Date: Thu, 17 Jan 2019 11:33:17 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: Re: [PATCH] pseries/hotplug: Add more delay in pseries_cpu_die while
 waiting for rtas-stop
References: <1544095908-2414-1-git-send-email-ego@linux.vnet.ibm.com>
 <87a7li5zv2.fsf@morokweng.localdomain>
 <20181207104311.GA11431@in.ibm.com>
 <20181207120346.GB11431@in.ibm.com>
 <87va443fm3.fsf@morokweng.localdomain>
 <20190109060823.GA20248@in.ibm.com>
 <74b2262b-48e7-b2a5-7d20-dc7f590958d9@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74b2262b-48e7-b2a5-7d20-dc7f590958d9@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 19011706-8235-0000-0000-00000E4C3D9B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010422; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01147632; UDB=6.00597825; IPR=6.00927931; 
 MB=3.00025167; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-17 06:03:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011706-8236-0000-0000-0000441CA26E
Message-Id: <20190117060317.GA6897@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-17_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901170043
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
Cc: ego@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello Michael,

On Mon, Jan 14, 2019 at 12:11:44PM -0600, Michael Bringmann wrote:
> On 1/9/19 12:08 AM, Gautham R Shenoy wrote:
> 
> > I did some testing during the holidays. Here are the observations:
> > 
> > 1) With just your patch (without any additional debug patch), if I run
> > DLPAR on /off operations on a system that has SMT=off, I am able to
> > see a crash involving RTAS stack corruption within an hour's time.
> > 
> > 2) With the debug patch (appended below) which has additional debug to
> > capture the callers of stop-self, start-cpu, set-power-levels, the
> > system is able to perform DLPAR on/off operations on a system with
> > SMT=off for three days. And then, it crashed with the dead CPU showing
> > a "Bad kernel stack pointer". From this log, I can clearly
> > see that there were no concurrent calls to stop-self, start-cpu,
> > set-power-levels. The only concurrent RTAS calls were the dying CPU
> > calling "stop-self", and the CPU running the DLPAR operation calling
> > "query-cpu-stopped-state". The crash signature is appended below as
> > well.
> > 
> > 3) Modifying your patch to remove the udelay and increase the loop
> > count from 25 to 1000 doesn't improve the situation. We are still able
> > to see the crash.
> > 
> > 4) With my patch, even without any additional debug, I was able to
> > observe the system run the tests successfully for over a week (I
> > started the tests before the Christmas weekend, and forgot to turn it
> > off!)
> 
> So does this mean that the problem is fixed with your patch?

No. On the contrary I think my patch unable to exploit the possible
race window.  From a technical point of view, Thiago's patch does the
right things

  - It waits for the target CPU to come out of CEDE and set its state
    to CPU_STATE_OFFLINE.
  
  - Only then it then makes the "query-cpu-stopped-state" rtas call in
    a loop, while giving sufficient delay between successive
    queries. This reduces the unnecessary rtas-calls.

In my patch, I don't do any of this, but simply keep calling
"query-cpu-stopped-state" call in a loop for 4000 iterations.

That said, if I incorporate the wait for the target CPU to set its
state to CPU_STATE_OFFLINE in my patch and then make the
"query-cpu-stopped-state" rtas call, then, even I am able to get the
crash with the "RTAS CALL BUFFER CORRUPTION" message.

I think that incorporating the wait for the target CPU set its state
to CPU_STATE_OFFLINE increases the probability that
"query-cpu-stopped-state" and "stop-self" rtas calls get called more
or less at the same time. However since concurrent invocations of
these rtas-calls is allowed by the PAPR, it should not result in a
"RTAS CALL BUFFER CORRUPTION". Am I missing something here ?

> 
> > 
> > It appears that there is a narrow race window involving rtas-stop-self
> > and rtas-query-cpu-stopped-state calls that can be observed with your
> > patch. Adding any printk's seems to reduce the probability of hitting
> > this race window. It might be worth the while to check with RTAS
> > folks, if they suspect something here.
> 
> What would the RTAS folks be looking at here?  The 'narrow race window'
> is with respect to a patch that it sound like we should not be
> using.

IMHO, if the race-window exists, it would be better to confirm and fix
it, given that we have a patch that can exploit it consistently.

> 
> Thanks.
> Michael
> 
> -- 
> Michael W. Bringmann
> Linux Technology Center
> IBM Corporation
> Tie-Line  363-5196
> External: (512) 286-5196
> Cell:       (512) 466-0650
> mwb@linux.vnet.ibm.com

--
Thanks and Regards
gautham.

