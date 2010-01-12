Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D65CA1007D9
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 13:34:15 +1100 (EST)
Subject: hibernation BookE patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Vorontsov <cbouatmailru@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 12 Jan 2010 13:34:08 +1100
Message-ID: <1263263648.724.182.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anton !

For some reason I can't find that patch in my mailbox (just saw it on
patchwork :-)

Here's a quick review. Looks good but two things:

 - Please make it swsusp_booke.c, 44x support is trivial and I don't
want to rename the file :-)

 - Is there really an SDR1 register on FSL BookE ? It's supposed to be
the pointer to the hash table on server ...

 - You probably should save/restore the TCR and ack pending crap DEC or
FIT interrupts in the TSR right before you kick the decrementer

 - Nowadays, we still assume that the "loader" kernel is exactly the
same as the "loaded" kernel on resume ? If not, you may need to
save/restore IVORs, IVPR, ...

Cheers,
Ben.
