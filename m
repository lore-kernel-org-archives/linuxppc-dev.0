Return-Path: <dell.query@yahoo.com>
Received: from n5b.bullet.ukl.yahoo.com (n5b.bullet.ukl.yahoo.com
	[217.146.183.159]) by ozlabs.org (Postfix) with SMTP id 2EDBBDDEA3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Nov 2007 14:22:37 +1100 (EST)
Date: Wed, 28 Nov 2007 19:16:08 -0800 (PST)
From: Dell Query <dell.query@yahoo.com>
Subject: Re: Unable to Read PPC440EPx Board ID thru Board Control and Status
	Registers (BCSR)
To: Stefan Roese <sr@denx.de>, linuxppc-embedded@ozlabs.org
In-Reply-To: <200711281151.45446.sr@denx.de>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-17013953-1196306168=:76659"
Message-ID: <556469.76659.qm@web45605.mail.sp1.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-17013953-1196306168=:76659
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I don't know if the document that came with the PPC440EPx Sequoia Resource CD is right. It is odd that it is entitled "Embedded Planet 440xC" and it showed in page 34:
-----------------------------------------------------------------------
Table 4-4. Memory Map
                            
 Function               Start Address   End Address    Size Chip Select
 DDR SDRAM              0x0000 0000     0x0FFF FFFF  256 MB —
 PCI Memory             0x8000 0000     0xBFFF FFFF 1024 MB —
 BCSR                   0xC000 0000     0xCFFF FFFF  256 MB CS2
 NAND FLASH Controller1 0xD000 0000     0xD00F FFFF    1 MB CS3/CS0
 NOR FLASH1             0xFC00 0000     0xFFFF FFFF   64 MB CS0/CS3
-----------------------------------------------------------------------
Anyway, I have seen Table 1. System Memory Address Map and it got EBC mapped at 0x1.c000.0000 and another one at 0x1.f000.0000.  But I didn't see any BCSR info. Correct me if I am wrong, but should it not give me BCSR details like:

Register 0 = ID         Board ID
Register 1 = 0000 0000  CPLD revision
Register 2 = 0000 xxxx  User dip-switch / LEDs
Register 3 = 0000 xxxx  Configuration dip-switch
Register 4 = 0000 0000  TMRCLK control
Register 5 = 0000 0000  PCI control, status, info
Register 6 = 0000 0000  Reset control
Register 7 = 0000 001x  Memory control
Register 8 = 0000 0000  Ethernet control
Register 9 = 0000 0001  USB control
Register 10 = 0000 0000 Performance timer (MS Byte, bits 27-24)
Register 11 = 0000 0000 Performance timer (bits 23-16)
Register 12 = 0000 0000 Performance timer (bits 15-8)
Register 13 = 0000 0000 Performance timer (LS Byte, bits 7-0)


Regards,

dell
Stefan Roese <sr@denx.de> wrote: On Wednesday 28 November 2007, Dell Query wrote:
> Oh is it 0x1C0002000?

Just to be sure here, we are talking about the AMCC Sequoia board, right?

> Where can I get the document? What I have is 0xC0002000 from
> ep440xc_um_amcc.pdf file that I get from the accompanying PPC440EPx
> resource CD.

Please take a look at the 440EPx data sheet. It has a nice table with an 
overview of the address maps (table 1). Here you will notice that the EBC has 
multiple maps, one starting at 0x1.c000.0000 and another one at 
0x1.f000.0000. Yes, these are 36bit physical addresses. In U-Boot these are 
mapped via the TLB to 0xc000.0000 and 0xf000.0000. So in U-Boot you are able 
to access the CPLD at 0xc0000000. But in Linux you have to map the 36bit 
address to get the virtual address which you need for accessing. And using 
arch/ppc you need to call ioremap64() with this 36bit address as parameter.

Hope this helps.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================


       
---------------------------------
Get easy, one-click access to your favorites.  Make Yahoo! your homepage.
--0-17013953-1196306168=:76659
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I don't know if the document that came with the PPC440EPx Sequoia Resource CD is right. It is odd that it is entitled "Embedded Planet 440xC" and it showed in page 34:<br>-----------------------------------------------------------------------<br>Table 4-4. Memory Map<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;Function&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Start Address&nbsp;&nbsp; End Address&nbsp;&nbsp;&nbsp; Size Chip Select<br>&nbsp;DDR SDRAM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000 0000&nbsp;&nbsp;&nbsp;&nbsp; 0x0FFF FFFF&nbsp; 256 MB —<br>&nbsp;PCI Memory&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8000 0000&nbsp;&nbsp;&nbsp;&nbsp; 0xBFFF FFFF 1024 MB
 —<br>&nbsp;BCSR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xC000 0000&nbsp;&nbsp;&nbsp;&nbsp; 0xCFFF FFFF&nbsp; 256 MB CS2<br>&nbsp;NAND FLASH Controller1 0xD000 0000&nbsp;&nbsp;&nbsp;&nbsp; 0xD00F FFFF&nbsp;&nbsp;&nbsp; 1 MB CS3/CS0<br>&nbsp;NOR FLASH1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xFC00 0000&nbsp;&nbsp;&nbsp;&nbsp; 0xFFFF FFFF&nbsp;&nbsp; 64 MB CS0/CS3<br>-----------------------------------------------------------------------<br>Anyway, I have seen Table 1. System Memory Address Map and it got EBC mapped at 0x1.c000.0000 and another one at 0x1.f000.0000.&nbsp; But I didn't see any BCSR info. Correct me if I am wrong, but should it not give me BCSR details like:<br><br>Register 0 = ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Board ID<br>Register 1 = 0000 0000&nbsp; CPLD revision<br>Register 2 = 0000 xxxx&nbsp; User dip-switch / LEDs<br>Register 3 = 0000
 xxxx&nbsp; Configuration dip-switch<br>Register 4 = 0000 0000&nbsp; TMRCLK control<br>Register 5 = 0000 0000&nbsp; PCI control, status, info<br>Register 6 = 0000 0000&nbsp; Reset control<br>Register 7 = 0000 001x&nbsp; Memory control<br>Register 8 = 0000 0000&nbsp; Ethernet control<br>Register 9 = 0000 0001&nbsp; USB control<br>Register 10 = 0000 0000 Performance timer (MS Byte, bits 27-24)<br>Register 11 = 0000 0000 Performance timer (bits 23-16)<br>Register 12 = 0000 0000 Performance timer (bits 15-8)<br>Register 13 = 0000 0000 Performance timer (LS Byte, bits 7-0)<br><br><br>Regards,<br><br>dell<br><b><i>Stefan Roese &lt;sr@denx.de&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> On Wednesday 28 November 2007, Dell Query wrote:<br>&gt; Oh is it 0x1C0002000?<br><br>Just to be sure here, we are talking about the AMCC Sequoia board, right?<br><br>&gt; Where can I get the document? What I
 have is 0xC0002000 from<br>&gt; ep440xc_um_amcc.pdf file that I get from the accompanying PPC440EPx<br>&gt; resource CD.<br><br>Please take a look at the 440EPx data sheet. It has a nice table with an <br>overview of the address maps (table 1). Here you will notice that the EBC has <br>multiple maps, one starting at 0x1.c000.0000 and another one at <br>0x1.f000.0000. Yes, these are 36bit physical addresses. In U-Boot these are <br>mapped via the TLB to 0xc000.0000 and 0xf000.0000. So in U-Boot you are able <br>to access the CPLD at 0xc0000000. But in Linux you have to map the 36bit <br>address to get the virtual address which you need for accessing. And using <br>arch/ppc you need to call ioremap64() with this 36bit address as parameter.<br><br>Hope this helps.<br><br>Best regards,<br>Stefan<br><br>=====================================================================<br>DENX Software Engineering GmbH,     MD: Wolfgang Denk &amp; Detlev Zundel<br>HRB 165235 Munich, Office:
 Kirchenstr.5, D-82194 Groebenzell, Germany<br>Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de<br>=====================================================================<br></blockquote><br><p>&#32;
      <hr size=1>Get easy, one-click access to your favorites. 
<a href="http://us.rd.yahoo.com/evt=51443/*http://www.yahoo.com/r/hs"> Make Yahoo! your homepage.</a>


--0-17013953-1196306168=:76659--
