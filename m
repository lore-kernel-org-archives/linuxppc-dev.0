Return-Path: <lukeb@br.ibm.com>
In-Reply-To: <OF4F3B9C35.BC785C15-ON8725723A.00427A16-8325723A.004462EA@us.ibm.com>
Subject: Re: [PATCH]Add notification for active Cell SPU tasks
To: Luke Browning <LukeBrowning@us.ibm.com>
Message-ID: <OF9A01B09B.B62F8342-ON8325723C.006A9343-8325723C.006B2236@us.ibm.com>
From: Luke Browning <lukeb@br.ibm.com>
Date: Wed, 6 Dec 2006 16:30:12 -0300
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=0CBBF8AFDFF915D38f9e8a93df938690918c0CBBF8AFDFF915D3"
Cc: maynardj@linux.vnet.ibm.com,
	linuxppc-dev-bounces+lukebrowning=us.ibm.com@ozlabs.org,
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

--0__=0CBBF8AFDFF915D38f9e8a93df938690918c0CBBF8AFDFF915D3
Content-type: text/plain; charset=US-ASCII





linuxppc-dev-bounces+lukebrowning=us.ibm.com@ozlabs.org wrote on 12/04/2006
10:26:57:

> linuxppc-dev-bounces+lukebrowning=us.ibm.com@ozlabs.org wrote on
> 01/12/2006 06:01:15 PM:
>
> >
> > Subject: Enable SPU switch notification to detect currently activeSPU
tasks.
> >
> > From: Maynard Johnson <maynardj@us.ibm.com>
> >
> > This patch adds to the capability of spu_switch_event_register to
notify the
> > caller of currently active SPU tasks.  It also exports
> > spu_switch_event_register
> > and spu_switch_event_unregister.
> >
> > Signed-off-by: Maynard Johnson <mpjohn@us.ibm.com>
> >
> >
> > Index: linux-2.6.19-rc6-
> > arnd1+patches/arch/powerpc/platforms/cell/spufs/sched.c
> > ===================================================================
> > --- linux-2.6.19-rc6-arnd1+patches.
> > orig/arch/powerpc/platforms/cell/spufs/sched.c   2006-11-24 11:34:
> > 44.884455680 -0600
> > +++ linux-2.6.19-rc6-
> > arnd1+patches/arch/powerpc/platforms/cell/spufs/sched.c   2006-12-01
> > 13:57:21.864583264 -0600
> > @@ -84,15 +84,37 @@
> >               ctx ? ctx->object_id : 0, spu);
> >  }
> >
> > +static void notify_spus_active(void)
> > +{
> > +   int node;
> > +   for (node = 0; node < MAX_NUMNODES; node++) {
> > +      struct spu *spu;
> > +      mutex_lock(&spu_prio->active_mutex[node]);
> > +      list_for_each_entry(spu, &spu_prio->active_list[node], list) {
> > +              struct spu_context *ctx = spu->ctx;
> > +              blocking_notifier_call_chain(&spu_switch_notifier,
> > +                     ctx ? ctx->object_id : 0, spu);
> > +      }
> > +      mutex_unlock(&spu_prio->active_mutex[node]);
> > +    }
> > +
> > +}
> > +
> >  int spu_switch_event_register(struct notifier_block * n)
> >  {
> > -   return blocking_notifier_chain_register(&spu_switch_notifier, n);
> > +   int ret;
> > +   ret = blocking_notifier_chain_register(&spu_switch_notifier, n);
> > +   if (!ret)
> > +      notify_spus_active();
> > +   return ret;
> >  }
> > +EXPORT_SYMBOL_GPL(spu_switch_event_register);
> >
> >  int spu_switch_event_unregister(struct notifier_block * n)
> >  {
> >     return blocking_notifier_chain_unregister(&spu_switch_notifier, n);
> >  }
> > +EXPORT_SYMBOL_GPL(spu_switch_event_unregister);
> >
> >
> >  static inline void bind_context(struct spu *spu, struct spu_context
*ctx)
>
> Is this really the right strategy?  First, it serializes all spu context
> switching at the node level.  Second, it performs 17 callouts for
> every context
> switch.  Can't oprofile internally derive the list of active spus from
the
> context switch callout.
>
> Also, the notify_spus_active() callout is dependent on the return code of

> spu_switch_notify().  Should notification be hierarchical?  If I
> only register
> for the second one, should my notification be dependent on the return
code
> of some non-related subsystem's handler.
>
> Does blocking_callchain_notifier internally check for the presence
> of registered
> handlers before it takes locks ...?  We should ensure that there is
> minimal overhead
> when there are no registered handlers.
>
> Regards,
> Luke___________________

Any comments to my questions above.  Seems like oprofile / pdt could derive
the
list of active spus from a single context switch callout.  This patch will
have
a large impact on the performance of the system.

Luke
--0__=0CBBF8AFDFF915D38f9e8a93df938690918c0CBBF8AFDFF915D3
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt>linuxppc-dev-bounces+lukebrowning=us.ibm.com@ozlabs.org wrote on 12/04/2006 10:26:57:<br>
<br>
&gt; linuxppc-dev-bounces+lukebrowning=us.ibm.com@ozlabs.org wrote on <br>
&gt; 01/12/2006 06:01:15 PM:<br>
&gt; <br>
&gt; &gt; <br>
&gt; &gt; Subject: Enable SPU switch notification to detect currently activeSPU tasks.<br>
&gt; &gt; <br>
&gt; &gt; From: Maynard Johnson &lt;maynardj@us.ibm.com&gt;<br>
&gt; &gt; <br>
&gt; &gt; This patch adds to the capability of spu_switch_event_register to notify the<br>
&gt; &gt; caller of currently active SPU tasks. &nbsp;It also exports <br>
&gt; &gt; spu_switch_event_register<br>
&gt; &gt; and spu_switch_event_unregister.<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Maynard Johnson &lt;mpjohn@us.ibm.com&gt;<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; Index: linux-2.6.19-rc6-<br>
&gt; &gt; arnd1+patches/arch/powerpc/platforms/cell/spufs/sched.c<br>
&gt; &gt; ===================================================================<br>
&gt; &gt; --- linux-2.6.19-rc6-arnd1+patches.<br>
&gt; &gt; orig/arch/powerpc/platforms/cell/spufs/sched.c &nbsp; 2006-11-24 11:34:<br>
&gt; &gt; 44.884455680 -0600<br>
&gt; &gt; +++ linux-2.6.19-rc6-<br>
&gt; &gt; arnd1+patches/arch/powerpc/platforms/cell/spufs/sched.c &nbsp; 2006-12-01<br>
&gt; &gt; 13:57:21.864583264 -0600<br>
&gt; &gt; @@ -84,15 +84,37 @@<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ctx ? ctx-&gt;object_id : 0, spu);<br>
&gt; &gt; &nbsp;}<br>
&gt; &gt; &nbsp;<br>
&gt; &gt; +static void notify_spus_active(void)<br>
&gt; &gt; +{<br>
&gt; &gt; + &nbsp; int node;<br>
&gt; &gt; + &nbsp; for (node = 0; node &lt; MAX_NUMNODES; node++) {<br>
&gt; &gt; + &nbsp; &nbsp; &nbsp;struct spu *spu;<br>
&gt; &gt; + &nbsp; &nbsp; &nbsp;mutex_lock(&amp;spu_prio-&gt;active_mutex[node]);<br>
&gt; &gt; + &nbsp; &nbsp; &nbsp;list_for_each_entry(spu, &amp;spu_prio-&gt;active_list[node], list) {<br>
&gt; &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct spu_context *ctx = spu-&gt;ctx;<br>
&gt; &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;blocking_notifier_call_chain(&amp;spu_switch_notifier,<br>
&gt; &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ctx ? ctx-&gt;object_id : 0, spu);<br>
&gt; &gt; + &nbsp; &nbsp; &nbsp;}<br>
&gt; &gt; + &nbsp; &nbsp; &nbsp;mutex_unlock(&amp;spu_prio-&gt;active_mutex[node]);<br>
&gt; &gt; + &nbsp; &nbsp;}<br>
&gt; &gt; +<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; &nbsp;int spu_switch_event_register(struct notifier_block * n)<br>
&gt; &gt; &nbsp;{<br>
&gt; &gt; - &nbsp; return blocking_notifier_chain_register(&amp;spu_switch_notifier, n);<br>
&gt; &gt; + &nbsp; int ret;<br>
&gt; &gt; + &nbsp; ret = blocking_notifier_chain_register(&amp;spu_switch_notifier, n);<br>
&gt; &gt; + &nbsp; if (!ret)<br>
&gt; &gt; + &nbsp; &nbsp; &nbsp;notify_spus_active();<br>
&gt; &gt; + &nbsp; return ret;<br>
&gt; &gt; &nbsp;}<br>
&gt; &gt; +EXPORT_SYMBOL_GPL(spu_switch_event_register);<br>
&gt; &gt; &nbsp;<br>
&gt; &gt; &nbsp;int spu_switch_event_unregister(struct notifier_block * n)<br>
&gt; &gt; &nbsp;{<br>
&gt; &gt; &nbsp; &nbsp; return blocking_notifier_chain_unregister(&amp;spu_switch_notifier, n);<br>
&gt; &gt; &nbsp;}<br>
&gt; &gt; +EXPORT_SYMBOL_GPL(spu_switch_event_unregister);<br>
&gt; &gt; &nbsp;<br>
&gt; &gt; &nbsp;<br>
&gt; &gt; &nbsp;static inline void bind_context(struct spu *spu, struct spu_context *ctx)<br>
&gt; <br>
&gt; Is this really the right strategy? &nbsp;First, it serializes all spu context <br>
&gt; switching at the node level. &nbsp;Second, it performs 17 callouts for <br>
&gt; every context<br>
&gt; switch. &nbsp;Can't oprofile internally derive the list of active spus from the &nbsp;<br>
&gt; context switch callout. &nbsp;<br>
&gt; <br>
&gt; Also, the notify_spus_active() callout is dependent on the return code of <br>
&gt; spu_switch_notify(). &nbsp;Should notification be hierarchical? &nbsp;If I <br>
&gt; only register <br>
&gt; for the second one, should my notification be dependent on the return code<br>
&gt; of some non-related subsystem's handler. &nbsp;<br>
&gt; <br>
&gt; Does blocking_callchain_notifier internally check for the presence <br>
&gt; of registered<br>
&gt; handlers before it takes locks ...? &nbsp;We should ensure that there is <br>
&gt; minimal overhead<br>
&gt; when there are no registered handlers.<br>
&gt; <br>
&gt; Regards,<br>
&gt; Luke___________________</tt><br>
<br>
<tt>Any comments to my questions above. &nbsp;Seems like oprofile / pdt could derive the </tt><br>
<tt>list of active spus from a single context switch callout. &nbsp;This patch will have</tt><br>
<tt>a large impact on the performance of the system. </tt><br>
<br>
<tt>Luke</tt></body></html>
--0__=0CBBF8AFDFF915D38f9e8a93df938690918c0CBBF8AFDFF915D3--
