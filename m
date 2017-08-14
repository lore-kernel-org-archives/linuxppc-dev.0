Return-Path: <breno.debian@gmail.com>
Received: from mail-qt0-f196.google.com (mail-qt0-f196.google.com
 [209.85.216.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWRYS0J7jzDr55
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 06:10:20 +1000 (AEST)
Received: by mail-qt0-f196.google.com with SMTP id c15so10635757qta.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 13:10:19 -0700 (PDT)
Date: Mon, 14 Aug 2017 17:10:09 -0300
From: Breno Leitao <leitao@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 1/2] powerpc/xmon: Dump ftrace buffers for the current
 CPU only
Message-ID: <20170814201007.2ovddznqow6qno56@gmail.com>
References: <1501704846-22625-1-git-send-email-leitao@debian.org>
 <87efseqp7s.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87efseqp7s.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Michael,

On Mon, Aug 14, 2017 at 11:00:07PM +1000, Michael Ellerman wrote:
> Breno Leitao <leitao@debian.org> writes:
> > @@ -2231,6 +2232,19 @@ static void xmon_rawdump (unsigned long adrs, long ndump)
> >  	printf("\n");
> >  }
> >  
> > +static void dump_tracing(void)
> > +{
> > +	int c;
> > +
> > +	c = inchar();
> > +	if (c == 'c')
> > +		ftrace_dump(DUMP_ORIG);
> > +	else
> > +		ftrace_dump(DUMP_ALL);
> > +
> > +	tracing_on();
> > +}
> 
> Thinking about this some more, two things that would make this *really*
> useful.
> 
> Firstly, it would be great if we could dump the buffer for *another*
> CPU. 

Well, you can do it with this new 'dtc' option on xmon. You just need to
change to that CPU prior to call 'dtc'.

Here is an example, where the exception is hit on cpu '0xa', but I want to dump
ftrace from CPU '0x1'.

   cpu 0xa: Vector: 700 (Program Check) at [c00000003ff47d40]
       pc: c00000000000c318: fast_exception_return+0xac/0x170
       lr: 00007fff9c4680dc
       sp: 7fff9c29e710
      msr: 8000000102a03031
     current = 0xc0000004216d9f80
     paca    = 0xc00000000fe02800	 softe: 0	 irq_happened: 0x01
       pid   = 893, comm = bad_kernel_stac
   Linux version 4.12.0+ (root@unstable) (gcc version 6.3.0 20170628 (Debian 6.3.0-21)) #18 SMP Mon Aug 7 20:18:39 EDT 2017
   WARNING: exception is not recoverable, can't continue
   enter ? for help
   SP (7fff9c29e710) is in userspace
   a:mon> dtc
   [  299.770536] Dumping ftrace buffer:
   [  299.770619] ---------------------------------
   [  299.770747] CPU:10 [LOST 7923885 EVENTS]
   [  299.770747]  10)   0.060 us    |    } /* msr_check_and_set */

   a:mon> c 1
   [link register   ] c0000000006f40e8 check_and_cede_processor+0x48/0x80
   [c0000004285dfd60] c000000000065378 return_to_handler+0x0/0x40 (unreliable)
   [c0000004285dfdc0] c000000000065378 return_to_handler+0x0/0x40
   [c0000004285dfdf0] c000000000065378 return_to_handler+0x0/0x40
   [c0000004285dfe50] c000000000065378 return_to_handler+0x0/0x40
   [c0000004285dfe90] c000000000065378 return_to_handler+0x0/0x40
   [c0000004285dff00] c000000000065378 return_to_handler+0x0/0x40
   [c0000004285dff30] c0000000000495a8 start_secondary+0x338/0x380
   [c0000004285dff90] c00000000000b46c start_secondary_prolog+0x10/0x14
   1:mon> dtc
   [  308.629183] Dumping ftrace buffer:
   [  308.629236] ---------------------------------
   [  308.629302] CPU:1 [LOST 16378 EVENTS]
   [  308.629302]   1)   0.044 us    | } /* __accumulate_pelt_segments */
   [  308.629388]   1)   4.326 us    | } /* __update_load_avg_cfs_rq.isra.3 */
   [  308.629459]   1)   0.058 us    | update_cfs_shares();
   [  308.629522]   1)   0.108 us    | account_entity_enqueue();
   [  308.629583]   1)   0.048 us    | place_entity();
   [  308.629637]   1)   0.078 us    | __enqueue_entity();
   .....
   

> Currently ftrace_dump() doesn't support that, and maybe it can't
> because of the ring buffer design (?), but it would be really great if
> you could dump another CPU's buffer.

Well, you can just dump the buffer for all CPU, using ftrace_dump(DUMP_ALL) or
just the current CPU, using ftrace_dump(DUMP_ORIG). Since it can dump a CPU
buffer specifically, I am wondering what would happen if we assign any CPU to
iter.cpu_file.

> That would be great eg. when a CPU is stuck and doesn't come into xmon,
> you could use the trace buffer to work out where it is. You can do it
> now, by dumping the whole trace buffer, but it's quite tricky to spot
> that one CPU amongst all the others.

Well, with this new 'dtc' feature you can do it easily. Just invoke 'xmon',
change to the stuck CPU and print the ftrace for that CPU. Not very straight
forward but doable.

But if we can do it from a ftrace userspace that would be easier, yes! :-)

> The second thing that would be good is if dumping the trace buffer from
> xmon didn't consume the trace. Currently if you do 'dt' to dump the
> trace buffer, and then realise actually you should have just dumped it
> for one CPU then you're out of luck.
> 
> So it'd be nice if we could dump but leave the trace intact. That would
> also be good from an "xmon doesn't perturb the system" (too much) point
> of view, ie. if you drop to xmon and dump the trace then currently the
> trace is no longer available.

I agree with this concern and definitely it concerns me when I try to dump the
buffer again and I get "(ftrace buffer empty)". I will try to address this
also.
