Return-Path: <brueckner@linux.vnet.ibm.com>
Received: from mtagate1.uk.ibm.com (mtagate1.uk.ibm.com [194.196.100.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 12E72DDF18
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 20:14:23 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id m9E9EDFZ015382
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 09:14:13 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m9E9EDtO3883126
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 10:14:13 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m9E9ECRN005220
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 10:14:13 +0100
Message-Id: <20081014091247.433079967@linux.vnet.ibm.com>
Date: Tue, 14 Oct 2008 11:12:47 +0200
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux PPC devel <linuxppc-dev@ozlabs.org>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Rusty Russell <rusty@rustcorp.com.au>, "Ryan S. Arnold" <rsa@us.ibm.com>
Subject: [RFC PATCH 0/5] patches for a network-based hvc backend (s390)
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I work on a network-based hvc console backend for s390 that allows
to get "full-screen" terminal access to z/VM guest machines.
The solution consists of a HVC backend that provides the terminal interface;
and a tool to connect to the terminal via a z/VM specific communication
protocol.

The network-based backend differs in a few aspects from the notifier-based
model of the HVC console; because it has to deal with (dis)connects and must
take care of virtual tty hangups. Therefore, I would like to introduce a third
notifier for hangups (see patch 1).

Further I found out that if put_char() returns 0 in particular cases, the hvc
console starts to loop. I tried to address this problem with patch 3 and I hope
that it will work for all backends.

Finally, I would like to add a function that allows to resize the terminal
window of a HVC terminal (patch 4).


Here is an overview about the complete patch series:
 Patch 1 adds a hangup notifier
 Patch 2 adds tty driver flag TTY_DRIVER_RESET_TERMIOS
 Patch 3 fixes a loop if put_char() returns 0
 Patch 4 adds a function to resize the tty window
 Patch 5 removes __devexit of hvc_remove() for use in __(dev)init sections


Any review feedback would be greatly appreciated.
Thank you in advance.

Regards,
Hendrik
-- 
Hendrik Brueckner
D/3303 Linux on System z Development
Tel: +49 7031 16-1073
Fax: +49 7031 16-3456
eMail: brueckner@linux.vnet.ibm.com
IBM Deutschland Research & Development GmbH, Schoenaicher Str. 220, 71032 Boeblingen

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martin Jetter
Geschaeftsfuehrung: Erich Baier
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
