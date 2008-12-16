Return-Path: <brueckner@linux.vnet.ibm.com>
Received: from mtagate1.uk.ibm.com (mtagate1.uk.ibm.com [194.196.100.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5DAACDDEF2
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 21:09:47 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id mBGA9eeO027934
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 10:09:40 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id mBGA9dX8643152
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 10:09:39 GMT
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id mBGA9cLh023839
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 10:09:39 GMT
Date: Tue, 16 Dec 2008 11:09:38 +0100
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: [patch 1/1 v2] hvc_console: escape magic sysrq key
Message-ID: <20081216100938.GA22294@cetus.boeblingen.de.ibm.com>
References: <20081216091544.061115344@linux.vnet.ibm.com>
	<20081216092408.362722962@linux.vnet.ibm.com>
	<jeiqpkcvgo.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <jeiqpkcvgo.fsf@sykes.suse.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PPC devel <linuxppc-dev@ozlabs.org>,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Andreas,

thanks for your comments.

On Tue, Dec 16, 2008 at 10:36:55AM +0100, Andreas Schwab wrote:
> > +					/* if ^0 is pressed again, reset
> > +					 * sysrq_pressed and flip ^0 char */
> The comment says ^0 twice when ^O is meant.
Correct. I have updated the comment.

> > +					sysrq_pressed = (sysrq_pressed) ? 0 : 1;
>                                         sysrq_pressed = !sysrc_pressed;
Ok, it might look better.


[PATCH v2] hvc_console: escape magic sysrq key

From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

The ctrl-o (^O) is a common control key used by several applications like vim.

To allow users to send ^O to the terminal, this patch introduces a check
if ^O is pressed again if the sysrq_pressed variable is already set.
In this case, clear sysrq_pressed state and flip the ^O character to the tty.
(The old behavior has always set "sysrq_pressed" if ^O has been entered, and it
has not flipped the ^O character to the tty.)

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 drivers/char/hvc_console.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -642,8 +642,11 @@ int hvc_poll(struct hvc_struct *hp)
 				/* Handle the SysRq Hack */
 				/* XXX should support a sequence */
 				if (buf[i] == '\x0f') {	/* ^O */
-					sysrq_pressed = 1;
-					continue;
+					/* if ^O is pressed again, reset
+					 * sysrq_pressed and flip ^O char */
+					sysrq_pressed = !sysrq_pressed;
+					if (sysrq_pressed)
+						continue;
 				} else if (sysrq_pressed) {
 					handle_sysrq(buf[i], tty);
 					sysrq_pressed = 0;
