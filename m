Return-Path: <deebuls@gmail.com>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by ozlabs.org (Postfix) with ESMTP id BFAEAB70B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Sep 2010 18:15:16 +1000 (EST)
Received: by gwj15 with SMTP id 15so85924gwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Sep 2010 01:15:13 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 22 Sep 2010 13:45:12 +0530
Message-ID: <AANLkTikkM0HJHdTd5j9bRaW9uN8OsJcN9O99GAHtPQ18@mail.gmail.com>
Subject: external interrupt mapping with FPGA on loacl bus
From: deebul nair <deebuls@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=0016362838dea81b890490d4be93
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016362838dea81b890490d4be93
Content-Type: text/plain; charset=ISO-8859-1

Hi

i have a FPGA called mcmc which is connected to the powerpc mpc8572 on the
local bus. It provides 2 interrupts which are connected to the
external interupts IRQ1 and IRQ3 of the mpc8572.
the fpga is memory mapped on the local bus at address 0xc0000000
I am able to register the interrupt and obtain virq , but no interrupts.
is the modifications made in the dts file enought/right for getting an
external interrupt??


*The modified dts file for enrm8572*

localbus@e0005000 {


#address-cells = <2>;

#size-cells = <1>;

compatible = "fsl,mpc8572-elbc", "fsl,elbc", "simple-bus";

reg = <0xe0005000 0x1000>;

interrupts = <19 2>;

interrupt-parent = <&mpic>;

ranges = <0x0 0x0 0xfc000000 0x04000000

0x1 0x0 0xc0000000 0x00080000

0x2 0x0 0x90100000 0x00008000

0x3 0x0 0x90000000 0x00040000

0x4 0x0 0x91000000 0x00008000>;

nand@3,0 {

#address-cells = <1>;

#size-cells = <1>;

compatible = "fsl,mpc8572-fcm-nand",

"fsl,elbc-fcm-nand";

reg = <0x3 0x0 0x40000>;

u-boot@0 {

reg = <0x0 0x02000000>;

read-only;

};

jffs2@2000000 {

reg = <0x02000000 0x10000000>;

};

ramdisk@12000000 {

reg = <0x12000000 0x08000000>;

read-only;

};

kernel@1a000000 {

reg = <0x1a000000 0x04000000>;

};

dtb@1e000000 {

reg = <0x1e000000 0x01000000>;

read-only;

};

empty@1f000000 {

reg = <0x1f000000 0x21000000>;

};

};



*mcmc@1,0 {*
* *
*compatible = "fsl,fpga-pixis";*
* *
*reg = <1 0 32>;*
* *
*interrupts = <1 1 3 1>;*
* *
*interrupt-parent = <&mpic>;*

};


};

*code for registering the interrupt :*

np = of_find_compatible_node(NULL, NULL, "fsl,fpga-pixis");

mcmc_irq = irq;

virq = irq_of_parse_and_map(np, mcmc_irq);

if(virq == NO_IRQ){

printk(KERN_ERR "mcmc: failed to map interrupt");

}

printk(KERN_INFO "mcmc: interrupt mapped to virq %d\n", virq);

ret = request_irq(virq, mcmc_interrupt, IRQF_DISABLED,"mcmc", NULL);

if(ret){

printk(KERN_INFO "mcmc : cant get assigned irq %i\n errno :
<%d>\n",mcmc_irq,ret);

}

else{

printk(KERN_ALERT "Interrupt requested OK\n");

}

d :

*when i register the driver the following output is obtaine*

*for irq=1*

irq_of_parse_and_map

irq : irq_create_mapping(0xc0fffb40,0x1)

irq : using host @ c0fffb40

irq : obtained virq 18

irq : virq=12 <6>mcmc : interrupt mapped to irq 18

Interrupt requested OK!

*for irq=0*

irq_of_parse_and_map

irq : irq_create_mapping(0xc0fffb40,0x3)

irq : using host @ c0fffb40

irq : obtained virq 20

irq : virq=14 <6>mcmc : interrupt mapped to irq 20

Interrupt requested OK!





--
Cheeers

Deebul !!!!!!

--0016362838dea81b890490d4be93
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>=A0</div>
<div>Hi</div>
<div>=A0</div>
<div>i have a FPGA called mcmc which is connected to the powerpc mpc8572 on=
 the local bus. It provides 2 interrupts which are connected to the</div>
<div>external interupts IRQ1 and IRQ3 of the mpc8572.</div>
<div>the fpga is memory mapped on the local bus at address <font face=3D"Co=
urier New">0xc0000000 </font></div>
<div>I am able to register the interrupt and obtain virq , but no interrupt=
s.</div>
<div>is the modifications made in the dts file enought/right for getting an=
 external interrupt??</div>
<div>=A0</div>
<div>=A0</div>
<div><strong>The modified dts file for enrm8572</strong></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">localbus@e0005000 {</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<blockquote dir=3D"ltr" style=3D"MARGIN-RIGHT: 0px">
<div><font face=3D"courier new,monospace">#address-cells =3D &lt;2&gt;;</fo=
nt></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">#size-cells =3D &lt;1&gt;;</font>=
</div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">compatible =3D &quot;fsl,mpc8572-=
elbc&quot;, &quot;fsl,elbc&quot;, &quot;simple-bus&quot;;</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">reg =3D &lt;0xe0005000 0x1000&gt;=
;</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">interrupts =3D &lt;19 2&gt;;</fon=
t></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">interrupt-parent =3D &lt;&amp;mpi=
c&gt;;</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">ranges =3D &lt;0x0 0x0 0xfc000000=
 0x04000000</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">0x1 0x0 0xc0000000 0x00080000</fo=
nt></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">0x2 0x0 0x90100000 0x00008000</fo=
nt></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">0x3 0x0 0x90000000 0x00040000</fo=
nt></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">0x4 0x0 0x91000000 0x00008000&gt;=
;</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">nand@3,0 {</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">#address-cells =3D &lt;1&gt;;</fo=
nt></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">#size-cells =3D &lt;1&gt;;</font>=
</div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">compatible =3D &quot;fsl,mpc8572-=
fcm-nand&quot;,</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">&quot;fsl,elbc-fcm-nand&quot;;</f=
ont></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">reg =3D &lt;0x3 0x0 0x40000&gt;;<=
/font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">u-boot@0 {</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">reg =3D &lt;0x0 0x02000000&gt;;</=
font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">read-only;</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">};</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">jffs2@2000000 {</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">reg =3D &lt;0x02000000 0x10000000=
&gt;;</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">};</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">ramdisk@12000000 {</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">reg =3D &lt;0x12000000 0x08000000=
&gt;;</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">read-only;</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">};</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">kernel@1a000000 {</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">reg =3D &lt;0x1a000000 0x04000000=
&gt;;</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">};</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">dtb@1e000000 {</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">reg =3D &lt;0x1e000000 0x01000000=
&gt;;</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">read-only;</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">};</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">empty@1f000000 {</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">reg =3D &lt;0x1f000000 0x21000000=
&gt;;</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">};</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">};</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><strong><font style=3D"BACKGROUND-COLOR: #ffff33" face=3D"courier new,=
monospace">mcmc@1,0 {</font></strong></div>
<div><strong><font style=3D"BACKGROUND-COLOR: #ffff33" face=3D"courier new,=
monospace">=A0</font></strong></div>
<div><strong><font style=3D"BACKGROUND-COLOR: #ffff33" face=3D"courier new,=
monospace">compatible =3D &quot;fsl,fpga-pixis&quot;;</font></strong></div>
<div><strong><font style=3D"BACKGROUND-COLOR: #ffff33" face=3D"courier new,=
monospace">=A0</font></strong></div>
<div><strong><font style=3D"BACKGROUND-COLOR: #ffff33" face=3D"courier new,=
monospace">reg =3D &lt;1 0 32&gt;;</font></strong></div>
<div><strong><font style=3D"BACKGROUND-COLOR: #ffff33" face=3D"courier new,=
monospace">=A0</font></strong></div>
<div><strong><font style=3D"BACKGROUND-COLOR: #ffff33" face=3D"courier new,=
monospace">interrupts =3D &lt;1 1 3 1&gt;;</font></strong></div>
<div><strong><font style=3D"BACKGROUND-COLOR: #ffff33" face=3D"courier new,=
monospace">=A0</font></strong></div>
<div><strong><font style=3D"BACKGROUND-COLOR: #ffff33" face=3D"courier new,=
monospace">interrupt-parent =3D &lt;&amp;mpic&gt;;</font></strong></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">};</font></div></blockquote>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">};</font></div>
<div>=A0</div>
<div><strong>code for registering the interrupt :</strong></div>
<div>=A0</div>
<div><font face=3D"courier new,monospace">np =3D of_find_compatible_node(NU=
LL, NULL, &quot;fsl,fpga-pixis&quot;);</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">mcmc_irq =3D irq;</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">virq =3D irq_of_parse_and_map(np,=
 mcmc_irq);</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">if(virq =3D=3D NO_IRQ){</font></d=
iv>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">printk(KERN_ERR &quot;mcmc: faile=
d to map interrupt&quot;);</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">}</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">printk(KERN_INFO &quot;mcmc: inte=
rrupt mapped to virq %d\n&quot;, virq);</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">ret =3D request_irq(virq, mcmc_in=
terrupt, IRQF_DISABLED,&quot;mcmc&quot;, NULL);</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">if(ret){</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">printk(KERN_INFO &quot;mcmc : can=
t get assigned irq %i\n errno : &lt;%d&gt;\n&quot;,mcmc_irq,ret);</font></d=
iv>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">}</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">else{</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">printk(KERN_ALERT &quot;Interrupt=
 requested OK\n&quot;);</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">}</font></div>
<div>=A0</div>
<div>d :</div>
<div>=A0</div>
<div><strong>when i register the driver the following output is obtaine</st=
rong></div>
<div>=A0</div>
<div><strong>for irq=3D1</strong></div>
<div>=A0</div>
<div><font face=3D"courier new,monospace">irq_of_parse_and_map</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">irq : irq_create_mapping(0xc0fffb=
40,0x1)</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">irq : using host @ c0fffb40</font=
></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">irq : obtained virq 18</font></di=
v>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">irq : virq=3D12 &lt;6&gt;mcmc : i=
nterrupt mapped to irq 18</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">Interrupt requested OK!</font></d=
iv>
<div>=A0</div>
<div><strong>for irq=3D0</strong></div>
<div>=A0</div>
<div><font face=3D"courier new,monospace">irq_of_parse_and_map</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">irq : irq_create_mapping(0xc0fffb=
40,0x3)</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">irq : using host @ c0fffb40</font=
></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">irq : obtained virq 20</font></di=
v>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">irq : virq=3D14 &lt;6&gt;mcmc : i=
nterrupt mapped to irq 20</font></div>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div><font face=3D"courier new,monospace">Interrupt requested OK!</font></d=
iv>
<div><font face=3D"courier new,monospace">=A0</font></div>
<div>=A0</div>
<div>=A0</div>
<div>=A0</div>
<div>=A0</div>
<div>--</div>
<div>Cheeers</div>
<div>=A0</div>
<div>Deebul !!!!!!</div>
<div>=A0</div>
<div>=A0</div>

--0016362838dea81b890490d4be93--
