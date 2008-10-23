Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0AEADDDE1D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Oct 2008 02:31:57 +1100 (EST)
Message-ID: <490098E4.6090908@freescale.com>
Date: Thu, 23 Oct 2008 10:31:48 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: "Gray, Steve - UK" <Steve.Gray@peek-traffic.co.uk>
Subject: Re: Ucode/BD conflict on PowerPC 860
References: <48A15FC3.3060008@vastech.co.za><20080812181138.BEF53248BF@gemini.denx.de>	<48A2A99C.5000309@vastech.co.za>
	<85A8D9AB423A3A4ABD022AD90C989C4D010904A2@uksv0008.peek.prv>
In-Reply-To: <85A8D9AB423A3A4ABD022AD90C989C4D010904A2@uksv0008.peek.prv>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Gray, Steve - UK wrote:
> I have tried a few things, including setting the range of muram to 
> ranges = <0x0 0x3000 0x1000>;
> 
> Am I correct to assume this will push the muram above the microcode??

No, that will confuse the kernel into thinking that muram starts at IMMR 
offset 0x3000.  You need to change the reg property of the data subnode 
to <0x1000 0xc00>, so that you restrict the allocation range without 
affecting the offset that is subtracted from the physical address to 
obtain the value given to the CPM.

-Scott
