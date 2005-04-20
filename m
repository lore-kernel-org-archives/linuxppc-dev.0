Return-Path: <robin.gilks@tait.co.nz>
Received: from gatekeeper.tait.co.nz (tel096021.tait.co.nz [202.37.96.21])
	by ozlabs.org (Postfix) with ESMTP id 5B34567A2E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Apr 2005 13:19:54 +1000 (EST)
Received: from gatekeeper.tait.co.nz (merlin.tait.co.nz [127.0.0.1])
	by localhost.tait.co.nz (Postfix) with ESMTP id 781EC10BA84
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Apr 2005 15:19:52 +1200 (NZST)
Received: from sunstrike.tait.co.nz (unknown [172.25.40.92])
	by gatekeeper.tait.co.nz (Postfix) with ESMTP id 82A5A10BA7F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Apr 2005 15:19:51 +1200 (NZST)
Received: from conversion-daemon.sunstrike.tait.co.nz by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	id <0IF8002011OI8R00@sunstrike.tait.co.nz>
	(original mail from robin.gilks@tait.co.nz) for
	linuxppc-embedded@ozlabs.org; Wed, 20 Apr 2005 15:19:51 +1200 (NZST)
Received: from [172.25.114.91] by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	with ESMTP id <0IF800FLP6L3L8A0@sunstrike.tait.co.nz> for
	linuxppc-embedded@ozlabs.org; Wed, 20 Apr 2005 15:19:51 +1200 (NZST)
Date: Wed, 20 Apr 2005 15:19:51 +1200
From: Robin Gilks <robin.gilks@tait.co.nz>
To: ppc embedded list <linuxppc-embedded@ozlabs.org>
Message-id: <4265CA57.60400@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Subject: 8xx SMC question
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

Using the uart driver from a snapshot of the Denx kernel of about 18 
months ago (2.4.22 or thereabouts), I'm trying to sort out the reception 
of break. The only information I can find that may help identify the 
code is:
BK Id: SCCS/s.uart.c 1.30 11/19/02 11:58:41 trini

The problem I have is that a break doesn't seem to be reported until 
another character comes along - this means for example that if I get 2 
breaks, only one is reported up to the tty layer (I think - maybe a 
queuing problem at tty level?). The new character is received AFTER the 
break (so ordering is not a problem).

Knowing that there is no really 'standard' SMC driver for 2.4 series 
kernels I'm not sure if this scenario will ring any bells. If there is a 
bit I've missed in the interrupt mask (or whatever) that prevents the 
break being seen, any ideas on what it might be? ie. should I be looking 
at arch/ppc/8xx_io/uart.c or at drivers/char/n_tty.c !!

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
