Return-Path: <utz.bacher@de.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5D777B70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Jun 2009 21:22:32 +1000 (EST)
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.17.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 97567DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2009 21:22:27 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.1/8.13.1) with ESMTP id n5PBMMNA028801
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2009 11:22:22 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.2) with
	ESMTP id n5PBMMws3481810
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2009 13:22:22 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n5PBMMsJ024015
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2009 13:22:22 +0200
In-Reply-To: <20090611105216.GG8358@lisas.de>
To: Adrian Reber <adrian@lisas.de>
MIME-Version: 1.0
Subject: Re: [PATCH v2] Fix RTAS watchdog driver temperature read functionality
From: Utz Bacher <utz.bacher@de.ibm.com>
Message-ID: <OF3E26F577.90C4A946-ONC12575E0.003E09AB-C12575E0.003E67E9@de.ibm.com>
Date: Thu, 25 Jun 2009 13:22:19 +0200
Content-Type: multipart/alternative;
	boundary="=_alternative 003E5CB2C12575E0_="
Cc: linuxppc-dev-bounces+adrian=lisas.de@lists.ozlabs.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 003E5CB2C12575E0_=
Content-Type: text/plain; charset="US-ASCII"

Adrian Reber wrote on 11.06.2009 12:52:17:
> 
> I forgot about this patch. Can this still be merged?
> 
> 
> On Thu, Mar 26, 2009 at 01:05:42PM +0100, Adrian Reber wrote:
> > Using the RTAS watchdog driver to read out the temperature crashes
> > on a PXCAB:
> > 
> > Unable to handle kernel paging request for data at address 0xfe347b50
> > Faulting instruction address: 0xc00000000001af64
> > Oops: Kernel access of bad area, sig: 11 [#1]
> > 
> > The wrong usage of "(void *)__pa(&temperature)" in rtas_call() is
> > removed by using the function rtas_get_sensor() which does the
> > right thing.
> > 
> > Signed-off-by: Adrian Reber <adrian@lisas.de>
> > ---
> > v2: use rtas_get_sensor(); typo fixed
> > ---
> >  drivers/watchdog/wdrtas.c |    8 +++-----
> >  1 files changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/watchdog/wdrtas.c b/drivers/watchdog/wdrtas.c
> > index 5d3b1a8..a9f00dc 100644
> > --- a/drivers/watchdog/wdrtas.c
> > +++ b/drivers/watchdog/wdrtas.c
> > @@ -214,16 +214,14 @@ static void wdrtas_timer_keepalive(void)
> >   */
> >  static int wdrtas_get_temperature(void)
> >  {
> > -   long result;
> > +   int result;
> >     int temperature = 0;
> > 
> > -   result = rtas_call(wdrtas_token_get_sensor_state, 2, 2,
> > -            (void *)__pa(&temperature),
> > -            WDRTAS_THERMAL_SENSOR, 0);
> > +   result = rtas_get_sensor(WDRTAS_THERMAL_SENSOR, 0, &temperature);
> > 
> >     if (result < 0)
> >        printk(KERN_WARNING "wdrtas: reading the thermal sensor "
> > -             "faild: %li\n", result);
> > +             "failed: %i\n", result);
> >     else
> >        temperature = ((temperature * 9) / 5) + 32; /* fahrenheit */
> > 
> > -- 
> > 1.5.6.6

makes sense. Second version also looks good to me -- thanks!

Acked-by: Utz Bacher <utz.bacher@de.ibm.com>

Utz

:wq
--=_alternative 003E5CB2C12575E0_=
Content-Type: text/html; charset="US-ASCII"


<br><tt><font size=2>Adrian Reber wrote on 11.06.2009 12:52:17:</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; I forgot about this patch. Can this still be merged?<br>
&gt; <br>
&gt; <br>
&gt; On Thu, Mar 26, 2009 at 01:05:42PM +0100, Adrian Reber wrote:<br>
&gt; &gt; Using the RTAS watchdog driver to read out the temperature crashes<br>
&gt; &gt; on a PXCAB:<br>
&gt; &gt; <br>
&gt; &gt; Unable to handle kernel paging request for data at address 0xfe347b50<br>
&gt; &gt; Faulting instruction address: 0xc00000000001af64<br>
&gt; &gt; Oops: Kernel access of bad area, sig: 11 [#1]<br>
&gt; &gt; <br>
&gt; &gt; The wrong usage of &quot;(void *)__pa(&amp;temperature)&quot;
in rtas_call() is<br>
&gt; &gt; removed by using the function rtas_get_sensor() which does the<br>
&gt; &gt; right thing.<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Adrian Reber &lt;adrian@lisas.de&gt;<br>
&gt; &gt; ---<br>
&gt; &gt; v2: use rtas_get_sensor(); typo fixed<br>
&gt; &gt; ---<br>
&gt; &gt; &nbsp;drivers/watchdog/wdrtas.c | &nbsp; &nbsp;8 +++-----<br>
&gt; &gt; &nbsp;1 files changed, 3 insertions(+), 5 deletions(-)<br>
&gt; &gt; <br>
&gt; &gt; diff --git a/drivers/watchdog/wdrtas.c b/drivers/watchdog/wdrtas.c<br>
&gt; &gt; index 5d3b1a8..a9f00dc 100644<br>
&gt; &gt; --- a/drivers/watchdog/wdrtas.c<br>
&gt; &gt; +++ b/drivers/watchdog/wdrtas.c<br>
&gt; &gt; @@ -214,16 +214,14 @@ static void wdrtas_timer_keepalive(void)<br>
&gt; &gt; &nbsp; */<br>
&gt; &gt; &nbsp;static int wdrtas_get_temperature(void)<br>
&gt; &gt; &nbsp;{<br>
&gt; &gt; - &nbsp; long result;<br>
&gt; &gt; + &nbsp; int result;<br>
&gt; &gt; &nbsp; &nbsp; int temperature = 0;<br>
&gt; &gt; &nbsp;<br>
&gt; &gt; - &nbsp; result = rtas_call(wdrtas_token_get_sensor_state, 2,
2,<br>
&gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(void *)__pa(&amp;temperature),<br>
&gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;WDRTAS_THERMAL_SENSOR,
0);<br>
&gt; &gt; + &nbsp; result = rtas_get_sensor(WDRTAS_THERMAL_SENSOR, 0, &amp;temperature);<br>
&gt; &gt; &nbsp;<br>
&gt; &gt; &nbsp; &nbsp; if (result &lt; 0)<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp;printk(KERN_WARNING &quot;wdrtas:
reading the thermal sensor &quot;<br>
&gt; &gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;faild: %li\n&quot;,
result);<br>
&gt; &gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;failed: %i\n&quot;,
result);<br>
&gt; &gt; &nbsp; &nbsp; else<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp;temperature = ((temperature * 9) /
5) + 32; /* fahrenheit */<br>
&gt; &gt; &nbsp;<br>
&gt; &gt; -- <br>
&gt; &gt; 1.5.6.6<br>
</font></tt>
<br><tt><font size=2>makes sense. Second version also looks good to me
-- thanks!</font></tt>
<br>
<br><tt><font size=2>Acked-by: Utz Bacher &lt;utz.bacher@de.ibm.com&gt;</font></tt>
<br>
<br><tt><font size=2>Utz</font></tt>
<br>
<br><tt><font size=2>:wq</font></tt>
--=_alternative 003E5CB2C12575E0_=--
