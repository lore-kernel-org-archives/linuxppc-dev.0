Return-Path: <batsayan.das@tcs.com>
Received: from inchng01.tcs.com (InChnG01.tcs.com [203.101.69.158])
	by ozlabs.org (Postfix) with ESMTP id 0B5E8688A1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Dec 2005 00:03:53 +1100 (EST)
In-Reply-To: <20051216101101.7B82B353416@atlas.denx.de>
To: Wolfgang Denk <wd@denx.de>
MIME-Version: 1.0
From: batsayan.das@tcs.com
Message-ID: <OF11043246.580AC67A-ON652570D9.003B44F6-652570D9.003B7097@tcs.com>
Date: Fri, 16 Dec 2005 16:19:14 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 003B7035652570D9_="
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [U-Boot-Users] Help required to bring up kernel from U-Boot
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
--=_alternative 003B7035652570D9_=
Content-Type: text/plain; charset="US-ASCII"


1. Doing the changes in Linux tree suggested in 
http://www.denx.de/wiki/view/DULG/LinuxHangsAfterUncompressingKernel 
yields the same result. We already did those changes. 

2. Here is the procedure how I got the o/p of printk even if I do not get 
anything at console.

Run u-boot from Trace32
bootm <addr>  //  Now in our case Linux hangs after giving the o/p "## 
Transferring control to Linux (at address 00000000) ..."
stop u-boot //Do not hard reset the target
Again run U-Boot from Trace32
md <addrss of log_buf>  // search for "log_buf" in System.map in Linux 
tree. You will get this address.

Batsayan Das
Tata Consultancy Services Limited
Mailto: batsayan.das@tcs.com
Website: http://www.tcs.com



Wolfgang Denk <wd@denx.de> 
Sent by: wd@denx.de
12/16/2005 03:41 PM

To
batsayan.das@tcs.com
cc
u-boot-users@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
Subject
Re: [U-Boot-Users] Help required to bring up kernel from U-Boot






In message 
<OFB8CF31AB.E132BC0B-ON652570D9.001789DD-652570D9.001A8A99@tcs.com> you 
wrote:
>
> I copied uImage to location 0x04000000 and  the Load Address=0x00000000 
> and Entry point=0x00000000.  The bootm 0x04000000 gives the o/p 
> "Transferring Control to Linux" and then nothing comes. Where is the 
> wrong?

This is a FAQ. Please see http://www.denx.de/wiki/DULG/Faq

> 1. What are the minimum information Linux needs from U-Boot to come up 
> properly?  In the Linux source tree we have put some printk statement 
and 
> found that base address of SDRAM, size, etc are passed correctly to 
Linux 
> by U-Boot. 

Be careful with printk() at inappropieate places (i.e. too early).

But tell me - how where you  able  to  see  anthing  with  printk  if
"nothing comes" as you write above ???

> 2. Is the info passed from U-Boot is sufficient enough to make the 
kernel 
> up?

Yes, of course. It works on thousands of systems.

> 3. If not, where should I concentrate in Linux tree?

On your changes.

And please keep this off the U-Boot list. It is off topic here.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
CONSUMER NOTICE:  Because  of  the  "Uncertainty  Principle,"  It  Is
Impossible  for  the  Consumer  to  Find  Out  at  the Same Time Both
Precisely Where This Product Is and How Fast It Is Moving.

ForwardSourceID:NT000081B2 


Notice: The information contained in this e-mail message and/or attachments to it may contain confidential or privileged information.   If you are not the intended recipient, any dissemination, use, review, distribution, printing or copying of the information contained in this e-mail message and/or attachments to it are strictly prohibited.   If you have received this communication in error, please notify us by reply e-mail or telephone and immediately and permanently delete the message and any attachments.  Thank you
--=_alternative 003B7035652570D9_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">1. Doing the changes in Linux tree suggested
in http://www.denx.de/wiki/view/DULG/LinuxHangsAfterUncompressingKernel
&nbsp;yields the same result. We already did those changes. </font>
<br>
<br><font size=2 face="sans-serif">2. Here is the procedure how I got the
o/p of printk even if I do not get anything at console.</font>
<br>
<br><font size=2 face="sans-serif">Run u-boot from Trace32</font>
<br><font size=2 face="sans-serif">bootm &lt;addr&gt; &nbsp;// &nbsp;Now
in our case Linux hangs after giving the o/p &quot;## Transferring control
to Linux (at address 00000000) ...&quot;</font>
<br><font size=2 face="sans-serif">stop u-boot //Do not hard reset the
target</font>
<br><font size=2 face="sans-serif">Again run U-Boot from Trace32</font>
<br><font size=2 face="sans-serif">md &lt;addrss of log_buf&gt; &nbsp;//
search for &quot;log_buf&quot; in System.map in Linux tree. You will get
this address.</font>
<br><font size=2 face="sans-serif"><br>
Batsayan Das<br>
Tata Consultancy Services Limited<br>
Mailto: batsayan.das@tcs.com<br>
Website: http://www.tcs.com</font>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>Wolfgang Denk &lt;wd@denx.de&gt;</b>
</font>
<br><font size=1 face="sans-serif">Sent by: wd@denx.de</font>
<p><font size=1 face="sans-serif">12/16/2005 03:41 PM</font>
<td width=59%>
<table width=100%>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td><font size=1 face="sans-serif">batsayan.das@tcs.com</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td><font size=1 face="sans-serif">u-boot-users@lists.sourceforge.net,
linuxppc-embedded@ozlabs.org</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td><font size=1 face="sans-serif">Re: [U-Boot-Users] Help required to
bring up kernel from U-Boot</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><font size=2><tt>In message &lt;OFB8CF31AB.E132BC0B-ON652570D9.001789DD-652570D9.001A8A99@tcs.com&gt;
you wrote:<br>
&gt;<br>
&gt; I copied uImage to location 0x04000000 and &nbsp;the Load Address=0x00000000
<br>
&gt; and Entry point=0x00000000. &nbsp;The bootm 0x04000000 gives the o/p
<br>
&gt; &quot;Transferring Control to Linux&quot; and then nothing comes.
Where is the <br>
&gt; wrong?<br>
<br>
This is a FAQ. Please see http://www.denx.de/wiki/DULG/Faq<br>
<br>
&gt; 1. What are the minimum information Linux needs from U-Boot to come
up <br>
&gt; properly? &nbsp;In the Linux source tree we have put some printk statement
and <br>
&gt; found that base address of SDRAM, size, etc are passed correctly to
Linux <br>
&gt; by U-Boot. <br>
<br>
Be careful with printk() at inappropieate places (i.e. too early).<br>
<br>
But tell me - how where you &nbsp;able &nbsp;to &nbsp;see &nbsp;anthing
&nbsp;with &nbsp;printk &nbsp;if<br>
&quot;nothing comes&quot; as you write above ???<br>
<br>
&gt; 2. Is the info passed from U-Boot is sufficient enough to make the
kernel <br>
&gt; up?<br>
<br>
Yes, of course. It works on thousands of systems.<br>
<br>
&gt; 3. If not, where should I concentrate in Linux tree?<br>
<br>
On your changes.<br>
<br>
And please keep this off the U-Boot list. It is off topic here.<br>
<br>
Best regards,<br>
<br>
Wolfgang Denk<br>
<br>
-- <br>
Software Engineering: &nbsp;Embedded and Realtime Systems, &nbsp;Embedded
Linux<br>
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de<br>
CONSUMER NOTICE: &nbsp;Because &nbsp;of &nbsp;the &nbsp;&quot;Uncertainty
&nbsp;Principle,&quot; &nbsp;It &nbsp;Is<br>
Impossible &nbsp;for &nbsp;the &nbsp;Consumer &nbsp;to &nbsp;Find &nbsp;Out
&nbsp;at &nbsp;the Same Time Both<br>
Precisely Where This Product Is and How Fast It Is Moving.<br>
</tt></font>
<br><font size=1 color=white face="sans-serif">ForwardSourceID:NT000081B2
&nbsp; &nbsp;</font>
<br>
<table><tr><td bgcolor=#ffffff><font color=#000000>Notice: The information contained in this e-mail message and/or attachments to it may contain confidential or privileged information.   If you are not the intended recipient, any dissemination, use, review, distribution, printing or copying of the information contained in this e-mail message and/or attachments to it are strictly prohibited.   If you have received this communication in error, please notify us by reply e-mail or telephone and immediately and permanently delete the message and any attachments.  Thank you<br>
</font></td></tr></table>
--=_alternative 003B7035652570D9_=--
