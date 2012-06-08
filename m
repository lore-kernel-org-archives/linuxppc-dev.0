Return-Path: <ananth@in.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1E17BB6FB7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2012 19:31:22 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Fri, 8 Jun 2012 03:21:11 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id A3E901FF001F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2012 09:21:07 +0000 (WET)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q589L7H9164690
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jun 2012 03:21:07 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q589L6nY016802
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jun 2012 03:21:06 -0600
Date: Fri, 8 Jun 2012 14:51:04 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 2/2] [POWERPC] uprobes: powerpc port
Message-ID: <20120608092104.GF13409@in.ibm.com>
References: <20120606092150.GC6745@in.ibm.com>
 <1338974822.2749.89.camel@twins> <20120606093541.GA29580@in.ibm.com>
 <1339006084.3458.25.camel@localhost> <20120608043605.GB13409@in.ibm.com>
 <1339134714.25573.4.camel@concordia> <20120608060104.GD13409@in.ibm.com>
 <1339136264.25573.7.camel@concordia> <20120608061954.GE13409@in.ibm.com>
 <1339137497.25573.9.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339137497.25573.9.camel@concordia>
Cc: Jim Keniston <jkenisto@linux.vnet.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 oleg@redhat.com, Paul Mackerras <paulus@samba.org>,
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

On Fri, Jun 08, 2012 at 04:38:17PM +1000, Michael Ellerman wrote:
> On Fri, 2012-06-08 at 11:49 +0530, Ananth N Mavinakayanahalli wrote:
> > On Fri, Jun 08, 2012 at 04:17:44PM +1000, Michael Ellerman wrote:
> > > On Fri, 2012-06-08 at 11:31 +0530, Ananth N Mavinakayanahalli wrote:
> > > > On Fri, Jun 08, 2012 at 03:51:54PM +1000, Michael Ellerman wrote:
> > > > > On Fri, 2012-06-08 at 10:06 +0530, Ananth N Mavinakayanahalli wrote:
> > > > 
> > > > But MSR_PR=1 and hence emulate_step() will return -1 and hence we will
> > > > end up single-stepping using user_enable_single_step(). Same with rfid.
> > > 
> > > Right. But that was exactly Jim's point, you may be asked to emulate
> > > those instructions even though you wouldn't expect to see them in
> > > userspace code, so you need to handle it.
> > > 
> > > Luckily it looks like emulate_step() will do the right thing for you.
> > > It'd be good to test it to make 100% sure.
> > 
> > Sure. Will add that check and send v2.
> 
> Sorry I didn't mean add a test in the code, I meant construct a test
> case to confirm that it works as expected.

Michael,

I just hand-coded the instr to emulate_step() and here are the results:

MSR_PR is set
insn = 7c600124, ret = 0 /* mtmsr */
insn = 7c600164, ret = 0 /* mtmsrd */
insn = 4c000024, ret = -1 /* rfid */
insn = 4c000064, ret = 0 /* rfi */

Also verified that standalone programs with those instructions in inline
asm will die with a SIGILL.

So, for mtmsr, mtmsrd and rfi, we have to single-step them which will
result in a SIGILL in turn.

Ananth
