Return-Path: <sachinp@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vFDYV4sMDzDqBX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 22:05:34 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v13Awcko119540
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Feb 2017 06:05:32 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28cngs7her-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Feb 2017 06:05:31 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sachinp@linux.vnet.ibm.com>;
 Fri, 3 Feb 2017 21:05:29 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 333272CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 22:05:28 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v13B5Kvn22609938
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Feb 2017 22:05:28 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v13B4tMg020904
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Feb 2017 22:04:56 +1100
Subject: Re: [tip:sched/core] sched/core: Add debugging code to catch missing
 update_rq_clock() calls
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/html; charset=us-ascii
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <20170203085301.GA6515@twins.programming.kicks-ass.net>
Date: Fri, 3 Feb 2017 16:34:09 +0530
Cc: Matt Fleming <matt@codeblueprint.co.uk>, Mike Galbraith <efault@gmx.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 Ross Zwisler <zwisler@gmail.com>
References: <20160921133813.31976-8-matt@codeblueprint.co.uk>
 <tip-cb42c9a3ebbbb23448c3f9a25417fae6309b1a92@git.kernel.org>
 <87tw8gutp6.fsf@concordia.ellerman.id.au>
 <20170130213435.GM31613@codeblueprint.co.uk>
 <33118425-8548-475A-8DED-9A2424C0BCCC@linux.vnet.ibm.com>
 <1485863317.4498.2.camel@gmx.de>
 <CAOxpaSW_GnndoxLBPtyTrqPJ9XOWvgXOQNDf8D+6OohWeObn5Q@mail.gmail.com>
 <20170202155506.GX6515@twins.programming.kicks-ass.net>
 <3BAB5673-2BF8-46E0-8018-6A0F3DEEC9F7@linux.vnet.ibm.com>
 <20170203085301.GA6515@twins.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>
Message-Id: <90137B89-B8B7-42AD-8A17-59D13ACB4E7B@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<html><head></head><body dir="auto" style="word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" class="ApplePlainTextBody"><div class="ApplePlainTextBody"><br><blockquote type="cite"><blockquote type="cite">[ &nbsp;173.493453] INFO: rcu_sched detected stalls on CPUs/tasks:<br>[ &nbsp;173.493473] <span class="Apple-tab-span" style="white-space:pre">	</span>8-...: (2 GPs behind) idle=006/140000000000000/0 softirq=0/0 fqs=2996 <br>[ &nbsp;173.493476] <span class="Apple-tab-span" style="white-space:pre">	</span>(detected by 0, t=6002 jiffies, g=885, c=884, q=6350)<br></blockquote><br>Right, I actually saw that too, but I don't think that would be related<br>to my patch. I'll see if I can dig into this though, ought to get fixed<br>regardless.<br><br></blockquote><br>Thanks. If required I can help test the fix.<br><br><blockquote type="cite">Thanks for testing!<br></blockquote><br></div></body></html>
