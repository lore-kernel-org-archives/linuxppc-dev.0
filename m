Return-Path: <dell.query@yahoo.com>
Received: from n6b.bullet.ukl.yahoo.com (n6b.bullet.ukl.yahoo.com
	[217.146.182.216]) by ozlabs.org (Postfix) with SMTP id EA790DDDE9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Nov 2007 21:01:43 +1100 (EST)
Date: Thu, 29 Nov 2007 02:01:40 -0800 (PST)
From: Dell Query <dell.query@yahoo.com>
Subject: Re: Unable to Read PPC440EPx Board ID thru Board Control and Status
	Registers (BCSR)
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200711290756.32565.sr@denx.de>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1523945702-1196330500=:37238"
Message-ID: <539126.37238.qm@web45608.mail.sp1.yahoo.com>
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

--0-1523945702-1196330500=:37238
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Stefan,

1. I used the 0x1c0002000 offset because I was referring to the first reply that I received. Now, I used the address 0x1c0002000 and tried to read from it. I retrieved 0x0f01c087. May I know what does this mean? How does this data relate to Board ID?

2. Referring back to "Embedded Planet 440xC" document, I tried to activate the USER_LED0/USER_LED1 (with new address 0x1c0000000 + 0x2 offset) by setting it to 0. But didn't see the led turned on. Did some experiments and tried 0x1c0000000 without offset, sent 0, and found that USER_LED0 (CR3) and USER_LED1 (CR4) are activated! This got me confused. May I know why is this so? Could you please refer me to some documents?


Thanks for all the assistance.

Regards,
dell
Stefan Roese <sr@denx.de> wrote: On Thursday 29 November 2007, Dell Query wrote:
> I see. No wonder I couldn't get more information on BCSR. I should contact
> sequoia to get the proper details like the correct addresses.
>
> I already used ioremap64(), remapping 0x1c0002000. I got a hex value for
> the Board ID but could figure out what it means. So I tried the
> USER_LED0/USER_LED1 (base address+0x2), to see if I could turn on/off the
> user LEDS, but still no luck. I think I am accessing the wrong addresses so
> I need to verify it with them.

Why do think you need the offset 0x2000? I just tested on my Sequoia under 
U-Boot and "see" the CPLD at address 0xc000.0000:

=> md.b c0000000 20
c0000000: 0f 00 c0 07 00 80 00 80 00 20 00 00 00 00 00 00    ......... ......
c0000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................

So you should map not 0x1.c000.2000 but 0x1.c000.0000 under Linux. Please let 
me know if this works.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================


       
---------------------------------
Never miss a thing.   Make Yahoo your homepage.
--0-1523945702-1196330500=:37238
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Stefan,<br><br>1. I used the 0x1c0002000 offset because I was referring to the first reply that I received. Now, I used the address 0x1c0002000 and tried to read from it. I retrieved 0x0f01c087. May I know what does this mean? How does this data relate to Board ID?<br><br>2. Referring back to <tt><tt>"Embedded Planet 440xC" document, I tried to activate the USER_LED0/USER_LED1 (with new address 0x1c0000000 + 0x2 offset) by setting it to 0. But didn't see the led turned on. Did some experiments and tried 0x1c0000000 without offset, sent 0, and found that USER_LED0 (CR3) and USER_LED1 (CR4) are activated! This got me confused. May I know why is this so? Could you please refer me to some documents?<br><br><br>Thanks for all the assistance.<br><br>Regards,<br>dell<br></tt></tt><b><i>Stefan Roese &lt;sr@denx.de&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> On Thursday 29 November 2007, Dell
 Query wrote:<br>&gt; I see. No wonder I couldn't get more information on BCSR. I should contact<br>&gt; sequoia to get the proper details like the correct addresses.<br>&gt;<br>&gt; I already used ioremap64(), remapping 0x1c0002000. I got a hex value for<br>&gt; the Board ID but could figure out what it means. So I tried the<br>&gt; USER_LED0/USER_LED1 (base address+0x2), to see if I could turn on/off the<br>&gt; user LEDS, but still no luck. I think I am accessing the wrong addresses so<br>&gt; I need to verify it with them.<br><br>Why do think you need the offset 0x2000? I just tested on my Sequoia under <br>U-Boot and "see" the CPLD at address 0xc000.0000:<br><br>=&gt; md.b c0000000 20<br>c0000000: 0f 00 c0 07 00 80 00 80 00 20 00 00 00 00 00 00    ......... ......<br>c0000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................<br><br>So you should map not 0x1.c000.2000 but 0x1.c000.0000 under Linux. Please let <br>me know if this works.<br><br>Best
 regards,<br>Stefan<br><br>=====================================================================<br>DENX Software Engineering GmbH,     MD: Wolfgang Denk &amp; Detlev Zundel<br>HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany<br>Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de<br>=====================================================================<br></blockquote><br><p>&#32;

      <hr size=1>Never miss a thing.  <a href="http://us.rd.yahoo.com/evt=51438/*http://www.yahoo.com/r/hs"> Make Yahoo your homepage.</a>


--0-1523945702-1196330500=:37238--
