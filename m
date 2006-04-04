Return-Path: <hbabu@us.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2B871679E7
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Apr 2006 16:51:24 +1000 (EST)
Received: from e33.co.us.ibm.com (e33.boulder.ibm.com [9.17.249.43])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k346BAoi023907
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Apr 2006 02:11:11 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k346AtL6032062
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Apr 2006 02:10:55 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k346E7Ya191052
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Apr 2006 00:14:07 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k346AtZU009038
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Apr 2006 00:10:55 -0600
In-Reply-To: <1144129248.29756.7.camel@localhost.localdomain>
To: Michael Ellerman <michaelellerman@internode.on.net>
MIME-Version: 1.0
Subject: Re: _machine removal breaks kexec?
Message-ID: <OFA8E8A02F.0E4B5943-ON87257146.0020CEB6-88257146.0021F4AD@us.ibm.com>
From: Haren Myneni <hbabu@us.ibm.com>
Date: Mon, 3 Apr 2006 23:15:32 -0700
Content-Type: multipart/alternative;
	boundary="=_alternative 0021F4A888257146_="
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 0021F4A888257146_=
Content-Type: text/plain; charset="US-ASCII"

linuxppc-dev-bounces+hbabu=us.ibm.com@ozlabs.org wrote on 04/03/2006 
10:40:48 PM:

> On Mon, 2006-04-03 at 11:18 -0700, Haren Myneni wrote:
> > Basically, kexec-tools looks the platform property to determine 
whether 
> > to read tce-base, tce-size and htab-* properties. The attached patch 
> > find out the platform info based on /proc/device-tree/chosen/htab-base 

> > property. Not tested yet.
> 
> Why don't we get rid of the platform variable entirely in kexec-ppc64.c,
> if the tce-* and htab-* properties are there, then we read them, if not
> we don't.

> 
> There's also:
> 
> if (platform == PLATFORM_PSERIES) {
>         if (rmo_top > 0x30000000UL)
>                 rmo_top = 0x30000000UL;
> }
> 
> I'm not sure where that number comes from, perhaps we need to export the
> RMO value like we do for the htab?

Yes, we can remove this PLATFORM_* and read these properties if exists. I 
believe, this large number is copied from prom_init.c. I am not sure 
whether exporting rmo_top is needed since it is always the size of first 
memory node unless the size is greater than 0x30000000UL. PLATFORM_PSERIES 
is not needed anyway for this comparison.


> 
> While we're there that code could use a function to read
> a /proc/device-tree file and do error handling, there's a lot of
> duplicate code at the moment.
> 
Yes, there is some cleanup needed in kexec-tools.

Thanks
Haren

> cheers
> 
> -- 
> Michael Ellerman
> IBM OzLabs
> 
> wwweb: http://michael.ellerman.id.au
> phone: +61 2 6212 1183 (tie line 70 21183)
> 
> We do not inherit the earth from our ancestors,
> we borrow it from our children. - S.M.A.R.T Person
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

--=_alternative 0021F4A888257146_=
Content-Type: text/html; charset="US-ASCII"


<br>
<br><font size=2><tt>linuxppc-dev-bounces+hbabu=us.ibm.com@ozlabs.org wrote
on 04/03/2006 10:40:48 PM:<br>
<br>
&gt; On Mon, 2006-04-03 at 11:18 -0700, Haren Myneni wrote:<br>
&gt; &gt; Basically, kexec-tools looks the platform property to determine
whether <br>
&gt; &gt; to read tce-base, tce-size and htab-* properties. The attached
patch <br>
&gt; &gt; find out the platform info based on /proc/device-tree/chosen/htab-base
<br>
&gt; &gt; property. Not tested yet.<br>
&gt; <br>
&gt; Why don't we get rid of the platform variable entirely in kexec-ppc64.c,<br>
&gt; if the tce-* and htab-* properties are there, then we read them, if
not<br>
&gt; we don't.</tt></font>
<br><font size=2><tt><br>
&gt; <br>
&gt; There's also:<br>
&gt; <br>
&gt; if (platform == PLATFORM_PSERIES) {<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; if (rmo_top &gt; 0x30000000UL)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; rmo_top =
0x30000000UL;<br>
&gt; }<br>
&gt; <br>
&gt; I'm not sure where that number comes from, perhaps we need to export
the<br>
&gt; RMO value like we do for the htab?</tt></font>
<br>
<br><font size=2><tt>Yes, we can remove this PLATFORM_* and read these
properties if exists. I believe, this large number is copied from prom_init.c.
I am not sure whether exporting rmo_top is needed since it is always the
size of first memory node unless the size is greater than 0x30000000UL.
PLATFORM_PSERIES is not needed anyway for this comparison.</tt></font>
<br>
<br><font size=2><tt><br>
&gt; <br>
&gt; While we're there that code could use a function to read<br>
&gt; a /proc/device-tree file and do error handling, there's a lot of<br>
&gt; duplicate code at the moment.<br>
&gt; </tt></font>
<br><font size=2><tt>Yes, there is some cleanup needed in kexec-tools.</tt></font>
<br>
<br><font size=2><tt>Thanks</tt></font>
<br><font size=2><tt>Haren</tt></font>
<br><font size=2><tt><br>
&gt; cheers<br>
&gt; <br>
&gt; -- <br>
&gt; Michael Ellerman<br>
&gt; IBM OzLabs<br>
&gt; <br>
&gt; wwweb: http://michael.ellerman.id.au<br>
&gt; phone: +61 2 6212 1183 (tie line 70 21183)<br>
&gt; <br>
&gt; We do not inherit the earth from our ancestors,<br>
&gt; we borrow it from our children. - S.M.A.R.T Person<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; Linuxppc-dev mailing list<br>
&gt; Linuxppc-dev@ozlabs.org<br>
&gt; https://ozlabs.org/mailman/listinfo/linuxppc-dev<br>
</tt></font>
--=_alternative 0021F4A888257146_=--
