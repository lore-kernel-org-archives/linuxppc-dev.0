Return-Path: <carll@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 04420B7D2E
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jun 2010 06:12:31 +1000 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e31.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o52K24KH011983
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jun 2010 14:02:04 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o52KC6mO099602
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jun 2010 14:12:09 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o52KC2jF016118
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jun 2010 14:12:04 -0600
In-Reply-To: <20100601194334.GA4549@hera.kernel.org>
Subject: Re: [PATCH] powerpc/oprofile: fix potential buffer overrun
	in	op_model_cell.c
To: Denis Kirjanov <dkirjanov@hera.kernel.org>
Message-ID: <OFD947B20D.7CD8E15C-ON87257736.006EE095-88257736.006EF6E3@us.ibm.com>
From: Carl Love <carll@us.ibm.com>
Date: Wed, 2 Jun 2010 13:12:00 -0700
MIME-Version: 1.0
Content-type: multipart/related;
	Boundary="0__=08BBFDA5DFFD66058f9e8a93df938690918c08BBFDA5DFFD6605"
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, paulus@samba.org, jkosina@suse.cz,
	oprofile-list@lists.sf.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0__=08BBFDA5DFFD66058f9e8a93df938690918c08BBFDA5DFFD6605
Content-type: multipart/alternative;
	Boundary="1__=08BBFDA5DFFD66058f9e8a93df938690918c08BBFDA5DFFD6605"

--1__=08BBFDA5DFFD66058f9e8a93df938690918c08BBFDA5DFFD6605
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable


Denis:

I have reviewed the change and agree to it.  Thanks for catching that.

          Carl Love



                                                                       =
    
             Denis Kirjanov                                            =
    
             <dkirjanov@hera.k                                         =
    
             ernel.org>                                                =
 To 
                                       arnd@arndb.de,                  =
    
             06/01/2010 12:43          benh@kernel.crashing.org,       =
    
             PM                        paulus@samba.org, jkosina@suse.c=
z   
                                                                       =
 cc 
                                       linuxppc-dev@ozlabs.org,        =
    
                                       oprofile-list@lists.sf.net      =
    
                                                                   Subj=
ect 
                                       [PATCH] powerpc/oprofile: fix   =
    
                                       potential buffer overrun in     =

                                       op_model_cell.c                 =
    
                                                                       =
    
                                                                       =
    
                                                                       =
    
                                                                       =
    
                                                                       =
    
                                                                       =
    




Fix potential initial_lfsr buffer overrun.
Writing past the end of the buffer could happen when index =3D=3D ENTRI=
ES

Signed-off-by: Denis Kirjanov <dkirjanov@kernel.org>
---
 arch/powerpc/oprofile/op_model_cell.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/oprofile/op_model_cell.c
b/arch/powerpc/oprofile/op_model_cell.c
index 2c9e522..7fd90d0 100644
--- a/arch/powerpc/oprofile/op_model_cell.c
+++ b/arch/powerpc/oprofile/op_model_cell.c
@@ -1077,7 +1077,7 @@ static int calculate_lfsr(int n)
 		 		 index =3D ENTRIES-1;

 		 /* make sure index is valid */
-		 if ((index > ENTRIES) || (index < 0))
+		 if ((index >=3D ENTRIES) || (index < 0))
 		 		 index =3D ENTRIES-1;

 		 return initial_lfsr[index];

-----------------------------------------------------------------------=
-------


_______________________________________________
oprofile-list mailing list
oprofile-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/oprofile-list
=

--1__=08BBFDA5DFFD66058f9e8a93df938690918c08BBFDA5DFFD6605
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p>Denis:<br>
<br>
I have reviewed the change and agree to it.  Thanks for catching that.<=
br>
<br>
          Carl Love<br>
<br>
<img width=3D"16" height=3D"16" src=3D"cid:1__=3D08BBFDA5DFFD66058f9e8a=
93df938@us.ibm.com" border=3D"0" alt=3D"Inactive hide details for Denis=
 Kirjanov &lt;dkirjanov@hera.kernel.org&gt;">Denis Kirjanov &lt;dkirjan=
ov@hera.kernel.org&gt;<br>
<br>
<br>

<table width=3D"100%" border=3D"0" cellspacing=3D"0" cellpadding=3D"0">=

<tr valign=3D"top"><td style=3D"background-image:url(cid:2__=3D08BBFDA5=
DFFD66058f9e8a93df938@us.ibm.com); background-repeat: no-repeat; " widt=
h=3D"40%">
<ul>
<ul>
<ul>
<ul><b><font size=3D"2">Denis Kirjanov &lt;dkirjanov@hera.kernel.org&gt=
;</font></b><font size=3D"2"> </font>
<p><font size=3D"2">06/01/2010 12:43 PM</font></ul>
</ul>
</ul>
</ul>
</td><td width=3D"60%">
<table width=3D"100%" border=3D"0" cellspacing=3D"0" cellpadding=3D"0">=

<tr valign=3D"top"><td width=3D"1%"><img width=3D"58" height=3D"1" src=3D=
"cid:3__=3D08BBFDA5DFFD66058f9e8a93df938@us.ibm.com" border=3D"0" alt=3D=
""><br>
<div align=3D"right"><font size=3D"2">To</font></div></td><td width=3D"=
100%"><img width=3D"1" height=3D"1" src=3D"cid:3__=3D08BBFDA5DFFD66058f=
9e8a93df938@us.ibm.com" border=3D"0" alt=3D""><br>
<font size=3D"2">arnd@arndb.de, benh@kernel.crashing.org, paulus@samba.=
org, jkosina@suse.cz</font></td></tr>

<tr valign=3D"top"><td width=3D"1%"><img width=3D"58" height=3D"1" src=3D=
"cid:3__=3D08BBFDA5DFFD66058f9e8a93df938@us.ibm.com" border=3D"0" alt=3D=
""><br>
<div align=3D"right"><font size=3D"2">cc</font></div></td><td width=3D"=
100%"><img width=3D"1" height=3D"1" src=3D"cid:3__=3D08BBFDA5DFFD66058f=
9e8a93df938@us.ibm.com" border=3D"0" alt=3D""><br>
<font size=3D"2">linuxppc-dev@ozlabs.org, oprofile-list@lists.sf.net</f=
ont></td></tr>

<tr valign=3D"top"><td width=3D"1%"><img width=3D"58" height=3D"1" src=3D=
"cid:3__=3D08BBFDA5DFFD66058f9e8a93df938@us.ibm.com" border=3D"0" alt=3D=
""><br>
<div align=3D"right"><font size=3D"2">Subject</font></div></td><td widt=
h=3D"100%"><img width=3D"1" height=3D"1" src=3D"cid:3__=3D08BBFDA5DFFD6=
6058f9e8a93df938@us.ibm.com" border=3D"0" alt=3D""><br>
<font size=3D"2">[PATCH] powerpc/oprofile: fix potential buffer overrun=
 in	op_model_cell.c</font></td></tr>
</table>

<table border=3D"0" cellspacing=3D"0" cellpadding=3D"0">
<tr valign=3D"top"><td width=3D"58"><img width=3D"1" height=3D"1" src=3D=
"cid:3__=3D08BBFDA5DFFD66058f9e8a93df938@us.ibm.com" border=3D"0" alt=3D=
""></td><td width=3D"336"><img width=3D"1" height=3D"1" src=3D"cid:3__=3D=
08BBFDA5DFFD66058f9e8a93df938@us.ibm.com" border=3D"0" alt=3D""></td></=
tr>
</table>
</td></tr>
</table>
<br>
<tt>Fix potential initial_lfsr buffer overrun.<br>
Writing past the end of the buffer could happen when index =3D=3D ENTRI=
ES<br>
<br>
Signed-off-by: Denis Kirjanov &lt;dkirjanov@kernel.org&gt;<br>
---<br>
 arch/powerpc/oprofile/op_model_cell.c | &nbsp; &nbsp;2 +-<br>
 1 files changed, 1 insertions(+), 1 deletions(-)<br>
<br>
diff --git a/arch/powerpc/oprofile/op_model_cell.c b/arch/powerpc/oprof=
ile/op_model_cell.c<br>
index 2c9e522..7fd90d0 100644<br>
--- a/arch/powerpc/oprofile/op_model_cell.c<br>
+++ b/arch/powerpc/oprofile/op_model_cell.c<br>
@@ -1077,7 +1077,7 @@ static int calculate_lfsr(int n)<br>
 		 		 index =3D ENTRIES-1;<br>
 <br>
 		 /* make sure index is valid */<br>
-		 if ((index &gt; ENTRIES) || (index &lt; 0))<br>
+		 if ((index &gt;=3D ENTRIES) || (index &lt; 0))<br>
 		 		 index =3D ENTRIES-1;<br>
 <br>
 		 return initial_lfsr[index];<br>
<br>
-----------------------------------------------------------------------=
-------<br>
<br>
_______________________________________________<br>
oprofile-list mailing list<br>
oprofile-list@lists.sourceforge.net<br>
</tt><tt><a href=3D"https://lists.sourceforge.net/lists/listinfo/oprofi=
le-list">https://lists.sourceforge.net/lists/listinfo/oprofile-list</a>=
</tt><tt><br>
</tt><br>
</body></html>=


--1__=08BBFDA5DFFD66058f9e8a93df938690918c08BBFDA5DFFD6605--


--0__=08BBFDA5DFFD66058f9e8a93df938690918c08BBFDA5DFFD6605
Content-type: image/gif;
	name="graycol.gif"
Content-Disposition: inline; filename="graycol.gif"
Content-ID: <1__=08BBFDA5DFFD66058f9e8a93df938@us.ibm.com>
Content-transfer-encoding: base64

R0lGODlhEAAQAKECAMzMzAAAAP///wAAACH5BAEAAAIALAAAAAAQABAAAAIXlI+py+0PopwxUbpu
ZRfKZ2zgSJbmSRYAIf4fT3B0aW1pemVkIGJ5IFVsZWFkIFNtYXJ0U2F2ZXIhAAA7

--0__=08BBFDA5DFFD66058f9e8a93df938690918c08BBFDA5DFFD6605
Content-type: image/gif;
	name="pic11538.gif"
Content-Disposition: inline; filename="pic11538.gif"
Content-ID: <2__=08BBFDA5DFFD66058f9e8a93df938@us.ibm.com>
Content-transfer-encoding: base64

R0lGODlhWABDALP/AAAAAK04Qf79/o+Gm7WuwlNObwoJFCsoSMDAwGFsmIuezf///wAAAAAAAAAA
AAAAACH5BAEAAAgALAAAAABYAEMAQAT/EMlJq704682770RiFMRinqggEUNSHIchG0BCfHhOjAuh
EDeUqTASLCbBhQrhG7xis2j0lssNDopE4jfIJhDaggI8YB1sZeZgLVA9YVCpnGagVjV171aRVrYR
RghXcAGFhoUETwYxcXNyADJ3GlcSKGAwLwllVC1vjIUHBWsFilKQdI8GA5IcpApeJQt8L09lmgkH
LZikoU5wjqcyAMMFrJIDPAKvCFletKSev1HBw8KrxtjZ2tvc3d5VyKtCKW3jfz4uMKmq3xu4N0nK
BVoJQmx2LGVOmrqNjjJf2hHAQo/eDwJGTKhQMcgQEEAnEjFS98+RnW3smGkZU6ncCWav/4wYOnAI
TihRL/4FEwbp28BXMMcoscQCVxlepL4IGDSCyJyVQOu0o7CjmLN50OZlqWmyFy5/6yBBuji0AxFR
M00oQAqNIstqI6qKHUsWRAEAvagsmfUEAImyxgbmUpJk3IklNUtJOUAVLoUr1+wqDGTE4zk+T6FG
uQb3SizBCwatiiUgCBN8vrz+zFjVyQ8FWkOlg4NQiZMB5QS8QO3mpOaKnL0Z2EKvNMSILEThKhCg
zMKPVxYJh23qm9KNW7pArPynMqZDiErsTMqI+LRi3QAgkFUbXpuFKhSYZALd0O5RKa2z9EYKBbpb
qxIKsjUPRgD7I2XYV6wyrOw92ykExP8NW4URhknC5dKGE4v4NENQj2jXjmfNgOZDaXb5glRmXQ33
YEWQYNcZFnrYcIQLNzyTFDQNkXIff0ExVlY4srziQk43inZgL4rwxxINMvpFFAz1KOODHiu+4aEw
NEjFl5B3JIKWKF3k6I9bfUGp5ZZcdunll5IA4cuHvQQJ5gcsoCWOOUwgltIwAKRxJgbIkJAQZEq0
2YliZnpZZ4BH3CnYOXldOUOfQoYDqF1LFHbXCrO8xmRsfoXDXJ6ChjCAH3QlhJcT6VWE6FCkfCco
CgrMFsROrIEX3o2whVjWDjoJccN3LdggSGXLCdLEgHr1lyU3O3QxhgohNKXJCWv8JQr/PDdaqd6w
2rj1inLiGeiCJoDspAoQlYE6QWLSECehcWIYxIQES6zhbn1iImTHEQyqJ4eIxJJoUBc+3CbBuwZE
V5cJPPkIjFDdeEabQbd6WgICTxiiz0f5dBKquXF6k4senwEhYGnKEFJeGrxUZy8dB8gmAXI/sPvH
ESfCwVt5hTgYiqQqtdRNHQIU1PJ33ZqmzgE90OwLaoJcnMop1WiMmgkPHQRIrwgFuNV90A3doNKT
mrKIN07AnGcI9BQjhCBN4RfA1qIZnMqorJCogKfGQnxSCDilTVIA0yl5ciTovgLuBDKFUDE9aQcw
9SA+rjSNf9/M1gxrj6VwDTS0IUSElMzBfsj0NFXR2kwsV1A5IF1grLgLL/r1R40BZEnuBWgmQEyb
jqRwSAt6bqMCOFkvKFN2GPPkUzIm/SCF8z8pVzpbjVnMsy0vOr1hw3SaSRUhpY09v0z0J1FnwzPl
fmh+xl4WtR0zGu24I4KbMQm3lnVu2oNWxI9W/lcyzA+mCKF4DBikxb/+UWtOGRiFP8qEwAayIgIA
Ow==

--0__=08BBFDA5DFFD66058f9e8a93df938690918c08BBFDA5DFFD6605
Content-type: image/gif;
	name="ecblank.gif"
Content-Disposition: inline; filename="ecblank.gif"
Content-ID: <3__=08BBFDA5DFFD66058f9e8a93df938@us.ibm.com>
Content-transfer-encoding: base64

R0lGODlhEAABAIAAAAAAAP///yH5BAEAAAEALAAAAAAQAAEAAAIEjI8ZBQA7

--0__=08BBFDA5DFFD66058f9e8a93df938690918c08BBFDA5DFFD6605--
