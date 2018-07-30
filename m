Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fb8G5ph9zF10S
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 09:17:50 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6UNEi8b129747
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 19:17:47 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kjavhte1q-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 19:17:47 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Mon, 30 Jul 2018 19:17:46 -0400
Date: Mon, 30 Jul 2018 20:17:38 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Cc: linux-kernel@vger.kernel.org, "Alastair D'Silva" <alastair@d-silva.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Cyril Bur <cyrilbur@gmail.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Joe Perches <joe@perches.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 04/10] powerpc/traps: Use REG_FMT in show_signal_msg()
References: <20180727145811.12334-1-muriloo@linux.ibm.com>
 <20180727145811.12334-5-muriloo@linux.ibm.com>
 <20180727184023.Horde.KRXPzZpG18uxt_B9sy_FBg5@messagerie.si.c-s.fr>
 <20180730152838.GA23704@kermit-br-ibm-com>
 <20180730183047.Horde.g9hQ_3EXmF6St0upNs2DDw1@messagerie.si.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180730183047.Horde.g9hQ_3EXmF6St0upNs2DDw1@messagerie.si.c-s.fr>
Message-Id: <20180730231738.GA20351@kermit-br-ibm-com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Christophe.

On Mon, Jul 30, 2018 at 06:30:47PM +0200, LEROY Christophe wrote:
> Murilo Opsfelder Araujo <muriloo@linux.ibm.com> a écrit :
>
> > Hi, Christophe.
> >
> > On Fri, Jul 27, 2018 at 06:40:23PM +0200, LEROY Christophe wrote:
> > > Murilo Opsfelder Araujo <muriloo@linux.ibm.com> a écrit :
> > >
> > > > Simplify the message format by using REG_FMT as the register format.  This
> > > > avoids having two different formats and avoids checking for MSR_64BIT.
> > >
> > > Are you sure it is what we want ?
> >
> > Yes.
> >
> > > Won't it change the behaviour for a 32 bits app running on a 64bits kernel ?
> >
> > In fact, this changes how many zeroes are prefixed when displaying the
> > registers
> > (%016lx vs. %08lx format).  For example, 32-bits userspace, 64-bits kernel:
>
> Indeed that's what I suspected. What is the real benefit of this change ?
> Why not keep the current format for 32bits userspace ? All those leading
> zeroes are pointless to me.

One of the benefits is simplifying the code by removing some checks.  Another is
deduplicating almost identical format strings in favor of a unified one.

After reading Joe's comment [1], %px seems to be the format we're looking for.
An extract from Documentation/core-api/printk-formats.rst:

  "%px is functionally equivalent to %lx (or %lu). %px is preferred because it
  is more uniquely grep'able."

So I guess we don't need to worry about the format (%016lx vs. %08lx), let's
just use %px, as per the guideline.

[1] https://lore.kernel.org/lkml/26f07092cdde378ebb42c1034badde1b56521c36.camel@perches.com/

Cheers
Murilo
