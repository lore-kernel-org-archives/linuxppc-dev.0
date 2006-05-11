Return-Path: <s.maiti@tcs.com>
Received: from inkolg01.tcs.com (inkolg01.tcs.com [203.197.96.54])
	by ozlabs.org (Postfix) with ESMTP id 5B41A679EA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 May 2006 22:56:31 +1000 (EST)
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B0189DD9F@ismail.innsys.innovsys.com>
To: "Rune Torgersen" <runet@innovsys.com>
Subject: RE: Help Needed: input overrun(s)
MIME-Version: 1.0
From: s.maiti@tcs.com
Message-ID: <OF1F85A3F3.2126D6AA-ON6525716B.0046DD6E-6525716B.00471575@tcs.com>
Date: Thu, 11 May 2006 18:26:24 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 004712F76525716B_="
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 004712F76525716B_=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"

Thanks very much for your reply. It's seems you have already developed the 
MCC driver. Are you using channels 32 to 96? Have you made any changes in 
the dp ram allocation for uart or ethernet driver?
Please help me...

Thanks and regards,
Souvik Maiti
Tata Consultancy Services Limited
Mailto: s.maiti@tcs.com
Website: http://www.tcs.com



"Rune Torgersen" <runet@innovsys.com> 
05/10/2006 08:45 PM

To
"Stevan Ignjatovic" <stevan@iritel.com>, <s.maiti@tcs.com>
cc
<linuxppc-embedded@ozlabs.org>
Subject
RE: Help Needed: input overrun(s)






> -----Original Message-----
> From: Stevan Ignjatovic
> Hello,
> 
> > console we are receiving a print "ttyS: 1 input overrun(s)" 
> along with 
> > other prints of the driver and resulting in scrambled output. 
> > Can anyone suggest why this is happening? Is the driver 
> affecting the uart 
> > driver?
> 
> As far as UART driver is concerned, it could be affected if 
> you did not
> carefully allocate some resources. Are you using MCC1 or MCC2? Channel
> specific parameters of MCC1 (channels 0-127) are at the 
> beginning of the
> DPRAM (channel CH_NUM at address 64*CH_NUM). UART driver (as well as
> ethernet driver) allocates its buffer descriptors with
> m8260_cpm_dpalloc. I think that allocating with this function 
> starts at
> the beginning of the DPRAM, so you might have overwritten 
> UART's buffer
> descriptors. So, use MCC2 if you can. If you use some BRGs in your MCC
> driver you should check that as well. 

We have a MCC driver that we see the same happening on. It only occurs
under heavy load (top sows us usig 20-40 % cpu in interrupt).
I am pretty confident that we are not overwriting uart DPRAM. (MCC1 only
uses the middle 64 channels, skipping over the first 32 where the
conflict witht he UARTS are)

I have not seen it corrupt anything, so we have more or less ignored it.
Our theory is that it happens when the CPM gets overloaded.
It would be nice to actually fix it though....

ForwardSourceID:NT00006D1A 
=====-----=====-----=====
Notice: The information contained in this e-mail
message and/or attachments to it may contain 
confidential or privileged information. If you are 
not the intended recipient, any dissemination, use, 
review, distribution, printing or copying of the 
information contained in this e-mail message 
and/or attachments to it are strictly prohibited. If 
you have received this communication in error, 
please notify us by reply e-mail or telephone and 
immediately and permanently delete the message 
and any attachments. Thank you



--=_alternative 004712F76525716B_=
Content-Transfer-Encoding: 7bit
Content-Type: text/html; charset="us-ascii"


<br><font size=2 face="sans-serif">Thanks very much for your reply. It's
seems you have already developed the MCC driver. Are you using channels
32 to 96? Have you made any changes in the dp ram allocation for uart or
ethernet driver?</font>
<br><font size=2 face="sans-serif">Please help me...</font>
<br>
<br><font size=2 face="sans-serif">Thanks and regards,<br>
Souvik Maiti<br>
Tata Consultancy Services Limited<br>
Mailto: s.maiti@tcs.com<br>
Website: http://www.tcs.com</font>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>&quot;Rune Torgersen&quot;
&lt;runet@innovsys.com&gt;</b> </font>
<p><font size=1 face="sans-serif">05/10/2006 08:45 PM</font>
<td width=59%>
<table width=100%>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td><font size=1 face="sans-serif">&quot;Stevan Ignjatovic&quot; &lt;stevan@iritel.com&gt;,
&lt;s.maiti@tcs.com&gt;</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td><font size=1 face="sans-serif">&lt;linuxppc-embedded@ozlabs.org&gt;</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td><font size=1 face="sans-serif">RE: Help Needed: input overrun(s)</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><font size=2><tt>&gt; -----Original Message-----<br>
&gt; From: Stevan Ignjatovic<br>
&gt; Hello,<br>
&gt; <br>
&gt; &gt; console we are receiving a print &quot;ttyS: 1 input overrun(s)&quot;
<br>
&gt; along with <br>
&gt; &gt; other prints of the driver and resulting in scrambled output.
<br>
&gt; &gt; Can anyone suggest why this is happening? Is the driver <br>
&gt; affecting the uart <br>
&gt; &gt; driver?<br>
&gt; <br>
&gt; As far as UART driver is concerned, it could be affected if <br>
&gt; you did not<br>
&gt; carefully allocate some resources. Are you using MCC1 or MCC2? Channel<br>
&gt; specific parameters of MCC1 (channels 0-127) are at the <br>
&gt; beginning of the<br>
&gt; DPRAM (channel CH_NUM at address 64*CH_NUM). UART driver (as well
as<br>
&gt; ethernet driver) allocates its buffer descriptors with<br>
&gt; m8260_cpm_dpalloc. I think that allocating with this function <br>
&gt; starts at<br>
&gt; the beginning of the DPRAM, so you might have overwritten <br>
&gt; UART's buffer<br>
&gt; descriptors. So, use MCC2 if you can. If you use some BRGs in your
MCC<br>
&gt; driver you should check that as well. &nbsp; &nbsp; <br>
<br>
We have a MCC driver that we see the same happening on. It only occurs<br>
under heavy load (top sows us usig 20-40 % cpu in interrupt).<br>
I am pretty confident that we are not overwriting uart DPRAM. (MCC1 only<br>
uses the middle 64 channels, skipping over the first 32 where the<br>
conflict witht he UARTS are)<br>
<br>
I have not seen it corrupt anything, so we have more or less ignored it.<br>
Our theory is that it happens when the CPM gets overloaded.<br>
It would be nice to actually fix it though....<br>
</tt></font>
<br><font size=1 color=white face="sans-serif">ForwardSourceID:NT00006D1A
&nbsp; &nbsp;</font>
<br><pre>=====-----=====-----=====
Notice: The information contained in this e-mail
message and/or attachments to it may contain 
confidential or privileged information. If you are 
not the intended recipient, any dissemination, use, 
review, distribution, printing or copying of the 
information contained in this e-mail message 
and/or attachments to it are strictly prohibited. If 
you have received this communication in error, 
please notify us by reply e-mail or telephone and 
immediately and permanently delete the message 
and any attachments. Thank you


</pre>
--=_alternative 004712F76525716B_=--
