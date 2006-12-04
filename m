Return-Path: <LukeBrowning@us.ibm.com>
In-Reply-To: <45708A0B.6000106@us.ibm.com>
Subject: Re: [PATCH]Add notification for active Cell SPU tasks
To: maynardj@linux.vnet.ibm.com
Message-ID: <OF4F3B9C35.BC785C15-ON8725723A.00427A16-8325723A.004462EA@us.ibm.com>
From: Luke Browning <LukeBrowning@us.ibm.com>
Date: Mon, 4 Dec 2006 09:26:57 -0300
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=08BBF8A9DFD1FC868f9e8a93df938690918c08BBF8A9DFD1FC86"
Cc: linuxppc-dev@ozlabs.org,
	linuxppc-dev-bounces+lukebrowning=us.ibm.com@ozlabs.org,
	cbe-oss-dev@ozlabs.org, oprofile-list@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0__=08BBF8A9DFD1FC868f9e8a93df938690918c08BBF8A9DFD1FC86
Content-type: text/plain; charset=US-ASCII







linuxppc-dev-bounces+lukebrowning=us.ibm.com@ozlabs.org wrote on 01/12/2006
06:01:15 PM:

>
> Subject: Enable SPU switch notification to detect currently active SPU
tasks.
>
> From: Maynard Johnson <maynardj@us.ibm.com>
>
> This patch adds to the capability of spu_switch_event_register to notify
the
> caller of currently active SPU tasks.  It also exports
> spu_switch_event_register
> and spu_switch_event_unregister.
>
> Signed-off-by: Maynard Johnson <mpjohn@us.ibm.com>
>
>
> Index: linux-2.6.19-rc6-
> arnd1+patches/arch/powerpc/platforms/cell/spufs/sched.c
> ===================================================================
> --- linux-2.6.19-rc6-arnd1+patches.
> orig/arch/powerpc/platforms/cell/spufs/sched.c   2006-11-24 11:34:
> 44.884455680 -0600
> +++ linux-2.6.19-rc6-
> arnd1+patches/arch/powerpc/platforms/cell/spufs/sched.c   2006-12-01
> 13:57:21.864583264 -0600
> @@ -84,15 +84,37 @@
>               ctx ? ctx->object_id : 0, spu);
>  }
>
> +static void notify_spus_active(void)
> +{
> +   int node;
> +   for (node = 0; node < MAX_NUMNODES; node++) {
> +      struct spu *spu;
> +      mutex_lock(&spu_prio->active_mutex[node]);
> +      list_for_each_entry(spu, &spu_prio->active_list[node], list) {
> +              struct spu_context *ctx = spu->ctx;
> +              blocking_notifier_call_chain(&spu_switch_notifier,
> +                     ctx ? ctx->object_id : 0, spu);
> +      }
> +      mutex_unlock(&spu_prio->active_mutex[node]);
> +    }
> +
> +}
> +
>  int spu_switch_event_register(struct notifier_block * n)
>  {
> -   return blocking_notifier_chain_register(&spu_switch_notifier, n);
> +   int ret;
> +   ret = blocking_notifier_chain_register(&spu_switch_notifier, n);
> +   if (!ret)
> +      notify_spus_active();
> +   return ret;
>  }
> +EXPORT_SYMBOL_GPL(spu_switch_event_register);
>
>  int spu_switch_event_unregister(struct notifier_block * n)
>  {
>     return blocking_notifier_chain_unregister(&spu_switch_notifier, n);
>  }
> +EXPORT_SYMBOL_GPL(spu_switch_event_unregister);
>
>
>  static inline void bind_context(struct spu *spu, struct spu_context
*ctx)

Is this really the right strategy?  First, it serializes all spu context
switching at the node level.  Second, it performs 17 callouts for every
context
switch.  Can't oprofile internally derive the list of active spus from the
context switch callout.

Also, the notify_spus_active() callout is dependent on the return code of
spu_switch_notify().  Should notification be hierarchical?  If I only
register
for the second one, should my notification be dependent on the return code
of some non-related subsystem's handler.

Does blocking_callchain_notifier internally check for the presence of
registered
handlers before it takes locks ...?  We should ensure that there is minimal
overhead
when there are no registered handlers.

Regards,
Luke
--0__=08BBF8A9DFD1FC868f9e8a93df938690918c08BBF8A9DFD1FC86
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt>linuxppc-dev-bounces+lukebrowning=us.ibm.com@ozlabs.org wrote on 01/12/2006 06:01:15 PM:<br>
<br>
&gt; <br>
&gt; Subject: Enable SPU switch notification to detect currently active SPU tasks.<br>
&gt; <br>
&gt; From: Maynard Johnson &lt;maynardj@us.ibm.com&gt;<br>
&gt; <br>
&gt; This patch adds to the capability of spu_switch_event_register to notify the<br>
&gt; caller of currently active SPU tasks. &nbsp;It also exports <br>
&gt; spu_switch_event_register<br>
&gt; and spu_switch_event_unregister.<br>
&gt; <br>
&gt; Signed-off-by: Maynard Johnson &lt;mpjohn@us.ibm.com&gt;<br>
&gt; <br>
&gt; <br>
&gt; Index: linux-2.6.19-rc6-<br>
&gt; arnd1+patches/arch/powerpc/platforms/cell/spufs/sched.c<br>
&gt; ===================================================================<br>
&gt; --- linux-2.6.19-rc6-arnd1+patches.<br>
&gt; orig/arch/powerpc/platforms/cell/spufs/sched.c &nbsp; 2006-11-24 11:34:<br>
&gt; 44.884455680 -0600<br>
&gt; +++ linux-2.6.19-rc6-<br>
&gt; arnd1+patches/arch/powerpc/platforms/cell/spufs/sched.c &nbsp; 2006-12-01<br>
&gt; 13:57:21.864583264 -0600<br>
&gt; @@ -84,15 +84,37 @@<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ctx ? ctx-&gt;object_id : 0, spu);<br>
&gt; &nbsp;}<br>
&gt; &nbsp;<br>
&gt; +static void notify_spus_active(void)<br>
&gt; +{<br>
&gt; + &nbsp; int node;<br>
&gt; + &nbsp; for (node = 0; node &lt; MAX_NUMNODES; node++) {<br>
&gt; + &nbsp; &nbsp; &nbsp;struct spu *spu;<br>
&gt; + &nbsp; &nbsp; &nbsp;mutex_lock(&amp;spu_prio-&gt;active_mutex[node]);<br>
&gt; + &nbsp; &nbsp; &nbsp;list_for_each_entry(spu, &amp;spu_prio-&gt;active_list[node], list) {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct spu_context *ctx = spu-&gt;ctx;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;blocking_notifier_call_chain(&amp;spu_switch_notifier,<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ctx ? ctx-&gt;object_id : 0, spu);<br>
&gt; + &nbsp; &nbsp; &nbsp;}<br>
&gt; + &nbsp; &nbsp; &nbsp;mutex_unlock(&amp;spu_prio-&gt;active_mutex[node]);<br>
&gt; + &nbsp; &nbsp;}<br>
&gt; +<br>
&gt; +}<br>
&gt; +<br>
&gt; &nbsp;int spu_switch_event_register(struct notifier_block * n)<br>
&gt; &nbsp;{<br>
&gt; - &nbsp; return blocking_notifier_chain_register(&amp;spu_switch_notifier, n);<br>
&gt; + &nbsp; int ret;<br>
&gt; + &nbsp; ret = blocking_notifier_chain_register(&amp;spu_switch_notifier, n);<br>
&gt; + &nbsp; if (!ret)<br>
&gt; + &nbsp; &nbsp; &nbsp;notify_spus_active();<br>
&gt; + &nbsp; return ret;<br>
&gt; &nbsp;}<br>
&gt; +EXPORT_SYMBOL_GPL(spu_switch_event_register);<br>
&gt; &nbsp;<br>
&gt; &nbsp;int spu_switch_event_unregister(struct notifier_block * n)<br>
&gt; &nbsp;{<br>
&gt; &nbsp; &nbsp; return blocking_notifier_chain_unregister(&amp;spu_switch_notifier, n);<br>
&gt; &nbsp;}<br>
&gt; +EXPORT_SYMBOL_GPL(spu_switch_event_unregister);<br>
&gt; &nbsp;<br>
&gt; &nbsp;<br>
&gt; &nbsp;static inline void bind_context(struct spu *spu, struct spu_context *ctx)<br>
</tt><br>
<tt>Is this really the right strategy? &nbsp;First, it serializes all spu context </tt><br>
<tt>switching at the node level. &nbsp;Second, it performs 17 callouts for every context</tt><br>
<tt>switch. &nbsp;Can't oprofile internally derive the list of active spus from the &nbsp;</tt><br>
<tt>context switch callout. &nbsp;</tt><br>
<br>
<tt>Also, the notify_spus_active() callout is dependent on the return code of </tt><br>
<tt>spu_switch_notify(). &nbsp;Should notification be hierarchical? &nbsp;If I only register </tt><br>
<tt>for the second one, should my notification be dependent on the return code</tt><br>
<tt>of some non-related subsystem's handler. &nbsp;</tt><br>
<br>
<tt>Does blocking_callchain_notifier internally check for the presence of registered</tt><br>
<tt>handlers before it takes locks ...? &nbsp;We should ensure that there is minimal overhead</tt><br>
<tt>when there are no registered handlers.</tt><br>
<br>
<tt>Regards,</tt><br>
<tt>Luke</tt><br>
</body></html>
--0__=08BBF8A9DFD1FC868f9e8a93df938690918c08BBF8A9DFD1FC86--
