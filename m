Return-Path: <SRS0=CHEA=US=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DE1C31E5B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Jun 2019 17:17:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01F1F20657
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Jun 2019 17:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F1F20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45TWpT2Bt8zDqw3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jun 2019 03:17:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=naveen.n.rao@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45TWmK3Ql1zDqsh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2019 03:15:12 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5JHC4iV129387
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2019 13:15:08 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2t7rq4spvu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2019 13:15:08 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 19 Jun 2019 18:15:06 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 19 Jun 2019 18:15:03 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5JHF2qf45809886
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 17:15:02 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 541C452059;
 Wed, 19 Jun 2019 17:15:02 +0000 (GMT)
Received: from localhost (unknown [9.85.70.229])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id F01395204F;
 Wed, 19 Jun 2019 17:15:01 +0000 (GMT)
Date: Wed, 19 Jun 2019 22:44:56 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/7] powerpc/ftrace: Additionally nop out the preceding
 mflr with -mprofile-kernel
To: Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>
References: <cover.1560868106.git.naveen.n.rao@linux.vnet.ibm.com>
 <72492bc769cd6f40a536e689fc3195570d07fd5c.1560868106.git.naveen.n.rao@linux.vnet.ibm.com>
 <877e9idum7.fsf@concordia.ellerman.id.au>
 <1560927184.kqsg9x9bd1.astroid@bobo.none>
 <1560935530.70niyxru6o.naveen@linux.ibm.com>
 <1560939496.ovo51ph4i4.astroid@bobo.none>
In-Reply-To: <1560939496.ovo51ph4i4.astroid@bobo.none>
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
x-cbid: 19061917-0016-0000-0000-0000028A95A4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061917-0017-0000-0000-000032E7EDD6
Message-Id: <1560961996.5xzl76c7fj.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-19_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906190139
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin wrote:
> Naveen N. Rao's on June 19, 2019 7:53 pm:
>> Nicholas Piggin wrote:
>>> Michael Ellerman's on June 19, 2019 3:14 pm:
>>>>=20
>>>> I'm also not convinced the ordering between the two patches is
>>>> guaranteed by the ISA, given that there's possibly no isync on the oth=
er
>>>> CPU.
>>>=20
>>> Will they go through a context synchronizing event?
>>>=20
>>> synchronize_rcu_tasks() should ensure a thread is scheduled away, but
>>> I'm not actually sure it guarantees CSI if it's kernel->kernel. Could
>>> do a smp_call_function to do the isync on each CPU to be sure.
>>=20
>> Good point. Per=20
>> Documentation/RCU/Design/Requirements/Requirements.html#Tasks RCU:
>> "The solution, in the form of Tasks RCU, is to have implicit read-side=20
>> critical sections that are delimited by voluntary context switches, that=
=20
>> is, calls to schedule(), cond_resched(), and synchronize_rcu_tasks(). In=
=20
>> addition, transitions to and from userspace execution also delimit=20
>> tasks-RCU read-side critical sections."
>>=20
>> I suppose transitions to/from userspace, as well as calls to schedule()=20
>> result in context synchronizing instruction being executed. But, if some=
=20
>> tasks call cond_resched() and synchronize_rcu_tasks(), we probably won't=
=20
>> have a CSI executed.
>>=20
>> Also:
>> "In CONFIG_PREEMPT=3Dn kernels, trampolines cannot be preempted, so thes=
e=20
>> APIs map to call_rcu(), synchronize_rcu(), and rcu_barrier(),=20
>> respectively."
>>=20
>> In this scenario as well, I think we won't have a CSI executed in case=20
>> of cond_resched().
>>=20
>> Should we enhance patch_instruction() to handle that?
>=20
> Well, not sure. Do we have many post-boot callers of it? Should
> they take care of their own synchronization requirements?

Kprobes and ftrace are the two users (along with anything else that may=20
use jump labels).

Looking at this from the CMODX perspective: the main example quoted of=20
an erratic behavior is when any variant of the patched instruction=20
causes an exception.

With ftrace, I think we are ok since we only ever patch a 'nop' or a=20
'bl' (and the 'mflr' now), none of which should cause an exception. As=20
such, the existing patch_instruction() should suffice.

However, with kprobes, we patch a 'trap' (or a branch in case of=20
optprobes) on most instructions. I wonder if we should be issuing an=20
'isync' on all cpus in this case. Or, even if that is sufficient or=20
necessary.


Thanks,
Naveen

=

