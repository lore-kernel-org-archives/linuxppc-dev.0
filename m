Return-Path: <alan@akb.net>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.226])
	by ozlabs.org (Postfix) with ESMTP id 4494BDDE24
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 05:55:32 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so533831nzh
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 12:55:30 -0700 (PDT)
Message-ID: <bfa0697f0710221255ubbe8c91pa09640f9b9cd0775@mail.gmail.com>
Date: Mon, 22 Oct 2007 13:55:29 -0600
From: "Alan Bennett" <embedded@akb.net>
Sender: alan@akb.net
To: linuxppc-dev@ozlabs.org
Subject: Re: request_irq fails to get interrupt 12
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok, so what does it take to expose an interrupt vector on a pq2 PIC??
-Alan

Current:
        /
              localbus{
        ...
 	       fundevice1 {
		       interrupts = <c 8>;
		       interrupt-parent = <&PIC>;
	       };
          ...
               soc@e0000000 {
                      PIC: interrupt-controller@10c00 {
                          #interrupt-cells = <2>;
                          interrupt-controller;
                          reg = <10c00 80>;
                          compatible = "fsl,mpc8248-pic", "fsl,pq2-pic";
                        };
Is the above device tree enough on its own?
Do I have to write some platform code beyond:
  static void __init ep8248_pic_init(void)
  {
	struct device_node *np = of_find_compatible_node(NULL,   NULL, "fsl,pq2-pic");
	if (!np) {
		printk(KERN_ERR "PIC init: can not find cpm-pic node\n");
		return;
	}

	cpm2_pic_init(np);
	of_node_put(np);
}

-Alan

Hello,

> Freescale experts.  Why on earth can't I request the IRQ for Timer1?

Please consule my question on [1] and the answers.

[1] http://ozlabs.org/pipermail/linuxppc-dev/2007-September/042061.html

bye
Silvio Fricke

--
-- S. Fricke ----------------------------- MAILTO:silvio.fricke@gmail.com --
   Diplom-Informatiker (FH)
   Linux-Entwicklung
----------------------------------------------------------------------------
