Return-Path: <THEMANN@de.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7036ADDFC2
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 01:58:31 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id m59FvfDv276992
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jun 2008 15:57:41 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m59FvfaF3239984
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jun 2008 17:57:41 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m59FvfWU016970
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jun 2008 17:57:41 +0200
In-Reply-To: <200806091744.30930.ossrosch@linux.vnet.ibm.com>
To: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] ibmebus: Change ibmebus_request_irq() to optionally
	return irq number
Message-ID: <OFC3E0A15A.DF2AB379-ONC1257463.00579444-C1257463.005792DD@de.ibm.com>
From: Jan-Bernd Themann <THEMANN@de.ibm.com>
Date: Mon, 9 Jun 2008 17:57:39 +0200
Content-Type: multipart/alternative;
	boundary="=_alternative 005792D8C1257463_="
Cc: Thomas Q Klein <TKLEIN@de.ibm.com>, Joachim Fenkes <fenkes@de.ibm.com>,
	OF-EWG <ewg@lists.openfabrics.org>, LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 005792D8C1257463_=
Content-Type: text/plain; charset="US-ASCII"

Stefan Roscher <ossrosch@linux.vnet.ibm.com> wrote on 09.06.2008 17:44:29:

> Signed-off-by: Stefan Roscher <stefan.roscher@de.ibm.com>
> ---
>  arch/powerpc/kernel/ibmebus.c        |    5 ++++-
>  drivers/infiniband/hw/ehca/ehca_eq.c |    4 ++--
>  drivers/net/ehea/ehea_main.c         |    6 +++---
>  include/asm-powerpc/ibmebus.h        |    2 +-
>  4 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/ibmebus.c 
b/arch/powerpc/kernel/ibmebus.c
> index 9971159..a002fdf 100644
> --- a/arch/powerpc/kernel/ibmebus.c
> +++ b/arch/powerpc/kernel/ibmebus.c
> @@ -208,7 +208,7 @@ void ibmebus_unregister_driver(struct 
> of_platform_driver *drv)
>  }
>  EXPORT_SYMBOL(ibmebus_unregister_driver);
> 
> -int ibmebus_request_irq(u32 ist, irq_handler_t handler,
> +int ibmebus_request_irq(u32 ist, int *irq_number, irq_handler_t 
handler,
>           unsigned long irq_flags, const char *devname,
>           void *dev_id)
>  {
> @@ -217,6 +217,9 @@ int ibmebus_request_irq(u32 ist, irq_handler_t 
handler,
>     if (irq == NO_IRQ)
>        return -EINVAL;
> 
> +   if (irq_number)
> +      *irq_number = irq;
> +
>     return request_irq(irq, handler, irq_flags, devname, dev_id);
>  }
>  EXPORT_SYMBOL(ibmebus_request_irq);
> diff --git a/drivers/infiniband/hw/ehca/ehca_eq.c 
> b/drivers/infiniband/hw/ehca/ehca_eq.c
> index 49660df..5bc494f 100644
> --- a/drivers/infiniband/hw/ehca/ehca_eq.c
> +++ b/drivers/infiniband/hw/ehca/ehca_eq.c
> @@ -122,7 +122,7 @@ int ehca_create_eq(struct ehca_shca *shca,
> 
>     /* register interrupt handlers and initialize work queues */
>     if (type == EHCA_EQ) {
> -      ret = ibmebus_request_irq(eq->ist, ehca_interrupt_eq,
> +      ret = ibmebus_request_irq(eq->ist, NULL, ehca_interrupt_eq,
>                   IRQF_DISABLED, "ehca_eq",
>                   (void *)shca);
>        if (ret < 0)
> @@ -130,7 +130,7 @@ int ehca_create_eq(struct ehca_shca *shca,
> 
>        tasklet_init(&eq->interrupt_task, ehca_tasklet_eq, (long)shca);
>     } else if (type == EHCA_NEQ) {
> -      ret = ibmebus_request_irq(eq->ist, ehca_interrupt_neq,
> +      ret = ibmebus_request_irq(eq->ist, NULL, ehca_interrupt_neq,
>                   IRQF_DISABLED, "ehca_neq",
>                   (void *)shca);
>        if (ret < 0)
> diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
> index 287a619..102ffeb 100644
> --- a/drivers/net/ehea/ehea_main.c
> +++ b/drivers/net/ehea/ehea_main.c
> @@ -1216,7 +1216,7 @@ static int ehea_reg_interrupts(struct net_device 
*dev)
>     snprintf(port->int_aff_name, EHEA_IRQ_NAME_SIZE - 1, "%s-aff",
>         dev->name);
> 
> -   ret = ibmebus_request_irq(port->qp_eq->attr.ist1,
> +   ret = ibmebus_request_irq(port->qp_eq->attr.ist1, NULL,
>                ehea_qp_aff_irq_handler,
>                IRQF_DISABLED, port->int_aff_name, port);
>     if (ret) {
> @@ -1234,7 +1234,7 @@ static int ehea_reg_interrupts(struct net_device 
*dev)
>        pr = &port->port_res[i];
>        snprintf(pr->int_send_name, EHEA_IRQ_NAME_SIZE - 1,
>            "%s-queue%d", dev->name, i);
> -      ret = ibmebus_request_irq(pr->eq->attr.ist1,
> +      ret = ibmebus_request_irq(pr->eq->attr.ist1, NULL,
>                   ehea_recv_irq_handler,
>                   IRQF_DISABLED, pr->int_send_name,
>                   pr);
> @@ -3414,7 +3414,7 @@ static int __devinit ehea_probe_adapter(struct
> of_device *dev,
>     tasklet_init(&adapter->neq_tasklet, ehea_neq_tasklet,
>             (unsigned long)adapter);
> 
> -   ret = ibmebus_request_irq(adapter->neq->attr.ist1,
> +   ret = ibmebus_request_irq(adapter->neq->attr.ist1, NULL,
>                ehea_interrupt_neq, IRQF_DISABLED,
>                "ehea_neq", adapter);
>     if (ret) {
> diff --git a/include/asm-powerpc/ibmebus.h 
b/include/asm-powerpc/ibmebus.h
> index 1a9d9ae..3a2618a 100644
> --- a/include/asm-powerpc/ibmebus.h
> +++ b/include/asm-powerpc/ibmebus.h
> @@ -51,7 +51,7 @@ extern struct bus_type ibmebus_bus_type;
>  int ibmebus_register_driver(struct of_platform_driver *drv);
>  void ibmebus_unregister_driver(struct of_platform_driver *drv);
> 
> -int ibmebus_request_irq(u32 ist, irq_handler_t handler,
> +int ibmebus_request_irq(u32 ist, int *irq_number, irq_handler_t 
handler,
>           unsigned long irq_flags, const char *devname,
>           void *dev_id);
>  void ibmebus_free_irq(u32 ist, void *dev_id);
> -- 
> 1.5.5
> 

Concerning the eHEA part:

Acked-by: Jan-Bernd Themann <themann@de.ibm.com>

Regards,
Jan-Bernd

--=_alternative 005792D8C1257463_=
Content-Type: text/html; charset="US-ASCII"


<br><tt><font size=2>Stefan Roscher &lt;ossrosch@linux.vnet.ibm.com&gt;
wrote on 09.06.2008 17:44:29:<br>
<br>
&gt; Signed-off-by: Stefan Roscher &lt;stefan.roscher@de.ibm.com&gt;<br>
&gt; ---<br>
&gt; &nbsp;arch/powerpc/kernel/ibmebus.c &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp;
&nbsp;5 ++++-<br>
&gt; &nbsp;drivers/infiniband/hw/ehca/ehca_eq.c | &nbsp; &nbsp;4 ++--<br>
&gt; &nbsp;drivers/net/ehea/ehea_main.c &nbsp; &nbsp; &nbsp; &nbsp; | &nbsp;
&nbsp;6 +++---<br>
&gt; &nbsp;include/asm-powerpc/ibmebus.h &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp;
&nbsp;2 +-<br>
&gt; &nbsp;4 files changed, 10 insertions(+), 7 deletions(-)<br>
&gt; <br>
&gt; diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c<br>
&gt; index 9971159..a002fdf 100644<br>
&gt; --- a/arch/powerpc/kernel/ibmebus.c<br>
&gt; +++ b/arch/powerpc/kernel/ibmebus.c<br>
&gt; @@ -208,7 +208,7 @@ void ibmebus_unregister_driver(struct <br>
&gt; of_platform_driver *drv)<br>
&gt; &nbsp;}<br>
&gt; &nbsp;EXPORT_SYMBOL(ibmebus_unregister_driver);<br>
&gt; &nbsp;<br>
&gt; -int ibmebus_request_irq(u32 ist, irq_handler_t handler,<br>
&gt; +int ibmebus_request_irq(u32 ist, int *irq_number, irq_handler_t handler,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; unsigned long irq_flags, const
char *devname,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; void *dev_id)<br>
&gt; &nbsp;{<br>
&gt; @@ -217,6 +217,9 @@ int ibmebus_request_irq(u32 ist, irq_handler_t
handler,<br>
&gt; &nbsp; &nbsp; if (irq == NO_IRQ)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;return -EINVAL;<br>
&gt; &nbsp;<br>
&gt; + &nbsp; if (irq_number)<br>
&gt; + &nbsp; &nbsp; &nbsp;*irq_number = irq;<br>
&gt; +<br>
&gt; &nbsp; &nbsp; return request_irq(irq, handler, irq_flags, devname,
dev_id);<br>
&gt; &nbsp;}<br>
&gt; &nbsp;EXPORT_SYMBOL(ibmebus_request_irq);<br>
&gt; diff --git a/drivers/infiniband/hw/ehca/ehca_eq.c <br>
&gt; b/drivers/infiniband/hw/ehca/ehca_eq.c<br>
&gt; index 49660df..5bc494f 100644<br>
&gt; --- a/drivers/infiniband/hw/ehca/ehca_eq.c<br>
&gt; +++ b/drivers/infiniband/hw/ehca/ehca_eq.c<br>
&gt; @@ -122,7 +122,7 @@ int ehca_create_eq(struct ehca_shca *shca,<br>
&gt; &nbsp;<br>
&gt; &nbsp; &nbsp; /* register interrupt handlers and initialize work queues
*/<br>
&gt; &nbsp; &nbsp; if (type == EHCA_EQ) {<br>
&gt; - &nbsp; &nbsp; &nbsp;ret = ibmebus_request_irq(eq-&gt;ist, ehca_interrupt_eq,<br>
&gt; + &nbsp; &nbsp; &nbsp;ret = ibmebus_request_irq(eq-&gt;ist, NULL,
ehca_interrupt_eq,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; IRQF_DISABLED,
&quot;ehca_eq&quot;,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (void
*)shca);<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;if (ret &lt; 0)<br>
&gt; @@ -130,7 +130,7 @@ int ehca_create_eq(struct ehca_shca *shca,<br>
&gt; &nbsp;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;tasklet_init(&amp;eq-&gt;interrupt_task,
ehca_tasklet_eq, (long)shca);<br>
&gt; &nbsp; &nbsp; } else if (type == EHCA_NEQ) {<br>
&gt; - &nbsp; &nbsp; &nbsp;ret = ibmebus_request_irq(eq-&gt;ist, ehca_interrupt_neq,<br>
&gt; + &nbsp; &nbsp; &nbsp;ret = ibmebus_request_irq(eq-&gt;ist, NULL,
ehca_interrupt_neq,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; IRQF_DISABLED,
&quot;ehca_neq&quot;,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (void
*)shca);<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;if (ret &lt; 0)<br>
&gt; diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c<br>
&gt; index 287a619..102ffeb 100644<br>
&gt; --- a/drivers/net/ehea/ehea_main.c<br>
&gt; +++ b/drivers/net/ehea/ehea_main.c<br>
&gt; @@ -1216,7 +1216,7 @@ static int ehea_reg_interrupts(struct net_device
*dev)<br>
&gt; &nbsp; &nbsp; snprintf(port-&gt;int_aff_name, EHEA_IRQ_NAME_SIZE -
1, &quot;%s-aff&quot;,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; dev-&gt;name);<br>
&gt; &nbsp;<br>
&gt; - &nbsp; ret = ibmebus_request_irq(port-&gt;qp_eq-&gt;attr.ist1,<br>
&gt; + &nbsp; ret = ibmebus_request_irq(port-&gt;qp_eq-&gt;attr.ist1, NULL,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ehea_qp_aff_irq_handler,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;IRQF_DISABLED,
port-&gt;int_aff_name, port);<br>
&gt; &nbsp; &nbsp; if (ret) {<br>
&gt; @@ -1234,7 +1234,7 @@ static int ehea_reg_interrupts(struct net_device
*dev)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;pr = &amp;port-&gt;port_res[i];<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;snprintf(pr-&gt;int_send_name, EHEA_IRQ_NAME_SIZE
- 1,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;%s-queue%d&quot;, dev-&gt;name,
i);<br>
&gt; - &nbsp; &nbsp; &nbsp;ret = ibmebus_request_irq(pr-&gt;eq-&gt;attr.ist1,<br>
&gt; + &nbsp; &nbsp; &nbsp;ret = ibmebus_request_irq(pr-&gt;eq-&gt;attr.ist1,
NULL,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ehea_recv_irq_handler,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; IRQF_DISABLED,
pr-&gt;int_send_name,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; pr);<br>
&gt; @@ -3414,7 +3414,7 @@ static int __devinit ehea_probe_adapter(struct<br>
&gt; of_device *dev,<br>
&gt; &nbsp; &nbsp; tasklet_init(&amp;adapter-&gt;neq_tasklet, ehea_neq_tasklet,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (unsigned long)adapter);<br>
&gt; &nbsp;<br>
&gt; - &nbsp; ret = ibmebus_request_irq(adapter-&gt;neq-&gt;attr.ist1,<br>
&gt; + &nbsp; ret = ibmebus_request_irq(adapter-&gt;neq-&gt;attr.ist1,
NULL,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ehea_interrupt_neq,
IRQF_DISABLED,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;ehea_neq&quot;,
adapter);<br>
&gt; &nbsp; &nbsp; if (ret) {<br>
&gt; diff --git a/include/asm-powerpc/ibmebus.h b/include/asm-powerpc/ibmebus.h<br>
&gt; index 1a9d9ae..3a2618a 100644<br>
&gt; --- a/include/asm-powerpc/ibmebus.h<br>
&gt; +++ b/include/asm-powerpc/ibmebus.h<br>
&gt; @@ -51,7 +51,7 @@ extern struct bus_type ibmebus_bus_type;<br>
&gt; &nbsp;int ibmebus_register_driver(struct of_platform_driver *drv);<br>
&gt; &nbsp;void ibmebus_unregister_driver(struct of_platform_driver *drv);<br>
&gt; &nbsp;<br>
&gt; -int ibmebus_request_irq(u32 ist, irq_handler_t handler,<br>
&gt; +int ibmebus_request_irq(u32 ist, int *irq_number, irq_handler_t handler,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; unsigned long irq_flags, const
char *devname,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; void *dev_id);<br>
&gt; &nbsp;void ibmebus_free_irq(u32 ist, void *dev_id);<br>
&gt; -- <br>
&gt; 1.5.5<br>
&gt; </font></tt>
<br>
<br><tt><font size=2>Concerning the eHEA part:</font></tt>
<br>
<br><tt><font size=2>Acked-by: Jan-Bernd Themann &lt;themann@de.ibm.com&gt;</font></tt>
<br>
<br><tt><font size=2>Regards,<br>
Jan-Bernd<br>
</font></tt>
--=_alternative 005792D8C1257463_=--
