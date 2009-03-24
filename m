Return-Path: <utz.bacher@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 42FADDDF66
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 01:31:41 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.14.3/8.13.8) with ESMTP id n2OEVXUD190092
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 14:31:33 GMT
Received: from d12av06.megacenter.de.ibm.com (d12av06.megacenter.de.ibm.com
	[9.149.165.230])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.2) with
	ESMTP id n2OEVXpZ4292852
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 15:31:33 +0100
Received: from d12av06.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av06.megacenter.de.ibm.com (8.13.1/8.13.3) with ESMTP id
	n2OEVWwt013734
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 15:31:33 +0100
In-Reply-To: <20090324123131.GC24724@lisas.de>
To: Adrian Reber <adrian@lisas.de>
MIME-Version: 1.0
Subject: Re: [PATCH] powerpc/wdrtas: Update wdrtas_get_interval to
	use	rtas_data_buf
From: Utz Bacher <utz.bacher@de.ibm.com>
Message-ID: <OF2EBA91DF.87037392-ONC1257583.004A2432-C1257583.004FC7A9@de.ibm.com>
Date: Tue, 24 Mar 2009 15:31:32 +0100
Content-Type: multipart/alternative;
	boundary="=_alternative 004F6C3DC1257583_="
Cc: Mark Nelson <markn@au1.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 004F6C3DC1257583_=
Content-Type: text/plain; charset="US-ASCII"

Adrian Reber <adrian@lisas.de> wrote on 24.03.2009 13:31:31:
> On Tue, Mar 24, 2009 at 05:30:41PM +1100, Mark Nelson wrote:
> > The buffer passed to the ibm,get-system-parameter RTAS call must be
> > in the RMA. To ensure we pass an address in the RMA use rtas_data_buf
> > for the actual RTAS call and then copy the result to value. We can't
> > just make it static because this can be compiled in as a module.
> > 
> > Also add the WDRTAS_SP_SPI_LEN so we don't litter '4' throughout the
> > function.
> > 
> > Signed-off-by: Mark Nelson <markn@au1.ibm.com>
> > ---
> > 
> > Adrian, does this patch cause any problems for your pxcabs?
> 
> No, it even helps. I have no tried the watchdog until now, but without 
the
> patch I get: 
> 
>    wdrtas: could not get sp_spi watchdog timeout (0). Continuing
> 
> and with the patch it reads the correct value. So only with your patch
> it works like it is supposed to. Thanks!
> 
> Tested-by: Adrian Reber <adrian@lisas.de>

looks good to me.

Acked-by: Utz Bacher <utz.bacher@de.ibm.com>

Utz

:wq
--=_alternative 004F6C3DC1257583_=
Content-Type: text/html; charset="US-ASCII"


<br><tt><font size=2>Adrian Reber &lt;adrian@lisas.de&gt; wrote on 24.03.2009
13:31:31:<br>
&gt; On Tue, Mar 24, 2009 at 05:30:41PM +1100, Mark Nelson wrote:<br>
&gt; &gt; The buffer passed to the ibm,get-system-parameter RTAS call must
be<br>
&gt; &gt; in the RMA. To ensure we pass an address in the RMA use rtas_data_buf<br>
&gt; &gt; for the actual RTAS call and then copy the result to value. We
can't<br>
&gt; &gt; just make it static because this can be compiled in as a module.<br>
&gt; &gt; <br>
&gt; &gt; Also add the WDRTAS_SP_SPI_LEN so we don't litter '4' throughout
the<br>
&gt; &gt; function.<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Mark Nelson &lt;markn@au1.ibm.com&gt;<br>
&gt; &gt; ---<br>
&gt; &gt; <br>
&gt; &gt; Adrian, does this patch cause any problems for your pxcabs?<br>
&gt; <br>
&gt; No, it even helps. I have no tried the watchdog until now, but without
the<br>
&gt; patch I get: <br>
&gt; <br>
&gt; &nbsp; &nbsp;wdrtas: could not get sp_spi watchdog timeout (0). Continuing<br>
&gt; <br>
&gt; and with the patch it reads the correct value. So only with your patch<br>
&gt; it works like it is supposed to. Thanks!<br>
&gt; <br>
&gt; Tested-by: Adrian Reber &lt;adrian@lisas.de&gt;</font></tt>
<br>
<br><tt><font size=2>looks good to me.</font></tt>
<br>
<br><tt><font size=2>Acked-by: Utz Bacher &lt;utz.bacher@de.ibm.com&gt;</font></tt>
<br>
<br><tt><font size=2>Utz</font></tt>
<br>
<br><tt><font size=2>:wq</font></tt>
--=_alternative 004F6C3DC1257583_=--
