Return-Path: <robin.gilks@tait.co.nz>
Received: from gatekeeper.tait.co.nz (unknown [202.37.96.21])
	by ozlabs.org (Postfix) with ESMTP id 1A0272BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Dec 2004 14:49:08 +1100 (EST)
Received: from gatekeeper.tait.co.nz (merlin.tait.co.nz [127.0.0.1])
	by localhost.tait.co.nz (Postfix) with ESMTP id 48EA110BA7A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Dec 2004 16:48:59 +1300 (NZDT)
Received: from sunstrike.tait.co.nz (unknown [172.25.40.92])
	by gatekeeper.tait.co.nz (Postfix) with ESMTP id A887E10BA30
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Dec 2004 16:48:58 +1300 (NZDT)
Received: from conversion-daemon.sunstrike.tait.co.nz by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	id <0I8D00L01VWUF500@sunstrike.tait.co.nz>
	(original mail from robin.gilks@tait.co.nz) for
	linuxppc-embedded@ozlabs.org; Wed, 08 Dec 2004 16:48:58 +1300 (NZDT)
Received: from [172.25.114.91] by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	with ESMTP id <0I8D00D5CX9M9E90@sunstrike.tait.co.nz> for
	linuxppc-embedded@ozlabs.org; Wed, 08 Dec 2004 16:48:58 +1300 (NZDT)
Date: Wed, 08 Dec 2004 16:48:58 +1300
From: Robin Gilks <robin.gilks@tait.co.nz>
To: ppc embedded list <linuxppc-embedded@ozlabs.org>
Message-id: <41B679AA.1090201@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Subject: BDI2000 gdb register display
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

Just been debugging some exception handling stuff and I'm sure that the 
combination of bdi2000, gdb & ddd I have is suffering an 'off by one' 
error in the register display

e.g. I see this
srr0	0x818000
srr1	0x3fca360
tbl	0x9002

But the sensible values of srr0 & srr1 should be

srr0	0x3fca360
srr1	0x9002

so that fault address is in srr0 and the bits from MSR (EE, ME and RI) 
are set in srr1.

Anyone seen this and where is the slippage coming from (r0 to r31 look 
OK as far as I can see but don't really know about the others!!).

I've tried both REGLIST ALL and REGLIST SPR in the bdi2000 config but it 
doesn't appear to make a difference.

bdi2000 code=1.13, fpga=1.02
mpc8xx target
gdb 5.3
ddd 3.3.1

Many thanks

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
