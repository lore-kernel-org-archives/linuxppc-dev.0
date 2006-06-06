Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id E7F0267B1E
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Jun 2006 08:13:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: 82xx CPM commands
Date: Tue, 6 Jun 2006 17:13:35 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0189DE17@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi.

Besause of some weird system hangs we have seen, I am wondering if the
CPM command register may need a lock around it.

In one of our drivers we can end up writing a CPM command every
millisecond on worst case during an error condition.
Sometimes during that error condition the whole CPU locks up. (or rather
it spins in an interrupt somewhere).

After looking at all the other places in the kernel the CPM command
register gets written, I am convinced that there does exists conditions
where we might accidentally write to the command register while some
other thread/irq is writing/waiting for command completion.

The code in all paces looks like:

	cp->cp_cpcr =3D mk_cr_cmd(SOME COMMAND);
	while (cp->cp_cpcr & CPM_CR_FLG);

I think we might need a lock around it.
local_irq_save() woild work, but would lock the whole CPU while the CPM
command completes (which can take 200 CPM clock cycles, avg 40 according
to maual)

Easiest way would probaby be to have a (inline) function that does the
lock/write/wait/unlock.

There is a couple of places that does a udelay between the write and the
wait.
