Return-Path: <robin.gilks@tait.co.nz>
Received: from gatekeeper.tait.co.nz (tel096021.tait.co.nz [202.37.96.21])
	by ozlabs.org (Postfix) with ESMTP id 162DA67B20
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Apr 2005 09:41:51 +1000 (EST)
Received: from gatekeeper.tait.co.nz (merlin.tait.co.nz [127.0.0.1])
	by localhost.tait.co.nz (Postfix) with ESMTP id BBA8B10BA7F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Apr 2005 11:17:19 +1200 (NZST)
Received: from sunstrike.tait.co.nz (unknown [172.25.40.92])
	by gatekeeper.tait.co.nz (Postfix) with ESMTP id 0298B10BA7E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Apr 2005 11:17:19 +1200 (NZST)
Received: from conversion-daemon.sunstrike.tait.co.nz by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	id <0IEU00L01WHGGW00@sunstrike.tait.co.nz>
	(original mail from robin.gilks@tait.co.nz) for
	linuxppc-embedded@ozlabs.org; Wed, 13 Apr 2005 11:17:18 +1200 (NZST)
Received: from [172.25.114.91] by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	with ESMTP id <0IEU00L9VWOU6H00@sunstrike.tait.co.nz> for
	linuxppc-embedded@ozlabs.org; Wed, 13 Apr 2005 11:17:18 +1200 (NZST)
Date: Wed, 13 Apr 2005 11:17:18 +1200
From: Robin Gilks <robin.gilks@tait.co.nz>
To: ppc embedded list <linuxppc-embedded@ozlabs.org>
Message-id: <425C56FE.2020308@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Subject: 8xx UART TX > 8 data bits
Reply-To: robin.gilks@tait.co.nz
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Greetings

I'm trying to get an SMC channel to operate as a UART with more than 8 
data bits (13 in fact!!). Using a 2.4.22 kernel on a mpc859 (basic 866).

This means its going to be getting two half words from the BDs for each 
'character'. With the constraints of the SMC requiring even addresses 
etc for this mode of operation, does anyone know if it will work writing 
2x8 bit characters at a time so as to keep the existing tty structure 
for SMC handling?

I've tried tracing the tty layers by code inspection but I keep getting 
lost in the indirections!! If I could find how the BDs are allocated as 
a result of a character write, then perhaps I could make minor mods to 
ensure memory allocs on an even address.

Could be that I'm totally off the wall but I'm trying for a 'minimum 
effort' viability hack :-))

-- 
Robin Gilks
Senior Design Engineer          Phone: (+64)(3) 357 1569
Tait Electronics                Fax  :  (+64)(3) 359 4632
PO Box 1645 Christchurch        Email : robin.gilks@tait.co.nz
New Zealand

=======================================================================
This email, including any attachments, is only for the intended
addressee.  It is subject to copyright, is confidential and may be
the subject of legal or other privilege, none of which is waived or
lost by reason of this transmission.
If the receiver is not the intended addressee, please accept our
apologies, notify us by return, delete all copies and perform no
other act on the email.
Unfortunately, we cannot warrant that the email has not been
 altered or corrupted during transmission.
=======================================================================
