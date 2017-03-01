Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYJs03KSFzDqLB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 02:14:44 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v21FEEw1042155
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 10:14:42 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28wxray2mq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Mar 2017 10:14:42 -0500
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 1 Mar 2017 20:44:39 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 8B416E0062
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 20:46:21 +0530 (IST)
Received: from d28av07.in.ibm.com (d28av07.in.ibm.com [9.184.220.146])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v21FDU0j6881290
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 20:43:30 +0530
Received: from d28av07.in.ibm.com (localhost [127.0.0.1])
 by d28av07.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v21FEYpI004326
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 20:44:35 +0530
Date: Wed, 1 Mar 2017 20:44:33 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2 4/5] perf: kretprobes: offset from reloc_sym if kernel
 supports it
References: <cover.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
 <75bafc91e9d381636f68ab9923ce3d52f9157a09.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170223181022.7d4427714cabbb7ccd6d6673@kernel.org>
 <20170223191608.GC4212@naverao1-tp.localdomain>
 <20170225022917.cfb45d0ea41c22fcb5d61ebb@kernel.org>
 <20170224201103.GO3595@kernel.org>
 <20170225085535.765ed62f30a7408fd0ddc043@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170225085535.765ed62f30a7408fd0ddc043@kernel.org>
Message-Id: <20170301151433.GN4212@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/02/25 08:55AM, Masami Hiramatsu wrote:
> On Fri, 24 Feb 2017 17:11:03 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > Em Sat, Feb 25, 2017 at 02:29:17AM +0900, Masami Hiramatsu escreveu:
> > > On Fri, 24 Feb 2017 00:46:08 +0530
> > > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > > > Thanks. I hope that's an Ack for this patchset?
> > > 
> > > OK, for 1/5, 2/5, 3/5, and 5/5;
> > > 
> > > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > 
> > > And could you make v4 series including all patches? (Not only updates)
> > 
> > So, to make progress I processed these:
> > 
> > [acme@jouet linux]$ git log --oneline -3
> > eb55608340b7 perf probe: Generalize probe event file open routine
> > 859d718fac06 trace/kprobes: Allow return probes with offsets and absolute addresses
> > a10489121c81 kretprobes: Ensure probe location is at function entry
> > [acme@jouet linux]$
> > 
> > Waiting for Naveen to react to these last minute considerations from
> > Masami and for the Ack from the PPC guys about "[PATCH v2 2/5] powerpc:
> > kretprobes: override default function entry offset".

Thanks Arnaldo!
Sorry, couldn't get to this sooner as I was off for a day...
I see that you've picked up 3 of the patches and Ananth/Michael have 
acked the powerpc patch.

I will post the remaining ones tonight/tomorrow.

> 
> Thanks Arnaldo!!
> 
> Naveen, please update your ppc and perf patches and send it to Arnaldo.
> I'm happy to review it.

Sure thanks, I'll work on those tonight/tomorrow.


- Naveen
