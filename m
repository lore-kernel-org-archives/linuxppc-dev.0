Return-Path: <SRS0=cDAn=QV=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 4A437DDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Nov 2007 21:56:30 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Unable to Read PPC440EPx Board ID thru Board Control and Status
	Registers (BCSR)
Date: Wed, 28 Nov 2007 11:51:45 +0100
References: <639733.2036.qm@web45601.mail.sp1.yahoo.com>
In-Reply-To: <639733.2036.qm@web45601.mail.sp1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200711281151.45446.sr@denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 28 November 2007, Dell Query wrote:
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
