Return-Path: <Gerald.VanBaren@smiths-aerospace.com>
Received: from smtp3.smiths.com (smtp3.smiths.com [192.208.34.52])
	by ozlabs.org (Postfix) with ESMTP id 4C7072BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Dec 2004 08:56:26 +1100 (EST)
Received: from COSSMGIMS04.email.corp.tld (unknown [10.225.225.147])
	by smtp3.smiths.com (Postfix) with ESMTP id 55C161C012AC
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Dec 2004 14:56:16 -0700 (MST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 3 Dec 2004 14:56:13 -0700
Message-ID: <065ACD8E84315E4394C835E398C8D5EBBBED0A@COSSMGMBX02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: "Barbier, Renaud (GE Infrastructure)" <Renaud.Barbier@ge.com>,
	"Matt Porter" <mporter@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: 440GX MMU problem
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
> From: linuxppc-embedded-bounces@ozlabs.org=0D
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of=0D
> Barbier, Renaud (GE Infrastructure)
> Sent: Friday, December 03, 2004 3:53 PM
> To: Matt Porter
> Cc: linuxppc-embedded@ozlabs.org
> Subject: RE: 440GX MMU problem
>=0D
> actually, I just loaded linux at memory offset=0D
> 0x10000000(above 256MB) and in this case it is able to boot=0D
> and use the full 512MB.
> there maybe indeed something broken.
>=0D
> Originally, U-boot did not map the full 512MB but only 256MB.
> I wonder if that could be a possible source of my problem.

Disclaimer: I don't have experience with the 4xx family, but won't stop
me from speculating (which drives Wolfgang crazy when I guess wrong ;-).

On the 82xx u-boot uses BATs to map memory.  On the 82xx, BATs are
limited to 256MBytes per BAT.  I'm guessing you are running into this.
Somewhere in your u-boot it doesn't know how to go beyond the 256MByte
boundary.

On u-boot, check out the use of "CONFIG_VERY_BIG_RAM".  It doesn't look
like it applies directly to your board/processor, but you may be able to
enhance your system using it or a similar concept.

gvb


******************************************
I apologize for the following message brought to you by the Lawyers'
League of IdioSpeak:

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
