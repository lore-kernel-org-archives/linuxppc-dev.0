Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D43C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 22:39:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8CD72087F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 22:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CD72087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lYtd6D5FzDqTZ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 08:39:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=nathanl@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lYrz6JRgzDqST
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 08:37:39 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3IMObSj131721
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 18:37:36 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ry1s9rxhn-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 18:37:36 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nathanl@linux.ibm.com>;
 Thu, 18 Apr 2019 23:37:36 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 18 Apr 2019 23:37:34 +0100
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3IMbWmb18939944
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Apr 2019 22:37:32 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F285E28059;
 Thu, 18 Apr 2019 22:37:31 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE27228058;
 Thu, 18 Apr 2019 22:37:31 +0000 (GMT)
Received: from localhost (unknown [9.85.201.6])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 18 Apr 2019 22:37:31 +0000 (GMT)
From: Nathan Lynch <nathanl@linux.ibm.com>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Subject: Re: [PATCH 0/2] disable NUMA affinity reassignments at runtime
In-Reply-To: <20190418223045.55af6509@naga>
References: <20190418185658.29751-1-nathanl@linux.ibm.com>
 <20190418223045.55af6509@naga>
Date: Thu, 18 Apr 2019 17:37:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
x-cbid: 19041822-2213-0000-0000-00000379356F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010952; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01191040; UDB=6.00624173; IPR=6.00971837; 
 MB=3.00026507; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-18 22:37:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041822-2214-0000-0000-00005E146423
Message-Id: <87imvbrlck.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-18_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904180131
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
Cc: srikar.dronamraju@in.ibm.com, mmc@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mwb@linux.ibm.com, julietk@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michal Such=C3=A1nek <msuchanek@suse.de> writes:

> On Thu, 18 Apr 2019 13:56:56 -0500
> Nathan Lynch <nathanl@linux.ibm.com> wrote:
>
> Hello,
>
>> Changing cpu <-> node relationships at runtime, as the pseries
>> platform code attempts to do for LPM, PRRN, and VPHN is essentially
>> unsupported by core subsystems. [1]
>
> Wasn't there a patch that solves the discrepancy by removing and
> re-adding the updated CPUs?
>
> http://patchwork.ozlabs.org/patch/1051761/

In our testing it seems that changing the result of cpu_to_node() for a
given cpu id, even with an intervening offline/online, leads to crashes
and assertions in the slab allocator. There have been some ideas floated
to sidestep that but I think there are larger issues to consider.

Even if changing CPU node assignments were possible to do without
destabilizing the system it's not all that useful without updating
memory/LMB affinity as well. (VPHN is an exception.)

Furthermore I'm not aware of any effort to make the numa/affinity APIs
at the system call level account for the possibility that the cpu/mem
<-> node relationship could be dynamic. Nor is there any facility for
notifying applications of changes. Even if the kernel were to properly
support this internally, NUMA-aware applications are the ones that will
suffer unless appropriate APIs are provided to them.

To me it seems this all needs more careful consideration and work, and
much of it should happen outside of this particular arch/platform
context.

