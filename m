Return-Path: <robin.gilks@tait.co.nz>
Received: from gatekeeper.tait.co.nz (gatekeeper.tait.co.nz [202.37.96.11])
	by ozlabs.org (Postfix) with ESMTP id 4F6EC67D29
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Nov 2006 11:14:55 +1100 (EST)
Received: from gatekeeper.tait.co.nz (localhost.localdomain [127.0.0.1])
	by localhost.tait.co.nz (Postfix) with ESMTP id 1CE98467DF
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Nov 2006 13:14:54 +1300 (NZDT)
Received: from sunstrike.tait.co.nz (sunstrike [172.25.40.92])
	by gatekeeper.tait.co.nz (Postfix) with ESMTP id 0A6B2467DB
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Nov 2006 13:14:54 +1300 (NZDT)
Received: from conversion-daemon.sunstrike.tait.co.nz by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	id <0J8D00001WFKOT00@sunstrike.tait.co.nz>
	(original mail from robin.gilks@tait.co.nz) for
	linuxppc-embedded@ozlabs.org; Wed, 08 Nov 2006 13:14:53 +1300 (NZDT)
Received: from [172.25.140.15] by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	with ESMTP id <0J8D00GTDY0S9MF0@sunstrike.tait.co.nz> for
	linuxppc-embedded@ozlabs.org; Wed, 08 Nov 2006 13:14:52 +1300 (NZDT)
Date: Wed, 08 Nov 2006 13:14:44 +1300
From: Robin Gilks <robin.gilks@tait.co.nz>
Subject: 2.6.18 fails in call_usermodedata() on 8xx
To: ppc embedded list <linuxppc-embedded@ozlabs.org>
Message-id: <45512174.7020205@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
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

Having (sort of) mastered the bdi2000, I'm trying to bring up a 8xx card
thats been debugged and working with a 2.4 kernel for the last 3 years
but is failing miserably on a 2.6.18 kernel.

My initial problems in dma_alloc_init I seem to have fixed by moving
CONFIG_CONSISTENT_START to 0xa0000000 from the default of 0xff100000 but
now I'm failing in call_usermodedata(). Any attempt to check the values 
of structures (eg. current->fs->root) results in an error of the form:

(gdb) print *current
Cannot access memory at address 0xc01e27a8

so I'm a bit stuck with further debugging.

Is there anything I should be looking out for in particular with an 8xx
CPU and a late 2.6 kernel? My understanding was that it now worked but
the config documentation is a bit thin on the ground :-(

Cheers

-- 
Robin


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
