Return-Path: <Gerald.VanBaren@smiths-aerospace.com>
Received: from smtp1.smiths.com (smtp1.smiths.com [192.208.34.50])
	by ozlabs.org (Postfix) with ESMTP id 91A682BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Nov 2004 02:25:53 +1100 (EST)
Received: from COSSMGIMS01.email.corp.tld (unknown [10.225.225.141])
	by smtp1.smiths.com (Postfix) with ESMTP id 9DB5B1C00B03
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Nov 2004 08:25:35 -0700 (MST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 17 Nov 2004 08:25:31 -0700
Message-ID: <065ACD8E84315E4394C835E398C8D5EBA9DC96@COSSMGMBX02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: low-boot configuration to MPC8260ADS family boards (Again)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: alebas@televes.com [mailto:alebas@televes.com]=0D
> Sent: Wednesday, November 17, 2004 10:13 AM
> To: linuxppc-embedded@ozlabs.org; Ge@televes.com
> Cc: VanBaren, Gerald (AGRE)
> Subject: low-boot configuration to MPC8260ADS family boards (Again)
>=0D
> Hi,
>=0D
> My board is back, at last. Indeed, a new one has arrived. :-)=0D
> OK, finally I think HRCW for MPC8272ADS board for flash=0D
> lowboot should be 0x0E_74_B2_4A. But this is still not=0D
> working. The board keeps reseting all the time.
>=0D
> With the jumper JP9 set to config from flash, i have checked=0D
> the contents of flash when halted ...
>=0D
>=0D
> 8272>md 0
> 00000000 : 00000e0e 00000e0e 00007474 00007474 =0D
> ..........tt..tt 00000010 : 0000b2b2 0000b2b2 00004a4a=0D
> 00004a4a  ..........JJ..JJ 00000020 : 00000000 00000000=0D
> 00000000 00000000  ................
> 00000030 : 00000000 00000000 00000000 00000000  ................
> 00000040 : 00000000 00000000 00000000 00000000  ................
> 00000050 : 00000000 00000000 00000000 00000000  ................
> 00000060 : 00000000 00000000 00000000 00000000  ................
>=0D
> So, this isn't what is supposed to be. Here HRCW will be load=0D
> as 0x00000000 and the uboot code will also be corrupted with=0D
> the same problem.
>=0D
> However, when I check flash contents with the jumper JP9=0D
> pointing to the BCSR, flash begining is...
>=0D
> 8272>md 0xff800000
> ff800000 : 0e0e0e0e 0e0e0e0e 74747474 74747474 =0D
> ........tttttttt ff800010 : b2b2b2b2 b2b2b2b2 4a4a4a4a=0D
> 4a4a4a4a  ........JJJJJJJJ ff800020 : 00000000 00000000=0D
> 00000000 00000000  ................
> ff800030 : 00000000 00000000 00000000 00000000  ................
> ff800040 : 00000000 00000000 00000000 00000000  ................
> ff800050 : 00000000 00000000 00000000 00000000  ................
>=0D
>=0D
> which is OK (and the same flash area than before).
>=0D
> So, why can I view only 16 bits from each 32 bits in flash? Any idea?
> Must I change any other jumper?
>=0D
> Thanks,
>=0D
> Alex

It looks like you have your HRCW/flash/BR0 (any or all of the
preceeding) memory width misconfigured.  That is why you are seeing
0000xyxy -- you should see xyxyxyxy (four repeated bytes).  The PQ2FADS
flash is 32 bits wide, is the MPC8272ADS?  Your second HRCW byte "74" is
selecting 8 bits port size (BPS field) -- it looks like you are
configured for booting from EEPROM (8 bits wide), not flash.  I suspect
it should be "B4" which is what I'm using on the PQ2FADS.

The PQ2FADS can select either flash (8MByte, 32 bits wide) or EEPROM
(32K, 8 bits wide).  Obviously, you want to select flash, not EEPROM.
U-boot is not going to fit in EEPROM (per its design :-).  Is that the
"other jumper" you refer to?

gvb

******************************************
The following messages are brought to you by the Lawyers' League of
IdioSpeak:

******************************************
The information contained in, or attached to, this e-mail, may contain=
 confidential information and is intended solely for the use of the=
 individual or entity to whom they are addressed and may be subject to=
 legal privilege.  If you have received this e-mail in error you should=
 notify the sender immediately by reply e-mail, delete the message from=
 your system and notify your system manager.  Please do not copy it for any=
 purpose, or disclose its contents to any other person.  The views or=
 opinions presented in this e-mail are solely those of the author and do=
 not necessarily represent those of the company.  The recipient should=
 check this e-mail and any attachments for the presence of viruses.  The=
 company accepts no liability for any damage caused, directly or=
 indirectly, by any virus transmitted in this email.
******************************************
