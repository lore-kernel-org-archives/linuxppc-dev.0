Return-Path: <michael@ellerman.id.au>
Message-ID: <1339137497.25573.9.camel@concordia>
Subject: Re: [PATCH 2/2] [POWERPC] uprobes: powerpc port
From: Michael Ellerman <michael@ellerman.id.au>
To: ananth@in.ibm.com
Date: Fri, 08 Jun 2012 16:38:17 +1000
In-Reply-To: <20120608061954.GE13409@in.ibm.com>
References: <20120606091950.GB6745@in.ibm.com>
 <20120606092150.GC6745@in.ibm.com> <1338974822.2749.89.camel@twins>
 <20120606093541.GA29580@in.ibm.com> <1339006084.3458.25.camel@localhost>
 <20120608043605.GB13409@in.ibm.com> <1339134714.25573.4.camel@concordia>
 <20120608060104.GD13409@in.ibm.com> <1339136264.25573.7.camel@concordia>
 <20120608061954.GE13409@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Jim Keniston <jkenisto@linux.vnet.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 oleg@redhat.com, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-06-08 at 11:49 +0530, Ananth N Mavinakayanahalli wrote:
> On Fri, Jun 08, 2012 at 04:17:44PM +1000, Michael Ellerman wrote:
> > On Fri, 2012-06-08 at 11:31 +0530, Ananth N Mavinakayanahalli wrote:
> > > On Fri, Jun 08, 2012 at 03:51:54PM +1000, Michael Ellerman wrote:
> > > > On Fri, 2012-06-08 at 10:06 +0530, Ananth N Mavinakayanahalli wrote:
> > > 
> > > But MSR_PR=1 and hence emulate_step() will return -1 and hence we will
> > > end up single-stepping using user_enable_single_step(). Same with rfid.
> > 
> > Right. But that was exactly Jim's point, you may be asked to emulate
> > those instructions even though you wouldn't expect to see them in
> > userspace code, so you need to handle it.
> > 
> > Luckily it looks like emulate_step() will do the right thing for you.
> > It'd be good to test it to make 100% sure.
> 
> Sure. Will add that check and send v2.

Sorry I didn't mean add a test in the code, I meant construct a test
case to confirm that it works as expected.

cheers
