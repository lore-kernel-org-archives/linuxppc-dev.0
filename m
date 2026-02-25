Return-Path: <linuxppc-dev+bounces-17202-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFD5FD377A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Feb 2026 17:48:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLhsD2t31z3f99;
	Thu, 26 Feb 2026 04:48:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772041712;
	cv=none; b=MoT62VVrksZ4A6+HAE2aUgnVceafvkmAR3WyaZeIfmL1YJFGTeGZfCahenXGaQrzgvAvHTuWBhEECBWQ4QPz3A4929LE1wIYhdgEXp23sA8d5DFERVmzs1/aLcg+vAml4lp9sddDpjF4tXo07lrklNGJdxLEA/Wy884CrjdJ8gHDoKpicc+BWLS64O+fmYyMylHVUMCOw+J4QiGYsgp6VX9yYmn2poPiWrrBu4Jb3huT2F0wNXJUNOvbvzMCTMT4H4DcLiLTYSLXR7eL7F0QDjym/BAwcvixknL9i9CSTwmCoiM7MC4G+9LiBFsHr+HR694zgXW8hvPko/cY7+WJNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772041712; c=relaxed/relaxed;
	bh=Fi/scUCz0hk1ClyLWcfCwCSy/YzR+Pqnuv6JZ11frhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3BSxcoZ22VvSfQYNHOJ/UfafL3RJTaQ6Rx1tqoIAEE7D+JOR7B1xma1ew4gK6TNrcjlp9CbukHUYBKKl4NN3QnejNHFUzoywqg5JDUsfW8hSbSYebUTMNMebIq4rXiVZ1A40k1rjEmFDeUwIu8E0Mw1gTd6TFSRATaBrc9sLcYnacodQfU8qlxgrI4ieeBJu6qoghgtF8pUVOE/s+oHAdmNn3F650yMHjyIaM1IMt038Rq24AOn4jrIUtx2+PyznOHVVVwCPtVrZderxwO2TVh/2kQBb6tE37LRnJOA0AUK6XXW7h2vfHQ/dtPRplKZSS7s9hwd2vfxZLY/smFGrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hGOB5Fzl; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hGOB5Fzl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLhsB5Wf7z3f96
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2026 04:48:29 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PFFhkW2771372;
	Wed, 25 Feb 2026 17:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Fi/scU
	Cz0hk1ClyLWcfCwCSy/YzR+Pqnuv6JZ11frhM=; b=hGOB5FzlB9IxhDHx4qvcjN
	o5k9aol/f16id6Q9kaa61JSGa1RQglfiwuB4qu1PLYhJIEmPlhsV/zlX/IBoRaQl
	ztKmd8l8q7rJdeZ1ms8WNxdCMiBKOmnweAt1vutKlV+TJb1h0OrUPdhpt2yKKc0f
	/yGkC/AWTeAUFhohb/jro4dcmJwKUynpm0a9li6vcwMnAFdbaq7kN6EwX/0MZBJe
	3IUh6zMSJevB0Ub8vcc7u5oBqLtXEOPpK6qaM/QvHBwbe2COkAErkoLn9+vvtD8I
	+EfcB4eC9nXn3EQglJstKnbA6FMRTJcZmt+v/x/a0qjxXXOICtSeZsq3X4bendoQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34c8u96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 17:47:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61PGRpts013406;
	Wed, 25 Feb 2026 17:47:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfqdy6j70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 17:47:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61PHlndC52429258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 17:47:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A34020043;
	Wed, 25 Feb 2026 17:47:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6F2A20040;
	Wed, 25 Feb 2026 17:47:42 +0000 (GMT)
Received: from [9.124.222.200] (unknown [9.124.222.200])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Feb 2026 17:47:42 +0000 (GMT)
Message-ID: <62f50aad-05ce-42ac-bdf6-dcb4af69c1c2@linux.ibm.com>
Date: Wed, 25 Feb 2026 23:17:42 +0530
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] powerpc/time: Prepare to stop elapsing in
 dynticks-idle
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Kieran Bingham <kbingham@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E . McKenney"
 <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Xin Zhao <jackzxcui1989@163.com>, linux-pm@vger.kernel.org,
        linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20260206142245.58987-1-frederic@kernel.org>
 <20260206142245.58987-5-frederic@kernel.org>
 <9413517d-963b-4e6d-b11b-b440acd7cb5a@linux.ibm.com>
 <9ab1e7d7-57ee-49f9-963c-3a1b96dda684@kernel.org>
 <120884b0-0b09-43a9-b0f6-7dc2affe1ac0@linux.ibm.com>
 <55720b5b-f643-4e67-8841-d81a9e712faf@kernel.org>
 <a20beb34-0e4b-4063-b6b0-6c5886bbb971@linux.ibm.com>
 <a0c6e65c-3331-402a-94eb-14ba7f4b7ba7@kernel.org>
 <729a7e7f-a50e-480c-87ce-c45221fbb326@linux.ibm.com>
 <6c007cf1-46d5-4853-ae2e-90ee5257c6c9@kernel.org>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <6c007cf1-46d5-4853-ae2e-90ee5257c6c9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE2OSBTYWx0ZWRfXyoXr+gaINCkX
 swtLpILwXDJFyN/y0EQ/PZ6BsXh7ez8fMiRIFQX1Kuvmd0cTkULq2NEg+gsiOSUI9+8+V/bfqvt
 BCEwPgwsRHOUNk8y2Fm7+NOe+fRW3mrNjsOctq3c0QFljM91aj1CDDETUkQLYEhDrZrJs+gfc4T
 0KHhGDrntMSNoRCLDSVrvPGA7tApvjLpc8Dc3OlpCiRs1UVE06uKamvhqS6W2j5R7XKlsu2U5pZ
 Mfimy3SZ2nCMFT8pZvPMyT8rwDKzYBdDkKhMNMbeOTyyLViJhQSOBITwdWbY0ftlpRtviwTdfO2
 FMD9AtfmjzbbVWVlSfxd2GUx6KH96iwpcENvdcZnlTxRb70VSdeHd/WFnivdjuy8emwMld1JZAC
 /95Np8ehXGeW2R/LePIcVP7WGBjvoGjU0puVnGn5JcTeHs+p3/SW48g6jPQJQBA6ffhQsGNftVM
 8031OmFKUBPXwq3YhXg==
X-Proofpoint-ORIG-GUID: Tv4S2untdyEH1R38ppz_YIjtG6ZEtY6R
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=699f35ca cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=lk4ULvty7AM7_XruhlkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kqxW0WId8-MSaE3TJ8tfVvU82vXknTAu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_02,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602250169

Hi Christophe.

> I think I'm starting to understand now.
> 
> I think the problem is that acct->starttime has an invalid value the 
> very first time it is used.
> 
> We are probably lacking an initial value in paca->accounting.starttime.
> This should likely be initialised from mftb in head_64.S in 
> start_here_common for main CPU and __secondary_start for other CPUs or 
> maybe at higher level in C in setup_arch() and start_secondary()
> 
> Christophe

How about below? this works too.

---

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 18506740f4a4..af129645b7f7 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -928,9 +928,24 @@ static void __init set_decrementer_max(void)
                 bits, decrementer_max);
  }

+#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
+/*
+ * This is done to initialize the starttime correctly. with this
+ * /proc/stat show correct values similar to CONFIG_VIRT_CPU_ACCOUNTING_GEN
+ */
+static void init_cpu_accounting_startime(void)
+{
+       struct cpu_accounting_data *acct = get_accounting(current);
+       acct->starttime = mftb();
+}
+#else
+static void init_cpu_accounting_startime(void) { };
+#endif
+
  static void __init init_decrementer_clockevent(void)
  {
         register_decrementer_clockevent(smp_processor_id());
+       init_cpu_accounting_startime();
  }

  void secondary_cpu_time_init(void)
@@ -946,6 +961,8 @@ void secondary_cpu_time_init(void)
         /* FIME: Should make unrelated change to move snapshot_timebase
          * call here ! */
         register_decrementer_clockevent(smp_processor_id());
+
+       init_cpu_accounting_startime();
  }

  /*


