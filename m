Return-Path: <ken.williams@dslextreme.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.168])
	by ozlabs.org (Postfix) with ESMTP id 987B0DE1B8
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 16:15:54 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so942924wfg.15
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 21:15:52 -0800 (PST)
Message-ID: <601774780901142115v688a2c76p619dfb80b72f5ea8@mail.gmail.com>
Date: Wed, 14 Jan 2009 21:15:52 -0800
From: "Ken Williams" <ken@williamsclan.us>
Sender: ken.williams@dslextreme.com
To: linuxppc-dev@ozlabs.org
Subject: interrupt number assignment dts file help
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_7306_12770401.1231996552832"
Reply-To: ken@williamsclan.us
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_7306_12770401.1231996552832
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am trying to configure a dts file for the pci subsystem of a MPC8540 based
system.

I am expecting (hoping) that the value specified in the interrupts property
(98 in this example)
will be used as the virtual interrupt number and that I can later do a
request_irq using that number.

kernel: 2.6.26.3

The board level configuration is:
 ADR29 connected to IDSEL
 using INTA# only
 The PCI interrupt is connected to external IRQ2

What I see is that inside irq_create_mapping, a call to irq_find_mapping
produces a null virq,
so irq_alloc_virt is called and comes back with x12.  Can I assign the
number to 98 (x62)
using the dts?  Any help would be greatly appreciated.

Thanks

Ken

        pci0: pci@fdf08000 {
                cell-index = <0>;
                interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
                interrupt-map = <

                        /* IDSEL 0x1d */
                        0xe800 0x0 0x0 0x1 &mpic 0x2 0x1
                                                        >;
                interrupt-parent = <&mpic>;
                interrupts = <98 2>;
                bus-range = <0 0>;
                ranges = <0x2000000 0x0 0x80000000 0x80000000 0x0 0x20000000
                          0x1000000 0x0 0x0 0xe2000000 0x0 0x100000>;
                clock-frequency = <66666666>;
                #interrupt-cells = <1>;
                #size-cells = <2>;
                #address-cells = <3>;
                reg = <0xfdf08000 0x1000>;
                compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
                device_type = "pci";
        };

------=_Part_7306_12770401.1231996552832
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am trying to configure a dts file for the pci subsystem of a MPC8540 based system.<br><br>I am expecting (hoping) that the value specified in the interrupts property (98 in this example)<br>will be used as the virtual interrupt number and that I can later do a request_irq using that number.<br>
<br>kernel: 2.6.26.3<br><br>The board level configuration is:<br>&nbsp;ADR29 connected to IDSEL<br>&nbsp;using INTA# only<br>&nbsp;The PCI interrupt is connected to external IRQ2<br><br>What I see is that inside irq_create_mapping, a call to irq_find_mapping produces a null virq,<br>
so irq_alloc_virt is called and comes back with x12.&nbsp; Can I assign the number to 98 (x62)<br>using the dts?&nbsp; Any help would be greatly appreciated.<br><br>Thanks<br><br>Ken<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci0: pci@fdf08000 {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cell-index = &lt;0&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-map-mask = &lt;0xf800 0x0 0x0 0x7&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-map = &lt;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IDSEL 0x1d */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xe800 0x0 0x0 0x1 &amp;mpic 0x2 0x1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-parent = &lt;&amp;mpic&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts = &lt;98 2&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bus-range = &lt;0 0&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges = &lt;0x2000000 0x0 0x80000000 0x80000000 0x0 0x20000000<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1000000 0x0 0x0 0xe2000000 0x0 0x100000&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock-frequency = &lt;66666666&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #interrupt-cells = &lt;1&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells = &lt;2&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells = &lt;3&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg = &lt;0xfdf08000 0x1000&gt;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible = &quot;fsl,mpc8540-pcix&quot;, &quot;fsl,mpc8540-pci&quot;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type = &quot;pci&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br><br>

------=_Part_7306_12770401.1231996552832--
