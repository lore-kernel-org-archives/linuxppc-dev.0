Return-Path: <schwab@suse.de>
Received: from Cantor.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 329412BC0F
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Oct 2004 22:47:08 +1000 (EST)
Received: from hermes.suse.de (hermes-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by Cantor.suse.de (Postfix) with ESMTP id 1BB51DFD788
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Oct 2004 14:23:31 +0200 (CEST)
To: linuxppc-dev@ozlabs.org
From: Andreas Schwab <schwab@suse.de>
Date: Thu, 21 Oct 2004 14:23:30 +0200
Message-ID: <je7jpkxnst.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: Signal handler can clobber fpu regs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Apparently the scratch fpu registers are not saved around calls to signal
handlers.  Here is a test case, when run the output changes every second,
tested with 2.6.9:

#include <stdio.h>
#include <signal.h>
#include <sys/time.h>

void
sigalarm (int sig)
{
  static double x[] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
  static int i;
  asm volatile ("lfd 0,%0" : : "Q" (x[i++]));
  if (i == sizeof (x) / sizeof (*x))
    i = 0;
}

int
main (void)
{
  static struct itimerval one_second = { { 1, 0 }, { 1, 0 } };
  static double zero;
  setitimer (ITIMER_REAL, &one_second, 0);
  signal (SIGALRM, sigalarm);
  asm volatile ("lfd 0,%0" : : "Q" (zero));
  for (;;)
    {
      union { double d; unsigned int i[2]; } x;
      asm volatile ("stfd 0,%0" : "=Q" (x.d));
      printf ("f0 = %08x%08x\n", x.i[0], x.i[1]);
    }
}

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
