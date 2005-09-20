Return-Path: <jeff@theptrgroup.com>
Received: from mail.theptrgroup.com (unknown [209.183.211.17])
	by ozlabs.org (Postfix) with ESMTP id 6877C682F4
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Sep 2005 04:43:18 +1000 (EST)
From: Jeff Angielski <jeff@theptrgroup.com>
To: Rune Torgersen <runet@innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B859463@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B859463@ismail.innsys.innovsys.com>
Content-Type: text/plain
Date: Tue, 20 Sep 2005 14:40:16 -0400
Message-Id: <1127241616.8600.50.camel@nighteyes.site>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: wait_event and interrupts
Reply-To: jeff@theptrgroup.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2005-09-20 at 12:56 -0500, Rune Torgersen wrote:

> Is there a better way of doing this?

If you *must* share the variable between interrupt and non-interrupt
context, you must mutex it in an interrupt safe way.  The use of
spin_lock_irqsave() comes to mind for you read function.

But you are going to have other problems with this approach anyways
since you "appear" to be assuming a one-to-one relationship between your
interrupt handler and the read function.  Is that really true?

Jeff Angielski
The PTR Group
