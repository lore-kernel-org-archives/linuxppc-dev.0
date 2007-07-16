Return-Path: <urwithsudheer@gmail.com>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id CF21CDDEF6
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Jul 2007 15:08:44 +1000 (EST)
Received: from [192.168.0.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 663EF8780D7
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 15 Jul 2007 22:08:35 -0700 (PDT)
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 3456F8780D4
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 15 Jul 2007 22:08:35 -0700 (PDT)
Message-ID: <469AFD4B.3090704@gmail.com>
Date: Mon, 16 Jul 2007 10:38:27 +0530
From: urwithsudheer <urwithsudheer@gmail.com>
MIME-Version: 1.0
To: "Robertson, Joseph M." <joseph.robertson@sanmina-sci.com>
Subject: Re: XSysAce driver cant mount DOS part
References: <939D37AEB47F1F49B88FAB6599B6023501A17205@hsv1dafpew02.das.gov.sanm.corp>
	<4697451E.3030409@gmail.com>
	<939D37AEB47F1F49B88FAB6599B6023501A1720A@hsv1dafpew02.das.gov.sanm.corp>
In-Reply-To: <939D37AEB47F1F49B88FAB6599B6023501A1720A@hsv1dafpew02.das.gov.sanm.corp>
Content-Type: multipart/alternative;
	boundary="------------040007070903040900020106"
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

This is a multi-part message in MIME format.
--------------040007070903040900020106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Joe Robertson,

Thanks for the link.

In the xsa_thread function, can u try changing the hardcoded coded value 
"2" to "xsa_cur_req->current_nr_sectors " 


The actual code in the given link.

for(i = xsa_cur_req->current_nr_sectors; i > 0; i-=2){
+			xsa_device.req_done = 1;
+			while ((stat = cur_req(&SysAce, sector,
+					2,
+					buffer)) == XST_DEVICE_BUSY)
+				xsa_short_delay();


Try changing it to ...

for(i = xsa_cur_req->current_nr_sectors; i > 0; 
i-=xsa_cur_req->current_nr_sectors ){ xsa_device.req_done = 1;
while ((stat = cur_req(&SysAce, sector,
                                     xsa_cur_req->current_nr_sectors ,
                                    buffer)) == XST_DEVICE_BUSY)
                xsa_short_delay();



Due to the hardcoded value, it gave problem while mounting but no issue 
with fdisk. It mounts well but generated a kernel BUG. Tried changing 
the value to '1' from '2' , fdisk crashed but mount is working well. So 
removed the hardcode value and then placed the dynamic variable 
xsa_cur_req->current_nr_sectors which is chosen by kernel. And now fdisk 
and mount both are working fine.


Pl let me know the results in your setup.

Thanks
Sudheer


Robertson, Joseph M. wrote:
>
> Hi,
>
> Yes, I got it from here.
> http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2.patch
>
> The 'official' one, yes?
>
> Thanks,
>
> Joe Robertson
> Joseph.Robertson@sanmina-sci.com
>
>
>
> -----Original Message-----
> From: urwithsudheer [mailto:urwithsudheer@gmail.com]
> Sent: Fri 7/13/2007 4:25 AM
> To: Robertson, Joseph M.
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: XSysAce driver cant mount DOS part
>
> Hi
>
> Robertson, Joseph M. wrote:
> >
> > Hi all,
> >
> > I've been workig with this for a while but have made no progress.
> > Today I got the latest XSysAce patch for kernel 2.6.17.1 and applied
> > it to get clean code.
> > I inherited the previous code from another developer.
> >
> Can you send the link to xsysace driver source code from where you 
> obtained.
>
>
> Thanks
> Sudheer
>
>
> >
> > My problem is that mounting the DOS partition always fails in a short
> > time with a kernel oops.
> >
> > ECAU-9999:# Oops: kernel access of bad area, sig: 11
> > [#1]                     
> > 
> PREEMPT                                                                       
> > NIP: C00701C8 LR: C0070C18 CTR:
> > 00000000                                      
> > REGS: c0391dd0 TRAP: 0300   Not tainted 
> > (2.6.17.1)                           
> > MSR: 00021030 <ME,IR,DR>  CR: 22028082  XER:
> > 0000000B                         
> > DAR: 00000000, DSISR:
> > 00800000                                                
> > TASK = c0373030[4] 'events/0' THREAD:
> > c0390000                                
> > GPR00: 00000080 C0391E80 C0373030 C02CAC00 C0E03000 C0E03154 00000000
> > C02CAC00
> > GPR08: 00200200 00000000 00100100 00000000 00051A4B FFFFDE60 03BD4900
> > 007FFF3B
> > GPR16: 00400000 00000001 FFFFFFFF 03BCDC58 00000000 007FFF00 00000002
> > C0280000
> > GPR24: C0363A10 0000000B 00000000 00000000 00000000 C02CAC00 C035ED20
> > C0E03000
> > NIP [C00701C8]
> > free_block+0x8c/0x138                                          
> > LR [C0070C18]
> > drain_array+0xb8/0x124                                          
> > Call Trace:                                 
> >
> > The setup:
> > My own build system.
> > Kernel 2.6.17.1 with lots of xilinx stuff, eth, i2c, xsysace. 
> > Crosscompiled for PPC405.
> > Latest, clean XSysAce code.  mods:  major hardcoded to = 125.  Polled
> > mode.
> > CF:  3 partitions,
> > 1:  DOS FAT16
> > 2:  Ext2  main
> > 3:  Ext2  rescue
> >
> > This build boots up fine, mounts a ext2 as root fine.  I can also
> > mount the rescue partition with no problems.
> >
> > Does anyone have any pointers of where I should look for problems?
> >
> > My next step is to go and set it up for interrupt service and see if
> > that changes anything.
> >
> > Thanks,
> >
> > Joe Robertson
> > Joseph.Robertson@sanmina-sci.com
> >
> >
> > CONFIDENTIALITY
> > This e-mail message and any attachments thereto, is intended only for
> > use by the addressee(s) named herein and may contain legally
> > privileged and/or confidential information. If you are not the
> > intended recipient of this e-mail message, you are hereby notified
> > that any dissemination, distribution or copying of this e-mail
> > message, and any attachments thereto, is strictly prohibited. If you
> > have received this e-mail message in error, please immediately notify
> > the sender and permanently delete the original and any copies of this
> > email and any prints thereof.
> > ABSENT AN EXPRESS STATEMENT TO THE CONTRARY HEREINABOVE, THIS E-MAIL
> > IS NOT INTENDED AS A SUBSTITUTE FOR A WRITING. Notwithstanding the
> > Uniform Electronic Transactions Act or the applicability of any other
> > law of similar substance and effect, absent an express statement to
> > the contrary hereinabove, this e-mail message its contents, and any
> > attachments hereto are not intended to represent an offer or
> > acceptance to enter into a contract and are not otherwise intended to
> > bind the sender, Sanmina-SCI Corporation (or any of its subsidiaries),
> > or any other person or entity.
> > ------------------------------------------------------------------------
> >
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
>
> CONFIDENTIALITY
> This e-mail message and any attachments thereto, is intended only for 
> use by the addressee(s) named herein and may contain legally 
> privileged and/or confidential information. If you are not the 
> intended recipient of this e-mail message, you are hereby notified 
> that any dissemination, distribution or copying of this e-mail 
> message, and any attachments thereto, is strictly prohibited. If you 
> have received this e-mail message in error, please immediately notify 
> the sender and permanently delete the original and any copies of this 
> email and any prints thereof.
> ABSENT AN EXPRESS STATEMENT TO THE CONTRARY HEREINABOVE, THIS E-MAIL 
> IS NOT INTENDED AS A SUBSTITUTE FOR A WRITING. Notwithstanding the 
> Uniform Electronic Transactions Act or the applicability of any other 
> law of similar substance and effect, absent an express statement to 
> the contrary hereinabove, this e-mail message its contents, and any 
> attachments hereto are not intended to represent an offer or 
> acceptance to enter into a contract and are not otherwise intended to 
> bind the sender, Sanmina-SCI Corporation (or any of its subsidiaries), 
> or any other person or entity.


--------------040007070903040900020106
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hi Joe Robertson,<br>
<br>
Thanks for the link.<br>
<br>
In the xsa_thread function, can u try changing the hardcoded coded
value "2" to "xsa_cur_req-&gt;current_nr_sectors "&nbsp; <br>
<br>
<br>
The actual code in the given link.<br>
<br>
<pre>for(i = xsa_cur_req-&gt;current_nr_sectors; i &gt; 0; i-=2){
+			xsa_device.req_done = 1;
+			while ((stat = cur_req(&amp;SysAce, sector,
+					2,
+					buffer)) == XST_DEVICE_BUSY)
+				xsa_short_delay();</pre>
<br>
Try changing it to ...<br>
<br>
for(i = xsa_cur_req-&gt;current_nr_sectors; i &gt; 0;
i-=xsa_cur_req-&gt;current_nr_sectors ){ xsa_device.req_done = 1;<br>
while ((stat = cur_req(&amp;SysAce, sector,<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; xsa_cur_req-&gt;current_nr_sectors
,<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; buffer)) == XST_DEVICE_BUSY)<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; xsa_short_delay();<br>
<br>
<br>
<br>
Due to the hardcoded value, it gave problem while mounting but no issue
with fdisk. It mounts well but generated a kernel BUG. Tried changing
the value to '1' from '2' , fdisk crashed but mount is working well. So
removed the hardcode value and then placed the dynamic variable
xsa_cur_req-&gt;current_nr_sectors which is chosen by kernel. And now
fdisk and mount both are working fine.<br>
<br>
<br>
Pl let me know the results in your setup.<br>
<br>
Thanks<br>
Sudheer<br>
<br>
<br>
Robertson, Joseph M. wrote:
<blockquote
 cite="mid939D37AEB47F1F49B88FAB6599B6023501A1720A@hsv1dafpew02.das.gov.sanm.corp"
 type="cite">
  <meta http-equiv="Content-Type" content="text/html; ">
  <meta name="Generator"
 content="MS Exchange Server version 6.5.7652.24">
  <title>RE: XSysAce driver cant mount DOS part</title>
<!-- Converted from text/plain format -->
  <p><font size="2">Hi,<br>
  <br>
Yes, I got it from here.<br>
  <a
 href="http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2.patch">http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2.patch</a><br>
  <br>
The 'official' one, yes?<br>
  <br>
Thanks,<br>
  <br>
Joe Robertson<br>
<a class="moz-txt-link-abbreviated" href="mailto:Joseph.Robertson@sanmina-sci.com">Joseph.Robertson@sanmina-sci.com</a><br>
  <br>
  <br>
  <br>
-----Original Message-----<br>
From: urwithsudheer [<a href="mailto:urwithsudheer@gmail.com">mailto:urwithsudheer@gmail.com</a>]<br>
Sent: Fri 7/13/2007 4:25 AM<br>
To: Robertson, Joseph M.<br>
Cc: <a class="moz-txt-link-abbreviated" href="mailto:linuxppc-embedded@ozlabs.org">linuxppc-embedded@ozlabs.org</a><br>
Subject: Re: XSysAce driver cant mount DOS part<br>
  <br>
Hi<br>
  <br>
Robertson, Joseph M. wrote:<br>
&gt;<br>
&gt; Hi all,<br>
&gt;<br>
&gt; I've been workig with this for a while but have made no progress.<br>
&gt; Today I got the latest XSysAce patch for kernel 2.6.17.1 and
applied<br>
&gt; it to get clean code.<br>
&gt; I inherited the previous code from another developer.<br>
&gt;<br>
Can you send the link to xsysace driver source code from where you
obtained.<br>
  <br>
  <br>
Thanks<br>
Sudheer<br>
  <br>
  <br>
&gt;<br>
&gt; My problem is that mounting the DOS partition always fails in a
short<br>
&gt; time with a kernel oops.<br>
&gt;<br>
&gt; ECAU-9999:# Oops: kernel access of bad area, sig: 11<br>
&gt; [#1]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt;
PREEMPT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; NIP: C00701C8 LR: C0070C18 CTR:<br>
&gt; 00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; REGS: c0391dd0 TRAP: 0300&nbsp;&nbsp; Not tainted&nbsp;<br>
&gt; (2.6.17.1)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; MSR: 00021030 &lt;ME,IR,DR&gt;&nbsp; CR: 22028082&nbsp; XER:<br>
&gt; 0000000B&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; DAR: 00000000, DSISR:<br>
&gt; 00800000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; TASK = c0373030[4] 'events/0' THREAD:<br>
&gt; c0390000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; GPR00: 00000080 C0391E80 C0373030 C02CAC00 C0E03000 C0E03154
00000000<br>
&gt; C02CAC00<br>
&gt; GPR08: 00200200 00000000 00100100 00000000 00051A4B FFFFDE60
03BD4900<br>
&gt; 007FFF3B<br>
&gt; GPR16: 00400000 00000001 FFFFFFFF 03BCDC58 00000000 007FFF00
00000002<br>
&gt; C0280000<br>
&gt; GPR24: C0363A10 0000000B 00000000 00000000 00000000 C02CAC00
C035ED20<br>
&gt; C0E03000<br>
&gt; NIP [C00701C8]<br>
&gt; free_block+0x8c/0x138&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; LR [C0070C18]<br>
&gt; drain_array+0xb8/0x124&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; Call Trace:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt;<br>
&gt; The setup:<br>
&gt; My own build system.<br>
&gt; Kernel 2.6.17.1 with lots of xilinx stuff, eth, i2c, xsysace.&nbsp;<br>
&gt; Crosscompiled for PPC405.<br>
&gt; Latest, clean XSysAce code.&nbsp; mods:&nbsp; major hardcoded to = 125.&nbsp;
Polled<br>
&gt; mode.<br>
&gt; CF:&nbsp; 3 partitions,<br>
&gt; 1:&nbsp; DOS FAT16<br>
&gt; 2:&nbsp; Ext2&nbsp; main<br>
&gt; 3:&nbsp; Ext2&nbsp; rescue<br>
&gt;<br>
&gt; This build boots up fine, mounts a ext2 as root fine.&nbsp; I can also<br>
&gt; mount the rescue partition with no problems.<br>
&gt;<br>
&gt; Does anyone have any pointers of where I should look for problems?<br>
&gt;<br>
&gt; My next step is to go and set it up for interrupt service and see
if<br>
&gt; that changes anything.<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Joe Robertson<br>
&gt; <a class="moz-txt-link-abbreviated" href="mailto:Joseph.Robertson@sanmina-sci.com">Joseph.Robertson@sanmina-sci.com</a><br>
&gt;<br>
&gt;<br>
&gt; CONFIDENTIALITY<br>
&gt; This e-mail message and any attachments thereto, is intended only
for<br>
&gt; use by the addressee(s) named herein and may contain legally<br>
&gt; privileged and/or confidential information. If you are not the<br>
&gt; intended recipient of this e-mail message, you are hereby notified<br>
&gt; that any dissemination, distribution or copying of this e-mail<br>
&gt; message, and any attachments thereto, is strictly prohibited. If
you<br>
&gt; have received this e-mail message in error, please immediately
notify<br>
&gt; the sender and permanently delete the original and any copies of
this<br>
&gt; email and any prints thereof.<br>
&gt; ABSENT AN EXPRESS STATEMENT TO THE CONTRARY HEREINABOVE, THIS
E-MAIL<br>
&gt; IS NOT INTENDED AS A SUBSTITUTE FOR A WRITING. Notwithstanding the<br>
&gt; Uniform Electronic Transactions Act or the applicability of any
other<br>
&gt; law of similar substance and effect, absent an express statement to<br>
&gt; the contrary hereinabove, this e-mail message its contents, and any<br>
&gt; attachments hereto are not intended to represent an offer or<br>
&gt; acceptance to enter into a contract and are not otherwise intended
to<br>
&gt; bind the sender, Sanmina-SCI Corporation (or any of its
subsidiaries),<br>
&gt; or any other person or entity.<br>
&gt;
------------------------------------------------------------------------<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Linuxppc-embedded mailing list<br>
&gt; <a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br>
&gt; <a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br>
  <br>
  <br>
  </font>
  </p>
  <br>
CONFIDENTIALITY<br>
This e-mail message and any attachments thereto, is intended only for
use by the addressee(s) named herein and may contain legally privileged
and/or confidential information. If you are not the intended recipient
of this e-mail message, you are hereby notified that any dissemination,
distribution or copying of this e-mail message, and any attachments
thereto, is strictly prohibited. If you have received this e-mail
message in error, please immediately notify the sender and permanently
delete the original and any copies of this email and any prints thereof.<br>
ABSENT AN EXPRESS STATEMENT TO THE CONTRARY HEREINABOVE, THIS E-MAIL IS
NOT INTENDED AS A SUBSTITUTE FOR A WRITING. Notwithstanding the Uniform
Electronic Transactions Act or the applicability of any other law of
similar substance and effect, absent an express statement to the
contrary hereinabove, this e-mail message its contents, and any
attachments hereto are not intended to represent an offer or acceptance
to enter into a contract and are not otherwise intended to bind the
sender, Sanmina-SCI Corporation (or any of its subsidiaries), or any
other person or entity.<br>
</blockquote>
<br>
</body>
</html>

--------------040007070903040900020106--
