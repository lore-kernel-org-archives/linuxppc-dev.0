Return-Path: <ALEBAS@televes.com>
Received: from televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with SMTP id 6CDFC2BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Nov 2004 19:33:38 +1100 (EST)
Message-ID: <51DB8827D393D411BB69003048003F46FDCF65@tvesntr.televes.com>
From: Bastos Fernandez Alexandre <ALEBAS@televes.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Thu, 18 Nov 2004 09:32:10 +0100
MIME-Version: 1.0
Content-Type: text/plain
Cc: "'Gerald.VanBaren@smiths-aerospace.com'"
	<Gerald.VanBaren@smiths-aerospace.com>
Subject: RE: Linuxppc-embedded Digest, Vol 3, Issue 25
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Gerald,

The MPC8272ADS board has also a 32 bits wide flash.
But in the doc, the BPS field appears in the first byte of the HRCW, bits
4-5,
which is 11 in "0x0E". So I should be using 32 bit wide access, not 16 bit
wide.
I am booting from flash, at least it should. Both jumper JP9 and SW2 are
selected following doc indications. In fact, those 16 bits I get, are from
flash's
contents. The jumper I was asking for would be another bad documented one.

I think you are right and my flash width is misconfigured. But it's the
reason
I cannot figure out. That is why I was asking for phantom jumpers.

Alex

> -----Original Message-----
> 
> It looks like you have your HRCW/flash/BR0 (any or all of the
> preceeding) memory width misconfigured.  That is why you are seeing
> 0000xyxy -- you should see xyxyxyxy (four repeated bytes).  The PQ2FADS
> flash is 32 bits wide, is the MPC8272ADS?  Your second HRCW byte "74" is
> selecting 8 bits port size (BPS field) -- it looks like you are
> configured for booting from EEPROM (8 bits wide), not flash.  I suspect
> it should be "B4" which is what I'm using on the PQ2FADS.
> 
> The PQ2FADS can select either flash (8MByte, 32 bits wide) or EEPROM
> (32K, 8 bits wide).  Obviously, you want to select flash, not EEPROM.
> U-boot is not going to fit in EEPROM (per its design :-).  Is that the
> "other jumper" you refer to?
> 
> gvb
