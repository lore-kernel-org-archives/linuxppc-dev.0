Return-Path: <LukeBrowning@us.ibm.com>
In-Reply-To: <45797EFE.3040008@us.ibm.com>
Subject: Re: [Cbe-oss-dev] [PATCH]Add notification for active Cell SPU tasks
To: maynardj@linux.vnet.ibm.com
Message-ID: <OFD47C2157.B38B81D4-ON8325723E.00687BA3-8325723E.0069669F@us.ibm.com>
From: Luke Browning <LukeBrowning@us.ibm.com>
Date: Fri, 8 Dec 2006 16:11:15 -0300
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=0CBBF8ADDFFBFD338f9e8a93df938690918c0CBBF8ADDFFBFD33"
Cc: maynardj@linux.vnet.ibm.com, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	oprofile-list@lists.sourceforge.net, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0__=0CBBF8ADDFFBFD338f9e8a93df938690918c0CBBF8ADDFFBFD33
Content-type: text/plain; charset=US-ASCII







maynardj@linux.vnet.ibm.com wrote on 08/12/2006 01:04:30 PM:

> Arnd Bergmann wrote:
>
> >On Wednesday 06 December 2006 23:04, Maynard Johnson wrote:
> >
> >No code should ever need to look at other SPUs when performing an
> >operation on a given SPU, so we don't need to hold a global lock
> >during normal operation.
> >
> >We have two cases that need to be handled:
> >
> >- on each context unload and load (both for a full switch operation),
> >  call to the profiling code with a pointer to the current context
> >  and spu (context is NULL when unloading).
> >
> >  If the new context is not know yet, scan its overlay table (expensive)
> >  and store information about it in an oprofile private object.
Otherwise
> >  just point to the currently active object, this should be really
cheap.
> >
> >- When enabling oprofile initially, scan all contexts that are currently
> >  running on one of the SPUs. This is also expensive, but should happen
> >  before the measurement starts so it does not impact the resulting
data.
> >

Agreed.

<snip>

> >>I'm not exactly sure what you're saying here.  Are you suggesting that
a
> >>user may only be interested in acitve SPU notification and, therefore,
> >>shouldn't have to be depenent on the "standard" notification
> >>registration succeeding?  There may be a case for adding a new
> >>registration function, I suppose; although, I'm not aware of any other
> >>users of the SPUFS notification mechanism besides OProfile and PDT, and

> >>we need notification of both active and future SPU tasks.  But I would
> >>not object to a new function.
> >>
> >>
> >>
> >I think what Luke was trying to get to is that notify_spus_active()
should
> >not call blocking_notifier_call_chain(), since it will notify other
users
> >as well as the newly registered one. Instead, it can simply call the
> >notifier function directly.
> >
> >
> Ah, yes.  Thanks to both of you for pointing that out.  I'll fix that
> and re-post.
>
> -Maynard
>

I actually was hoping to take this one step further.  If the interface to
the context switch handler is something like:

switch_handler(int spu_id, from_ctx, to_ctx)

The kernel extension can maintain an internal spu table of its own where it
marks the named spuid as active or not.  You don't need to have a bunch of
individual calls.  Internally, you can keep track of it yourself.

Luke
--0__=0CBBF8ADDFFBFD338f9e8a93df938690918c0CBBF8ADDFFBFD33
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt>maynardj@linux.vnet.ibm.com wrote on 08/12/2006 01:04:30 PM:<br>
<br>
&gt; Arnd Bergmann wrote:<br>
&gt; <br>
&gt; &gt;On Wednesday 06 December 2006 23:04, Maynard Johnson wrote:<br>
&gt; &gt; &nbsp;<br>
&gt; &gt;No code should ever need to look at other SPUs when performing an<br>
&gt; &gt;operation on a given SPU, so we don't need to hold a global lock<br>
&gt; &gt;during normal operation.<br>
&gt; &gt;<br>
&gt; &gt;We have two cases that need to be handled:<br>
&gt; &gt;<br>
&gt; &gt;- on each context unload and load (both for a full switch operation),<br>
&gt; &gt; &nbsp;call to the profiling code with a pointer to the current context<br>
&gt; &gt; &nbsp;and spu (context is NULL when unloading).<br>
&gt; &gt;<br>
&gt; &gt; &nbsp;If the new context is not know yet, scan its overlay table (expensive)<br>
&gt; &gt; &nbsp;and store information about it in an oprofile private object. Otherwise<br>
&gt; &gt; &nbsp;just point to the currently active object, this should be really cheap.<br>
&gt; &gt;<br>
&gt; &gt;- When enabling oprofile initially, scan all contexts that are currently<br>
&gt; &gt; &nbsp;running on one of the SPUs. This is also expensive, but should happen<br>
&gt; &gt; &nbsp;before the measurement starts so it does not impact the resulting data.<br>
&gt; &gt;<br>
</tt><br>
<tt>Agreed. &nbsp;</tt><br>
<br>
<tt>&lt;snip&gt;</tt><br>
<br>
<tt>&gt; &gt;&gt;I'm not exactly sure what you're saying here. &nbsp;Are you suggesting that a <br>
&gt; &gt;&gt;user may only be interested in acitve SPU notification and, therefore, <br>
&gt; &gt;&gt;shouldn't have to be depenent on the &quot;standard&quot; notification <br>
&gt; &gt;&gt;registration succeeding? &nbsp;There may be a case for adding a new <br>
&gt; &gt;&gt;registration function, I suppose; although, I'm not aware of any other <br>
&gt; &gt;&gt;users of the SPUFS notification mechanism besides OProfile and PDT, and <br>
&gt; &gt;&gt;we need notification of both active and future SPU tasks. &nbsp;But I would <br>
&gt; &gt;&gt;not object to a new function.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &nbsp; &nbsp;<br>
&gt; &gt;&gt;<br>
&gt; &gt;I think what Luke was trying to get to is that notify_spus_active() should<br>
&gt; &gt;not call blocking_notifier_call_chain(), since it will notify other users<br>
&gt; &gt;as well as the newly registered one. Instead, it can simply call the<br>
&gt; &gt;notifier function directly.<br>
&gt; &gt; &nbsp;<br>
&gt; &gt;<br>
&gt; Ah, yes. &nbsp;Thanks to both of you for pointing that out. &nbsp;I'll fix that <br>
&gt; and re-post.<br>
&gt; <br>
&gt; -Maynard<br>
&gt; <br>
</tt><br>
<tt>I actually was hoping to take this one step further. &nbsp;If the interface to</tt><br>
<tt>the context switch handler is something like:</tt><br>
<br>
<tt>switch_handler(int spu_id, from_ctx, to_ctx)</tt><br>
<br>
<tt>The kernel extension can maintain an internal spu table of its own where it</tt><br>
<tt>marks the named spuid as active or not. &nbsp;You don't need to have a bunch of</tt><br>
<tt>individual calls. &nbsp;Internally, you can keep track of it yourself.</tt><br>
<br>
<tt>Luke</tt></body></html>
--0__=0CBBF8ADDFFBFD338f9e8a93df938690918c0CBBF8ADDFFBFD33--
