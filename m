Return-Path: <HPENNER@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 03971DDDFC
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 02:32:58 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id l1GFWsae036432
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 15:32:54 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l1GFWsbB2080818
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 16:32:54 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l1GFWrsY008186
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 16:32:54 +0100
In-Reply-To: <1171575668.5644.42.camel@localhost.localdomain>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0
Subject: RE: [PATCH 15/16] Add device tree for Ebony
Message-ID: <OF87DD26C1.7685D06A-ONC1257284.00552F00-C1257284.00556891@de.ibm.com>
From: Hartmut Penner <HPENNER@de.ibm.com>
Date: Fri, 16 Feb 2007 16:32:52 +0100
Content-Type: multipart/alternative;
	boundary="=_alternative 0055688EC1257284_="
Cc: linuxppc-dev@ozlabs.org, Heiko J Schick <SCHICKHJ@de.ibm.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 0055688EC1257284_=
Content-Type: text/plain; charset="US-ASCII"

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 15.02.2007 
22:41:08:

> 
> > Is there a DCR binding?  Are the dcr-* properties documented 
> > anywhere:
> > 
> > dcr-reg         // what do these fields mean?
> > dcr-parent      // in case there is more than one controller??
> > dcr-controller
> > dcr-access-method = "native"   // what are the other options?
> 
> Yes, we wrote a binding document though I can't find it now. Hartmut or
> Heiko, do you have the latest DCR binding document at hand ?

I found some draft. It is as you discribed here. I need to check, how 
close this
is to what we did at last. Also we need place were we can publish such a 
document ...

> 
> dcr-reg is akin to "reg", it is a list of [dcr numbers, number of dcr]
> for a device.
> 
> dcr-parent is a phandle to the dcr "controller" or "master" that
> generate the DCR cycles
> 
> dcr-controller is like "interrupt-controller", it's a property to slap
> into any node that is also a dcr-controller. Typically, this can be the
> core for a 4xx processor or a separate device for Axon
> 
> dcr-access-method can be "native" for 4xx or "mmio" for Axon-type MMIO
> mapped DCR bus.
> 
> The parent linkage is necessary when using things ike Axon since more
> than one Axon can be present in a system, thus more than one MMIO->DCR
> "converters" providing each a separate DCR space for controller a
> separate set of devices.
> 
> Ben
> 

--=_alternative 0055688EC1257284_=
Content-Type: text/html; charset="US-ASCII"


<br>
<br><tt><font size=2>Benjamin Herrenschmidt &lt;benh@kernel.crashing.org&gt;
wrote on 15.02.2007 22:41:08:<br>
<br>
&gt; <br>
&gt; &gt; Is there a DCR binding? &nbsp;Are the dcr-* properties documented
<br>
&gt; &gt; anywhere:<br>
&gt; &gt; <br>
&gt; &gt; dcr-reg &nbsp; &nbsp; &nbsp; &nbsp; // what do these fields mean?<br>
&gt; &gt; dcr-parent &nbsp; &nbsp; &nbsp;// in case there is more than
one controller??<br>
&gt; &gt; dcr-controller<br>
&gt; &gt; dcr-access-method = &quot;native&quot; &nbsp; // what are the
other options?<br>
&gt; <br>
&gt; Yes, we wrote a binding document though I can't find it now. Hartmut
or<br>
&gt; Heiko, do you have the latest DCR binding document at hand ?<br>
</font></tt>
<br><tt><font size=2>I found some draft. It is as you discribed here. I
need to check, how close this</font></tt>
<br><tt><font size=2>is to what we did at last. Also we need place were
we can publish such a document ...</font></tt>
<br>
<br><tt><font size=2>&gt; <br>
&gt; dcr-reg is akin to &quot;reg&quot;, it is a list of [dcr numbers,
number of dcr]<br>
&gt; for a device.<br>
&gt; <br>
&gt; dcr-parent is a phandle to the dcr &quot;controller&quot; or &quot;master&quot;
that<br>
&gt; generate the DCR cycles<br>
&gt; <br>
&gt; dcr-controller is like &quot;interrupt-controller&quot;, it's a property
to slap<br>
&gt; into any node that is also a dcr-controller. Typically, this can be
the<br>
&gt; core for a 4xx processor or a separate device for Axon<br>
&gt; <br>
&gt; dcr-access-method can be &quot;native&quot; for 4xx or &quot;mmio&quot;
for Axon-type MMIO<br>
&gt; mapped DCR bus.<br>
&gt; <br>
&gt; The parent linkage is necessary when using things ike Axon since more<br>
&gt; than one Axon can be present in a system, thus more than one MMIO-&gt;DCR<br>
&gt; &quot;converters&quot; providing each a separate DCR space for controller
a<br>
&gt; separate set of devices.<br>
&gt; <br>
&gt; Ben<br>
&gt; <br>
</font></tt>
--=_alternative 0055688EC1257284_=--
