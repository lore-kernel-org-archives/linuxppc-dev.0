Return-Path: <ananth@in.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 52ABFB6FC3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2012 14:53:27 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Tue, 12 Jun 2012 00:53:22 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 0A27D38C801C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2012 00:52:41 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5C4qeC8125552
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2012 00:52:40 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5C4qepA021584
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2012 01:52:40 -0300
Date: Tue, 12 Jun 2012 10:22:22 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 2/2] [POWERPC] uprobes: powerpc port
Message-ID: <20120612045222.GA19385@in.ibm.com>
References: <20120606093541.GA29580@in.ibm.com>
 <1339006084.3458.25.camel@localhost> <20120608043605.GB13409@in.ibm.com>
 <1339134714.25573.4.camel@concordia> <20120608060104.GD13409@in.ibm.com>
 <1339136264.25573.7.camel@concordia> <20120608061954.GE13409@in.ibm.com>
 <1339137497.25573.9.camel@concordia> <20120608092104.GF13409@in.ibm.com>
 <1339473706.14757.14.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339473706.14757.14.camel@concordia>
Cc: Jim Keniston <jkenisto@linux.vnet.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com,
 lkml <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>,
 linuxppc-dev@lists.ozlabs.org
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 12, 2012 at 02:01:46PM +1000, Michael Ellerman wrote:
> On Fri, 2012-06-08 at 14:51 +0530, Ananth N Mavinakayanahalli wrote:
> > On Fri, Jun 08, 2012 at 04:38:17PM +1000, Michael Ellerman wrote:
> > > On Fri, 2012-06-08 at 11:49 +0530, Ananth N Mavinakayanahalli wrote:
> > > > On Fri, Jun 08, 2012 at 04:17:44PM +1000, Michael Ellerman wrote:
> > > > > On Fri, 2012-06-08 at 11:31 +0530, Ananth N Mavinakayanahalli wrote:
> > > > > > On Fri, Jun 08, 2012 at 03:51:54PM +1000, Michael Ellerman wrote:
> > > > > > > On Fri, 2012-06-08 at 10:06 +0530, Ananth N Mavinakayanahalli wrote:
> > > > > > 
> > > > > > But MSR_PR=1 and hence emulate_step() will return -1 and hence we will
> > > > > > end up single-stepping using user_enable_single_step(). Same with rfid.
> > > > > 
> > > > > Right. But that was exactly Jim's point, you may be asked to emulate
> > > > > those instructions even though you wouldn't expect to see them in
> > > > > userspace code, so you need to handle it.
> > > > > 
> > > > > Luckily it looks like emulate_step() will do the right thing for you.
> > > > > It'd be good to test it to make 100% sure.
> > > > 
> > > > Sure. Will add that check and send v2.
> > > 
> > > Sorry I didn't mean add a test in the code, I meant construct a test
> > > case to confirm that it works as expected.
> > 
> > Michael,
> > 
> > I just hand-coded the instr to emulate_step() and here are the results:
> > 
> > MSR_PR is set
> > insn = 7c600124, ret = 0 /* mtmsr */
> > insn = 7c600164, ret = 0 /* mtmsrd */
> > insn = 4c000024, ret = -1 /* rfid */
> > insn = 4c000064, ret = 0 /* rfi */
> > 
> > Also verified that standalone programs with those instructions in inline
> > asm will die with a SIGILL.
> > 
> > So, for mtmsr, mtmsrd and rfi, we have to single-step them which will
> > result in a SIGILL in turn.
> 
> What happens in the rfid case? You don't handle -1 from emulate_step()
> any differently AFAICS, so don't we try to single step that too?

-1 is just emulate_step() flagging cases where instructions must not be
single-stepped (rfi[d], mtmsr that clears MSR_RI). But as with the other
OEA instructions in user space, we fail with a SIGILL.

As the application is hozed in any case if we encounter an OEA
instruction, I'd think there is no point in handling a -1 from
emulate_step() any differently.

Ananth
