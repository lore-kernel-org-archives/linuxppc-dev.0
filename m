Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vczZl5vJBzDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 01:30:07 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v27ESm1P097713
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Mar 2017 09:30:05 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 291xb2sam2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Mar 2017 09:30:05 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 7 Mar 2017 20:00:01 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id A74453940067
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 19:59:57 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v27ETvHJ43778120
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Mar 2017 19:59:57 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v27ETtEL031587
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Mar 2017 19:59:56 +0530
Date: Tue, 7 Mar 2017 19:59:53 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 5/6] perf: probes: move ftrace README parsing logic into
 trace-event-parse.c
References: <cover.1488881988.git.naveen.n.rao@linux.vnet.ibm.com>
 <b5e4defdba760ea9a48681e3c3075b3517037008.1488881988.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170307150332.5ecac6a63a6c1d27247cbcb4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170307150332.5ecac6a63a6c1d27247cbcb4@kernel.org>
Message-Id: <20170307142953.GB11046@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/03/07 03:03PM, Masami Hiramatsu wrote:
> On Tue,  7 Mar 2017 16:17:40 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > probe-file.c needs libelf, but scanning ftrace README does not require
> > that. As such, move the ftrace README scanning logic out of probe-file.c
> > and into trace-event-parse.c.
> 
> Hmm, it seems probe-file.c doesn't require libelf at all...
> I would like to keep ftrace related things in probe-file.c.

Not sure I understand. probe-file.h explicitly calls out a need for 
libelf due to the probe cache and related routines - commit 
40218daea1db1 ("perf list: Show SDT and pre-cached events").

However, if you prefer to retain the ftrace README scanning here, we can 
drop this patch and I can update patch 6 to check for libelf.

Thanks,
Naveen
