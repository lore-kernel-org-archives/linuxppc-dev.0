Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcbhG4HTbzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 00:33:50 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4UESoiB012082
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 10:33:42 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2as8gdpgyw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 10:33:42 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 31 May 2017 00:33:39 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4UEXTkG52559880
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 00:33:37 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4UEX30d025064
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 00:33:04 +1000
Date: Tue, 30 May 2017 20:02:46 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 ananth@linux.vnet.ibm.com, christophe.leroy@c-s.fr, paulus@samba.org,
 rashmica.g@gmail.com
Subject: Re: [PATCH v1 0/8] Enable STRICT_KERNEL_RWX
References: <20170525033650.10891-1-bsingharora@gmail.com>
 <20170525165733.36b50bbb@firefly.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170525165733.36b50bbb@firefly.ozlabs.ibm.com>
Message-Id: <20170530143246.GO19390@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/05/25 04:57PM, Balbir Singh wrote:
> On Thu, 25 May 2017 13:36:42 +1000
> Balbir Singh <bsingharora@gmail.com> wrote:
> 
> > Enable STRICT_KERNEL_RWX for PPC64/BOOK3S
> > 
> > These patches enable RX mappings of kernel text.
> > rodata is mapped RX as well as a trade-off, there
> > are more details in the patch description
> > 
> > As a prerequisite for R/O text, patch_instruction
> > is moved over to using a separate mapping that
> > allows write to kernel text. xmon/ftrace/kprobes
> > have been moved over to work with patch_instruction
> > 
> 
> I think optprobes needs to be moved over as well.
> I did not realize we have the optprobe_trampoline in
> text (yikes!!)

Ah, you noticed. Yes, this is a product of the limited range we have for 
immediate branches.

- Naveen
