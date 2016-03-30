Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZhCk07T2zDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 19:49:38 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 30 Mar 2016 18:49:36 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A8E34357805B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 19:49:17 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2U8lnYO11600130
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 19:49:02 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2U8lBds006151
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 19:47:11 +1100
Date: Wed, 30 Mar 2016 14:16:18 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Remove kretprobe_trampoline_holder.
Message-ID: <20160330084608.GC21299@naverao1-tp.in.ibm.com>
References: <3qWbvb0yVwz9sdm@ozlabs.org>
 <1459195592-6559-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1459222294.8173.8.camel@ellerman.id.au>
 <3337968.FTL1d9fOmu@hactar>
 <20160330080459.GB21299@naverao1-tp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20160330080459.GB21299@naverao1-tp.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/03/30 01:34PM, Naveen N Rao wrote:
> On 2016/03/29 08:35PM, Thiago Jung Bauermann wrote:
> > Am Dienstag, 29 März 2016, 14:31:34 schrieb Michael Ellerman:
> > > On Mon, 2016-03-28 at 17:06 -0300, Thiago Jung Bauermann wrote:
> > So at first glance, it looks like perf is better off using symbols 
> > that point to the global entry point...
> 
> See above - we need to use the LEP. I suspect we don't fixup all the 
> symbols in kallsyms -- just the ones being probed which explains why 
> there is a mismatch. Let me take a look.

Indeed. With vmlinux, we use the symbol table to identify symbols with a 
LEP, and we adjust those symbols during load time. However, with 
kallsyms, we don't have any data around which symbols have a LEP and 
which don't. So, we can't fixup all the entries globally.

- Naveen
