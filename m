Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjW3y2NxvzDqKY
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 00:22:54 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v57EIsUx034752
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Jun 2017 10:22:51 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2axgbh18mt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Jun 2017 10:22:51 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 8 Jun 2017 00:22:48 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v57EMcMw62718112
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Jun 2017 00:22:46 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v57EMCQW001966
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Jun 2017 00:22:12 +1000
Date: Wed, 7 Jun 2017 19:42:52 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, christophe.leroy@c-s.fr,
 paulus@samba.org
Subject: Re: [PATCH v3 3/9] powerpc/kprobes/optprobes: Move over to
 patch_instruction
References: <20170606042945.24997-1-bsingharora@gmail.com>
 <20170606042945.24997-4-bsingharora@gmail.com>
 <20170606191249.GG19390@naverao1-tp.localdomain>
 <1496814365.18257.3.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1496814365.18257.3.camel@gmail.com>
Message-Id: <20170607141252.GH19390@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/06/07 03:46PM, Balbir Singh wrote:
> On Wed, 2017-06-07 at 00:42 +0530, Naveen N. Rao wrote:
> > On 2017/06/06 02:29PM, Balbir Singh wrote:
> > > With text moving to read-only migrate optprobes to using
> > > the patch_instruction infrastructure. Without this optprobes
> > > will fail and complain.
> > > 
> <snip>
> > > +	/* We can optimize this via patch_instruction_window later */
> > 
> > This probably needs a TODO just so it's clear. I do think this would be 
> > good to add since we copy many instructions while setting up the 
> > optprobe, so this is quite slow as it exists today.
> 
> I made it read like a TODO, with a TOOD:

Yes, just a nit that it would be good to have an explicit 'TODO:' there, 
without which it looks like any other comment...

But, thinking about this more, we could probably simplify this by having 
optprobes set things up in a local buffer before copying it into the 
instruction slot. That will also make it easier for the subsequent 
support to patch many instructions at once.

> 
> > 
> > > +	size = (TMPL_END_IDX * sizeof(kprobe_opcode_t)) / sizeof(int);
> > 
> > That's just TMPL_END_IDX.
> >
> 
> The entire kprobe_opcode_t and int types thing is a bit messy. The size

Right - it's an artifact of kprobes generic infrastructure. For powerpc, 
it's always an integer.

> calculation assumes nothing for now in terms of sizes, but I guess the
> patch_instruction does. Another TODO?

Not sure I follow...


- Naveen
