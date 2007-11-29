Return-Path: <dell.query@yahoo.com>
Received: from n8a.bullet.ukl.yahoo.com (n8a.bullet.ukl.yahoo.com
	[217.146.183.156]) by ozlabs.org (Postfix) with SMTP id 128B8DDE35
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Nov 2007 17:41:16 +1100 (EST)
Date: Wed, 28 Nov 2007 22:41:13 -0800 (PST)
From: Dell Query <dell.query@yahoo.com>
Subject: Re: Unable to Read PPC440EPx Board ID thru Board Control and Status
	Registers (BCSR)
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200711290710.29403.sr@denx.de>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1308264224-1196318473=:56121"
Message-ID: <772588.56121.qm@web45611.mail.sp1.yahoo.com>
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

--0-1308264224-1196318473=:56121
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I see. No wonder I couldn't get more information on BCSR. I should contact sequoia to get the proper details like the correct addresses. 

I already used ioremap64(), remapping 0x1c0002000. I got a hex value for the Board ID but could figure out what it means. So I tried the USER_LED0/USER_LED1 (base address+0x2), to see if I could turn on/off the user LEDS, but still no luck.
I think I am accessing the wrong addresses so I need to verify it with them.

Thanks!

Regards,
dell
Stefan Roese <sr@denx.de> wrote: On Thursday 29 November 2007, Dell Query wrote:
> I don't know if the document that came with the PPC440EPx Sequoia Resource
> CD is right. It is odd that it is entitled "Embedded Planet 440xC" and it
> showed in page 34:
> -----------------------------------------------------------------------
> Table 4-4. Memory Map
>
>  Function               Start Address   End Address    Size Chip Select
>  DDR SDRAM              0x0000 0000     0x0FFF FFFF  256 MB —
>  PCI Memory             0x8000 0000     0xBFFF FFFF 1024 MB —
>  BCSR                   0xC000 0000     0xCFFF FFFF  256 MB CS2
>  NAND FLASH Controller1 0xD000 0000     0xD00F FFFF    1 MB CS3/CS0
>  NOR FLASH1             0xFC00 0000     0xFFFF FFFF   64 MB CS0/CS3
> -----------------------------------------------------------------------
> Anyway, I have seen Table 1. System Memory Address Map and it got EBC
> mapped at 0x1.c000.0000 and another one at 0x1.f000.0000.  But I didn't see
> any BCSR info. Correct me if I am wrong, but should it not give me BCSR
> details like:

This is board specific information and not CPU specific. The CPLD with it's 
BCSR is a Sequoia thing and can therefor not be listed in the 440EPx manuals. 
It it located on the EBC though which is documented in the 440EPx manuals.

So if this chips select which is connected to the CPLD is mapped to 
0xc000.0000 which is the case for Sequoia, then you will "find" these 
registers at physical address 0x1.c000.0000. And should use ioremap64() to 
get the virtual address to access this CPLD.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================


       
---------------------------------
Get easy, one-click access to your favorites.  Make Yahoo! your homepage.
--0-1308264224-1196318473=:56121
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I see. No wonder I couldn't get more information on BCSR. I should contact sequoia to get the proper details like the correct addresses. <br><br>I already used ioremap64(), remapping 0x1c0002000. I got a hex value for the Board ID but could figure out what it means. So I tried the USER_LED0/USER_LED1 (base address+0x2), to see if I could turn on/off the user LEDS, but still no luck.<br>I think I am accessing the wrong addresses so I need to verify it with them.<br><br>Thanks!<br><br>Regards,<br>dell<br><b><i>Stefan Roese &lt;sr@denx.de&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> On Thursday 29 November 2007, Dell Query wrote:<br>&gt; I don't know if the document that came with the PPC440EPx Sequoia Resource<br>&gt; CD is right. It is odd that it is entitled "Embedded Planet 440xC" and it<br>&gt; showed in page 34:<br>&gt;
 -----------------------------------------------------------------------<br>&gt; Table 4-4. Memory Map<br>&gt;<br>&gt;  Function               Start Address   End Address    Size Chip Select<br>&gt;  DDR SDRAM              0x0000 0000     0x0FFF FFFF  256 MB —<br>&gt;  PCI Memory             0x8000 0000     0xBFFF FFFF 1024 MB —<br>&gt;  BCSR                   0xC000 0000     0xCFFF FFFF  256 MB CS2<br>&gt;  NAND FLASH Controller1 0xD000 0000     0xD00F FFFF    1 MB CS3/CS0<br>&gt;  NOR FLASH1             0xFC00 0000     0xFFFF FFFF   64 MB CS0/CS3<br>&gt; -----------------------------------------------------------------------<br>&gt; Anyway, I have seen Table 1. System Memory Address Map and it got EBC<br>&gt; mapped at 0x1.c000.0000 and another one at 0x1.f000.0000.  But I didn't see<br>&gt; any BCSR info. Correct me if I am wrong, but should it not give me BCSR<br>&gt; details like:<br><br>This is board specific information and not CPU specific. The CPLD with it's
 <br>BCSR is a Sequoia thing and can therefor not be listed in the 440EPx manuals. <br>It it located on the EBC though which is documented in the 440EPx manuals.<br><br>So if this chips select which is connected to the CPLD is mapped to <br>0xc000.0000 which is the case for Sequoia, then you will "find" these <br>registers at physical address 0x1.c000.0000. And should use ioremap64() to <br>get the virtual address to access this CPLD.<br><br>Best regards,<br>Stefan<br><br>=====================================================================<br>DENX Software Engineering GmbH,     MD: Wolfgang Denk &amp; Detlev Zundel<br>HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany<br>Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de<br>=====================================================================<br></blockquote><br><p>&#32;
      <hr size=1>Get easy, one-click access to your favorites. 
<a href="http://us.rd.yahoo.com/evt=51443/*http://www.yahoo.com/r/hs"> Make Yahoo! your homepage.</a>


--0-1308264224-1196318473=:56121--
