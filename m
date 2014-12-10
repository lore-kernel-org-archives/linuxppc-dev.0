Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 899D41A01DE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 21:42:07 +1100 (AEDT)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 10 Dec 2014 16:12:02 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id E61E1E0062
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 16:12:34 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBAAfqoZ64618632
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 16:11:53 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBAAfv6m026084
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 16:11:58 +0530
Date: Wed, 10 Dec 2014 16:11:24 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH 2/8] perf probe powerpc: Fix symbol fixup issues due
 to ELF type
Message-ID: <20141210104124.GB16045@naverao1-tp.in.ibm.com>
References: <cover.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
 <0412a00009a22762f92c208964df6f842796464e.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
 <1418205050.9279.5.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1418205050.9279.5.camel@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 acme@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2014/12/10 08:50PM, Michael Ellerman wrote:
> On Tue, 2014-12-09 at 23:04 +0530, Naveen N. Rao wrote:
> > If using the symbol table, symbol addresses are not being fixed up
> > properly, resulting in probes being placed at wrong addresses:
> > 
> >   # perf probe do_fork
> >   Added new event:
> >     probe:do_fork        (on do_fork)
> > 
> >   You can now use it in all perf tools, such as:
> > 
> > 	  perf record -e probe:do_fork -aR sleep 1
> > 
> >   # cat /sys/kernel/debug/tracing/kprobe_events
> >   p:probe/do_fork _text+635952
> >   # printf "%x" 635952
> >   9b430
> >   # grep do_fork /boot/System.map
> >   c0000000000ab430 T .do_fork
> 
> OK, but why is that happening? And why does checking for ET_DYN fix it?

The section header indicates 0x10000 as the offset:

Section Headers:
  [Nr] Name              Type             Address           Offset
       Size              EntSize          Flags  Link  Info  Align
  [ 0]                   NULL             0000000000000000  00000000
       0000000000000000  0000000000000000           0     0     0
  [ 1] .text             PROGBITS         c000000000000000  00010000
       0000000000806678  0000000000000000  AX       0     0     256

This is used during fixup and perf only expects this to be needed for
ET_EXEC, though we use ET_DYN on ppc64.

> > Fix by checking for ELF type ET_DYN used by ppc64 kernels.
> 
> We sometimes produce ET_DYN kernels, but only if CONFIG_RELOCATABLE=y.

Ok.

- Naveen
