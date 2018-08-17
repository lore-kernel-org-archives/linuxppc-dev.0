Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41sTVR73kGzDqm6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Aug 2018 02:41:19 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7HGcVms013215
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 12:41:17 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kx1u70me5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 12:41:17 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 17 Aug 2018 17:41:15 +0100
Date: Fri, 17 Aug 2018 22:11:10 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc64/ftrace: Include ftrace.h needed for
 enable/disable calls
To: Luke Dashjr <luke@dashjr.org>
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar
 <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras
 <paulus@ozlabs.org>, Steven Rostedt <rostedt@goodmis.org>
References: <201808162136.27788.luke@dashjr.org>
 <1534501411.hvsbp9w9ur.naveen@linux.ibm.com>
 <201808171516.34356.luke@dashjr.org>
In-Reply-To: <201808171516.34356.luke@dashjr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1534524010.ixq4fqaac8.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Luke Dashjr wrote:
> On Friday 17 August 2018 10:25:40 Naveen N. Rao wrote:
>> Luke Dashjr wrote:
>> > this_cpu_disable_ftrace and this_cpu_enable_ftrace are inlines in
>> > ftrace.h Without it included, the build fails.
>>
>> I'm unable to reproduce this. Can you share your .config and the build
>> environment?
>=20
> https://luke.dashjr.org/tmp/code/4.18-config.xz
>=20
> Gentoo GNU/Linux (mostly stable keywords) on a Raptor Talos II POWER9 sys=
tem.

Thanks. Your config is missing CONFIG_TRACEPOINTS and I hadn't tested=20
that. The below fix looks good and I've confirmed that the other uses=20
are fine as well.

- Naveen

=
