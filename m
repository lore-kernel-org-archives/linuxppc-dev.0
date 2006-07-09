Return-Path: <eranpublic@yahoo.com>
Received: from web61326.mail.yahoo.com (web61326.mail.yahoo.com
	[209.73.178.255]) by ozlabs.org (Postfix) with SMTP id 0CB57679E2
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Jul 2006 00:07:50 +1000 (EST)
Message-ID: <20060709140108.33871.qmail@web61326.mail.yahoo.com>
Date: Sun, 9 Jul 2006 07:01:08 -0700 (PDT)
From: E B <eranpublic@yahoo.com>
Subject: board hangs during reboot
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Hi,

When I tried to restart the board (using reboot
command), after all services being shut down, the
board hangs .The last printed line is "Restarting
system." .
I implemented the restart api as follows:

        u32 jumpaddr=0xfff00100;
	u32 defaultmsr=MSR_IP;

	_disable_interrupts();

	__asm__ __volatile__("\n\
	mtspr   26, %1  /* SRR0 */
	mtspr   27, %0  /* SRR1 */
	rfi"
	:
	: "r" (defaultmsr), "r" (jumpaddr));
	
            /*
	 * Not reached
	 */


I'm using IBM750Gl cpu .

Does anyone familiar with this ?

Regards,

Eran.

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
