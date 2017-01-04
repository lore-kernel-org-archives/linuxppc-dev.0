Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttn5906tgzDqHs
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 21:25:32 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v04AIv1u110840
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 05:25:30 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27r5kckec7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jan 2017 05:25:29 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 4 Jan 2017 20:25:27 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 682822BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 21:25:25 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v04APP634391350
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 21:25:25 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v04APOU0020687
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 21:25:25 +1100
Date: Wed, 4 Jan 2017 15:55:22 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, ananth@in.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com
Subject: Re: [PATCH V3 3/4] arch/powerpc: Implement Optprobes
References: <1482153507-17350-1-git-send-email-anju@linux.vnet.ibm.com>
 <1482153507-17350-2-git-send-email-anju@linux.vnet.ibm.com>
 <20161225115420.08e4b7439e8b3358dcbd32ad@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20161225115420.08e4b7439e8b3358dcbd32ad@kernel.org>
Message-Id: <20170104102522.GB13299@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/12/25 11:54AM, Masami Hiramatsu wrote:
> On Mon, 19 Dec 2016 18:48:24 +0530
> Anju T Sudhakar <anju@linux.vnet.ibm.com> wrote:
> 
> > Detour buffer contains instructions to create an in memory pt_regs.
> > After the execution of the pre-handler, a call is made for instruction emulation.
> > The NIP is determined in advanced through dummy instruction emulation and a branch
> > instruction is created to the NIP at the end of the trampoline.
> > 
> > Instruction slot for detour buffer is allocated from the reserved area.
> > For the time being, 64KB is reserved in memory for this purpose.
> > 
> > Instructions which can be emulated using analyse_instr() are suppliants
> > for optimization. Before optimization ensure that the address range
> > between the detour buffer allocated and the instruction being probed
> > is within ± 32MB.
> > 
> > Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> 
> Looks good to me :)
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks, Masami!

Ben/Michael,
Can you please take a look and let us know your thoughts on this?

- Naveen
