Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 938C61A0CD7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 04:44:10 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Fri, 1 May 2015 00:14:07 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 1C0E03940048
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 00:14:04 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3UIi4mr1573274
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 00:14:04 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3UIi3ni020746
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 00:14:03 +0530
Message-ID: <554277F1.9050006@linux.vnet.ibm.com>
Date: Fri, 01 May 2015 00:14:01 +0530
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 1/8] powerpc/powernv: Add a virtual irqchip for opal
 events
References: <1428654294-9177-1-git-send-email-alistair@popple.id.au>
In-Reply-To: <1428654294-9177-1-git-send-email-alistair@popple.id.au>
Content-Type: multipart/alternative;
 boundary="------------030203060009010709060008"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030203060009010709060008
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alistair,

Applied all of the patches on top of 'v4.0-rc7', found this issue during
the boot itself http://pastebin.hursley.ibm.com/918.

There are few compile warnings and minor comments.

drivers/tty/hvc/hvc_opal.c: In function ‘hvc_opal_probe’:
drivers/tty/hvc/hvc_opal.c:174:6: warning: unused variable ‘rc’ 
[-Wunused-variable]
   int rc;
       ^
drivers/tty/hvc/hvc_opal.c: At top level:
drivers/tty/hvc/hvc_opal.c:65:13: warning: ‘hvc_opal_event_registered’ 
defined but not used [-Wunused-variable]
  static bool hvc_opal_event_registered;

Regards,
Neelesh.

On 04/10/2015 01:54 PM, Alistair Popple wrote:
> Whenever an interrupt is received for opal the linux kernel gets a
> bitfield indicating certain events that have occurred and need handling
> by the various device drivers. Currently this is handled using a
> notifier interface where we call every device driver that has
> registered to receive opal events.
>
> This approach has several drawbacks. For example each driver has to do
> its own checking to see if the event is relevant as well as event
> masking. There is also no easy method of recording the number of times
> we receive particular events.
>
> This patch solves these issues by exposing opal events via the
> standard interrupt APIs by adding a new interrupt chip and
> domain. Drivers can then register for the appropriate events using
> standard kernel calls such as irq_of_parse_and_map().
>
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> ---
>
> +static int __init opal_event_init(void)
> +{
> +	struct device_node *dn, *opal_node;
> +	const __be32 *irqs;
> +	int i, irqlen;
> +
> +	opal_node = of_find_node_by_path("/ibm,opal");
> +	if (!opal_node) {
> +		pr_warn("opal: Node not found\n");
> +		return -ENODEV;
> +	}
> +
> +	dn = of_find_compatible_node(NULL, NULL, "ibm,opal-event");
> +
> +	/* If dn is NULL it means the domain won't be linked to a DT
> +	 * node so therefore irq_of_parse_and_map(...) wont work. But
> +	 * that shouldn't be problem because if we're running a
> +	 * version of skiboot that doesn't have the dn then the
> +	 * devices won't have the correct properties and will have to
> +	 * fall back to the legacy method (opal_event_request(...))
> +	 * anyway. */
> +	opal_event_irqchip.domain =
> +		irq_domain_add_linear(dn, 64, &opal_event_domain_ops,

A macro would be better, which is maximum event bits we have.

> +				      &opal_event_irqchip);
> +	if (IS_ERR(opal_event_irqchip.domain)) {
> +		pr_warn("opal: Unable to create irq domain\n");
> +		return PTR_ERR(opal_event_irqchip.domain);
> +	}
> +
> +	/* Get interrupt property */
> +	irqs = of_get_property(opal_node, "opal-interrupts", &irqlen);
> +	opal_irq_count = irqs ? (irqlen / 4) : 0;

of_node_put()
Need to decrement the refcount of these nodes, 'opal_node' & 'dn' (if !NULL)

> +	pr_debug("Found %d interrupts reserved for OPAL\n", opal_irq_count);
> +
> +	/* Install interrupt handlers */
> +	opal_irqs = kcalloc(opal_irq_count, sizeof(unsigned int), GFP_KERNEL);

Safe to use 'sizeof(*opal_irqs)'

> +	for (i = 0; irqs && i < opal_irq_count; i++, irqs++) {
> +		unsigned int irq, virq;
> +		int rc;
> +
> +		/* Get hardware and virtual IRQ */
> +		irq = be32_to_cpup(irqs);
> +		virq = irq_create_mapping(NULL, irq);
> +		if (virq == NO_IRQ) {
> +			pr_warn("Failed to map irq 0x%x\n", irq);
> +			continue;
> +		}
> +
> +		/* Install interrupt handler */
> +		rc = request_irq(virq, opal_interrupt, 0, "opal", NULL);
> +		if (rc) {
> +			irq_dispose_mapping(virq);
> +			pr_warn("Error %d requesting irq %d (0x%x)\n",
> +				 rc, virq, irq);
> +			continue;
> +		}
> +
> +		/* Cache IRQ */
> +		opal_irqs[i] = virq;
> +	}
> +
> +	return 0;
> +}
> +machine_core_initcall(powernv, opal_event_init);
> +
>


--------------030203060009010709060008
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <font size="-1">Hi Alistair,<br>
      <br>
      Applied all of the patches on top of 'v4.0-rc7', found this issue
      during<br>
      the boot itself <a class="moz-txt-link-freetext" href="http://pastebin.hursley.ibm.com/918">http://pastebin.hursley.ibm.com/918</a>.<br>
      <br>
      There are few compile warnings and minor comments.<br>
      <br>
      drivers/tty/hvc/hvc_opal.c: In function ‘hvc_opal_probe’:<br>
      drivers/tty/hvc/hvc_opal.c:174:6: warning: unused variable ‘rc’
      [-Wunused-variable]<br>
        int rc; <br>
            ^   <br>
      drivers/tty/hvc/hvc_opal.c: At top level:<br>
      drivers/tty/hvc/hvc_opal.c:65:13: warning:
      ‘hvc_opal_event_registered’ defined but not used
      [-Wunused-variable]<br>
       static bool hvc_opal_event_registered;<br>
      <br>
      Regards,<br>
      Neelesh.<br>
    </font><br>
    <div class="moz-cite-prefix">On 04/10/2015 01:54 PM, Alistair Popple
      wrote:<br>
    </div>
    <blockquote
      cite="mid:1428654294-9177-1-git-send-email-alistair@popple.id.au"
      type="cite">
      <pre wrap="">Whenever an interrupt is received for opal the linux kernel gets a
bitfield indicating certain events that have occurred and need handling
by the various device drivers. Currently this is handled using a
notifier interface where we call every device driver that has
registered to receive opal events.

This approach has several drawbacks. For example each driver has to do
its own checking to see if the event is relevant as well as event
masking. There is also no easy method of recording the number of times
we receive particular events.

This patch solves these issues by exposing opal events via the
standard interrupt APIs by adding a new interrupt chip and
domain. Drivers can then register for the appropriate events using
standard kernel calls such as irq_of_parse_and_map().

Signed-off-by: Alistair Popple <a class="moz-txt-link-rfc2396E" href="mailto:alistair@popple.id.au">&lt;alistair@popple.id.au&gt;</a>
---

+static int __init opal_event_init(void)
+{
+	struct device_node *dn, *opal_node;
+	const __be32 *irqs;
+	int i, irqlen;
+
+	opal_node = of_find_node_by_path("/ibm,opal");
+	if (!opal_node) {
+		pr_warn("opal: Node not found\n");
+		return -ENODEV;
+	}
+
+	dn = of_find_compatible_node(NULL, NULL, "ibm,opal-event");
+
+	/* If dn is NULL it means the domain won't be linked to a DT
+	 * node so therefore irq_of_parse_and_map(...) wont work. But
+	 * that shouldn't be problem because if we're running a
+	 * version of skiboot that doesn't have the dn then the
+	 * devices won't have the correct properties and will have to
+	 * fall back to the legacy method (opal_event_request(...))
+	 * anyway. */
+	opal_event_irqchip.domain =
+		irq_domain_add_linear(dn, 64, &amp;opal_event_domain_ops,</pre>
    </blockquote>
    <br>
    <small>A macro would be better, which is maximum event bits we have.</small><br>
    <br>
    <blockquote
      cite="mid:1428654294-9177-1-git-send-email-alistair@popple.id.au"
      type="cite">
      <pre wrap="">
+				      &amp;opal_event_irqchip);
+	if (IS_ERR(opal_event_irqchip.domain)) {
+		pr_warn("opal: Unable to create irq domain\n");
+		return PTR_ERR(opal_event_irqchip.domain);
+	}
+
+	/* Get interrupt property */
+	irqs = of_get_property(opal_node, "opal-interrupts", &amp;irqlen);
+	opal_irq_count = irqs ? (irqlen / 4) : 0;</pre>
    </blockquote>
    <br>
    <small>of_node_put()</small><br>
    <font size="-1">Need to decrement the refcount of these nodes,
      'opal_node' &amp; 'dn' (if !NULL)<br>
    </font><br>
    <blockquote
      cite="mid:1428654294-9177-1-git-send-email-alistair@popple.id.au"
      type="cite">
      <pre wrap="">
+	pr_debug("Found %d interrupts reserved for OPAL\n", opal_irq_count);
+
+	/* Install interrupt handlers */
+	opal_irqs = kcalloc(opal_irq_count, sizeof(unsigned int), GFP_KERNEL);</pre>
    </blockquote>
    <br>
    <small>Safe to use 'sizeof(*opal_irqs)'</small><br>
    <br>
    <blockquote
      cite="mid:1428654294-9177-1-git-send-email-alistair@popple.id.au"
      type="cite">
      <pre wrap="">
+	for (i = 0; irqs &amp;&amp; i &lt; opal_irq_count; i++, irqs++) {
+		unsigned int irq, virq;
+		int rc;
+
+		/* Get hardware and virtual IRQ */
+		irq = be32_to_cpup(irqs);
+		virq = irq_create_mapping(NULL, irq);
+		if (virq == NO_IRQ) {
+			pr_warn("Failed to map irq 0x%x\n", irq);
+			continue;
+		}
+
+		/* Install interrupt handler */
+		rc = request_irq(virq, opal_interrupt, 0, "opal", NULL);
+		if (rc) {
+			irq_dispose_mapping(virq);
+			pr_warn("Error %d requesting irq %d (0x%x)\n",
+				 rc, virq, irq);
+			continue;
+		}
+
+		/* Cache IRQ */
+		opal_irqs[i] = virq;
+	}
+
+	return 0;
+}
+machine_core_initcall(powernv, opal_event_init);
+

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------030203060009010709060008--
