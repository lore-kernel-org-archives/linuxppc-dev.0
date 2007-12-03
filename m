Return-Path: <dell.query@yahoo.com>
Received: from n8.bullet.ukl.yahoo.com (n8.bullet.ukl.yahoo.com
	[217.146.182.188]) by ozlabs.org (Postfix) with SMTP id 5ACFCDDDFE
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Dec 2007 18:17:27 +1100 (EST)
Date: Sun, 2 Dec 2007 23:17:25 -0800 (PST)
From: Dell Query <dell.query@yahoo.com>
Subject: Re: Unable to Read PPC440EPx Board ID thru Board Control and Status
	Registers (BCSR)
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200711291113.10356.sr@denx.de>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1637888658-1196666245=:82133"
Message-ID: <86675.82133.qm@web45613.mail.sp1.yahoo.com>
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

--0-1637888658-1196666245=:82133
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Stefan,

I finally got the new pdf files from other Resource CDs and used 0xc000000 address, without 0x2000 offset.

It works! Thanks a lot for the help.

But may I know why in Linux it is mapped to 0x1c000000, wherein the doc stated 0xc000000?

Thanks a lot!

Stefan Roese <sr@denx.de> wrote: Hi Dell (???),

On Thursday 29 November 2007, Dell Query wrote:
> 1. I used the 0x1c0002000 offset because I was referring to the first reply
> that I received. Now, I used the address 0x1c0002000 and tried to read from
> it. I retrieved 0x0f01c087. May I know what does this mean? How does this
> data relate to Board ID?

Please refer to the document describing the CPLD registers. They are byte 
registers and not 32bit lword registers (see below).

> 2. Referring back to "Embedded Planet 440xC" document, I tried to activate
> the USER_LED0/USER_LED1 (with new address 0x1c0000000 + 0x2 offset) by
> setting it to 0. But didn't see the led turned on. Did some experiments and
> tried 0x1c0000000 without offset, sent 0, and found that USER_LED0 (CR3)
> and USER_LED1 (CR4) are activated! This got me confused. May I know why is
> this so? Could you please refer me to some documents?

The address of the CPLD is without this 0x2000 offset as it seems. Maybe the 
Sequoia users manual is incorrect here.

Make sure that you address these registers with the correct functions. That is 
in_8()/out_8(). Here a log from U-Boot:

=> md.l c0000000 1
c0000000: 0f00c007    ....
=> md.b c0000000 4
c0000000: 0f 00 c0 07    ....

By writing 0x00 to offset 0x02 (LED control) I am able to set the user led's. 
This should work in Linux the same way:

=> mw.b c0000002 00

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================


       
---------------------------------
Be a better sports nut! Let your teams follow you with Yahoo Mobile. Try it now.
--0-1637888658-1196666245=:82133
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Stefan,<br><br>I finally got the new pdf files from other Resource CDs and used 0xc000000 address, without 0x2000 offset.<br><br>It works! Thanks a lot for the help.<br><br>But may I know why in Linux it is mapped to 0x1c000000, wherein the doc stated 0xc000000?<br><br>Thanks a lot!<br><br><b><i>Stefan Roese &lt;sr@denx.de&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Hi Dell (???),<br><br>On Thursday 29 November 2007, Dell Query wrote:<br>&gt; 1. I used the 0x1c0002000 offset because I was referring to the first reply<br>&gt; that I received. Now, I used the address 0x1c0002000 and tried to read from<br>&gt; it. I retrieved 0x0f01c087. May I know what does this mean? How does this<br>&gt; data relate to Board ID?<br><br>Please refer to the document describing the CPLD registers. They are byte <br>registers and not 32bit lword registers (see below).<br><br>&gt; 2. Referring back to
 "Embedded Planet 440xC" document, I tried to activate<br>&gt; the USER_LED0/USER_LED1 (with new address 0x1c0000000 + 0x2 offset) by<br>&gt; setting it to 0. But didn't see the led turned on. Did some experiments and<br>&gt; tried 0x1c0000000 without offset, sent 0, and found that USER_LED0 (CR3)<br>&gt; and USER_LED1 (CR4) are activated! This got me confused. May I know why is<br>&gt; this so? Could you please refer me to some documents?<br><br>The address of the CPLD is without this 0x2000 offset as it seems. Maybe the <br>Sequoia users manual is incorrect here.<br><br>Make sure that you address these registers with the correct functions. That is <br>in_8()/out_8(). Here a log from U-Boot:<br><br>=&gt; md.l c0000000 1<br>c0000000: 0f00c007    ....<br>=&gt; md.b c0000000 4<br>c0000000: 0f 00 c0 07    ....<br><br>By writing 0x00 to offset 0x02 (LED control) I am able to set the user led's. <br>This should work in Linux the same way:<br><br>=&gt; mw.b c0000002
 00<br><br>Best regards,<br>Stefan<br><br>=====================================================================<br>DENX Software Engineering GmbH,     MD: Wolfgang Denk &amp; Detlev Zundel<br>HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany<br>Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de<br>=====================================================================<br></blockquote><br><p>&#32;
      <hr size=1>Be a better sports nut! Let your teams follow you 
with Yahoo Mobile. <a href="http://us.rd.yahoo.com/evt=51731/*http://mobile.yahoo.com/sports;_ylt=At9_qDKvtAbMuh1G1SQtBI7ntAcJ
">Try it now.</a>
--0-1637888658-1196666245=:82133--
