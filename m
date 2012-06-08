Return-Path: <ananth@in.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 92BDDB6FB6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2012 16:21:34 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Fri, 8 Jun 2012 00:21:32 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id BC3143E40049
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2012 06:20:38 +0000 (WET)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q586KDQh082564
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jun 2012 00:20:23 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q586JuYD021227
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jun 2012 00:19:57 -0600
Date: Fri, 8 Jun 2012 11:49:55 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 2/2] [POWERPC] uprobes: powerpc port
Message-ID: <20120608061954.GE13409@in.ibm.com>
References: <20120606091950.GB6745@in.ibm.com>
 <20120606092150.GC6745@in.ibm.com> <1338974822.2749.89.camel@twins>
 <20120606093541.GA29580@in.ibm.com> <1339006084.3458.25.camel@localhost>
 <20120608043605.GB13409@in.ibm.com> <1339134714.25573.4.camel@concordia>
 <20120608060104.GD13409@in.ibm.com> <1339136264.25573.7.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339136264.25573.7.camel@concordia>
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

On Fri, Jun 08, 2012 at 04:17:44PM +1000, Michael Ellerman wrote:
> On Fri, 2012-06-08 at 11:31 +0530, Ananth N Mavinakayanahalli wrote:
> > On Fri, Jun 08, 2012 at 03:51:54PM +1000, Michael Ellerman wrote:
> > > On Fri, 2012-06-08 at 10:06 +0530, Ananth N Mavinakayanahalli wrote:
> > > > On Wed, Jun 06, 2012 at 11:08:04AM -0700, Jim Keniston wrote:
> > > > > On Wed, 2012-06-06 at 15:05 +0530, Ananth N Mavinakayanahalli wrote:
> > > > > > On Wed, Jun 06, 2012 at 11:27:02AM +0200, Peter Zijlstra wrote:
> > > > > > > On Wed, 2012-06-06 at 14:51 +0530, Ananth N Mavinakayanahalli wrote:
> > > > 
> > > > ...
> > > > 
> > > > > > For the kernel, the only ones that are off limits are rfi (return from
> > > > > > interrupt), mtmsr (move to msr). All other instructions can be probed.
> > > > > > 
> > > > > > Both those instructions are supervisor level, so we won't see them in
> > > > > > userspace at all; so we should be able to probe all user level
> > > > > > instructions.
> > > > > 
> > > > > Presumably rfi or mtmsr could show up in the instruction stream via an
> > > > > erroneous or mischievous asm statement.  It'd be good to verify that you
> > > > > handle that gracefully.
> > > > 
> > > > That'd be flagged elsewhere, by the architecture itself -- you'd get a
> > > > privileged instruciton exception if you try execute any instruction not
> > > > part of the UISA. I therefore don't think its a necessary check in the
> > > > uprobes code.
> > > 
> > > But you're not executing the instruction, you're passing it to
> > > emulate_step(). Or am I missing something?
> > 
> > But MSR_PR=1 and hence emulate_step() will return -1 and hence we will
> > end up single-stepping using user_enable_single_step(). Same with rfid.
> 
> Right. But that was exactly Jim's point, you may be asked to emulate
> those instructions even though you wouldn't expect to see them in
> userspace code, so you need to handle it.
> 
> Luckily it looks like emulate_step() will do the right thing for you.
> It'd be good to test it to make 100% sure.

Sure. Will add that check and send v2.

Ananth
