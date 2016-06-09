Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQFJR1FHyzDqdG
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 16:09:42 +1000 (AEST)
Received: from pps.filterd (m0049461.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5968mKj033489
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jun 2016 02:09:41 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23e9mx97u8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jun 2016 02:09:40 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 9 Jun 2016 16:09:33 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B960A357807F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 16:09:01 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5968u4g7995710
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jun 2016 16:08:56 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5968o24016705
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jun 2016 16:08:51 +1000
Date: Thu, 9 Jun 2016 11:37:52 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Nilay Vaish <nilayvaish@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Matt Evans <matt@ozlabs.org>,
 Alexei Starovoitov <ast@fb.com>, netdev@vger.kernel.org,
 Denis Kirjanov <kda@linux-powerpc.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH 6/6] ppc: ebpf/jit: Implement JIT compiler for extended BPF
References: <cover.1465304785.git.naveen.n.rao@linux.vnet.ibm.com>
 <908d3552b5eb240b28f70aee7c4c86e2b600aa02.1465304785.git.naveen.n.rao@linux.vnet.ibm.com>
 <CACbG308O_+hXHuUo_opRPeLXLmoZj=gzEnMrwhwidf0m3+SOTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACbG308O_+hXHuUo_opRPeLXLmoZj=gzEnMrwhwidf0m3+SOTQ@mail.gmail.com>
Message-Id: <20160609060752.GQ18654@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/06/08 10:19PM, Nilay Vaish wrote:
> Naveen, can you point out where in the patch you update the variable:
> idx, a member of codegen_contex structure?  Somehow I am unable to
> figure it out.  I can only see that we set it to 0 in the
> bpf_int_jit_compile function.  Since all your test cases pass, I am
> clearly overlooking something.

Yes, that's being done in bpf_jit.h (see the earlier patches in the 
series). All the PPC_*() instruction macros are defined to EMIT() the 
respective powerpc instruction encoding.  EMIT() translates to 
PLANT_INSTR(), which actually increments idx.

- Naveen
