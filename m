Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdTkj1cH6zDqYr
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 21:08:44 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v28A4Nn3006922
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Mar 2017 05:08:26 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 292f82ht4g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Mar 2017 05:08:26 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 8 Mar 2017 20:08:23 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v28A8DNO54395050
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Mar 2017 21:08:21 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v28A7mPC006568
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Mar 2017 21:07:48 +1100
Date: Wed, 8 Mar 2017 15:37:29 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: kprobes: convert __kprobes to NOKPROBE_SYMBOL()
References: <20170307203929.5807-1-naveen.n.rao@linux.vnet.ibm.com>
 <20170308094245.ace4eeff69b79d1956a277ee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170308094245.ace4eeff69b79d1956a277ee@kernel.org>
Message-Id: <20170308100729.GG11046@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/03/08 09:42AM, Masami Hiramatsu wrote:
> On Wed,  8 Mar 2017 02:09:29 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > Along similar lines as commit 9326638cbee2 ("kprobes, x86: Use
> > NOKPROBE_SYMBOL() instead of __kprobes annotation"), convert __kprobes
> > annotation to either NOKPROBE_SYMBOL() or nokprobe_inline. The latter
> > forces inlining, in which case the caller needs to be added to
> > NOKPROBE_SYMBOL().
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> OK, this is a good starting point so far. please consider that those
> functions really have to be protected by kprobes. As you can see on x86,

Yes, I've only converted static functions to nokprobe_inline and 
confirmed that their callers are protected. I also verified that none of 
these show up in kallsyms.

> I allowed some functions to be kprobed by commit 7ec8a97a990d ("kprobes/x86:
> Allow probe on some kprobe preparation functions").
> Maybe on powerpc, those arch_* functions also be probed safely, since
> those are not kicked in the context of breakpoint interruption.

Nice, thanks for the pointer. I will consider that as part of the kprobe 
blacklisting updates I have for powerpc.

Regards,
Naveen
