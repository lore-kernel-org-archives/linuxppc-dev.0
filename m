Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 96845DDE0C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Mar 2007 02:41:38 +1100 (EST)
Subject: Exception in kernel mode
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 15 Mar 2007 08:41:35 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A197@MERCURY.inside.istor.com>
In-Reply-To: <CF7E46FCFF66AD478BB72724345289EC27953E@twx-exch01.twacs.local>
From: "Charles Krinke" <ckrinke@istor.com>
To: <linuxppc-embedded@ozlabs.org>
Cc: Chris Carlson <ccarlson@istor.com>, Kevin Smith <ksmith@istor.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have a PPC8241 which does an=20

Oops: Exception in kernel mode, sig: 4 [#1]
PREEMPT
NIP: 00000900 LR: C00E579C CTR: 00003A55

When doing a 'tar -xvzf'. The NIP is pointing at the decrementer
interrupt, I believe.

As I understand the decrementer, this is basically the timer tick in the
ppc and goes off every n ms continuously.=20

A tar is going to be concerned with date/time stamps on files, so it has
some interaction with the clock algorithms.

It seems to me that the decrementer should be able to go off at any time
during kernel operation, so maybe the "Exception in kernel mode" is
pointing us in an unusual direction.

So, with that said:

"What might be the causes of such an exception from the decrementer in a
2.6.17.11 ppc8241 kernel?"

"Where should one concentrate ones efforts in figuring this out?"

Charles
