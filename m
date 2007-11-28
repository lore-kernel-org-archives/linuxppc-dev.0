Return-Path: <jan.kratochvil@redhat.com>
Received: from pauline.vellum.cz (pauline.vellum.cz [89.250.243.234])
	by ozlabs.org (Postfix) with ESMTP id 1A5FBDDDF5
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 19:59:19 +1100 (EST)
Date: Wed, 28 Nov 2007 09:59:07 +0100
From: Jan Kratochvil <jan.kratochvil@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: PPC upstream kernel ignored DABR bug
Message-ID: <20071128085907.GA19651@host0.dyn.jankratochvil.net>
References: <20071126220224.GA5606@host0.dyn.jankratochvil.net>
	<200711272335.36981.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200711272335.36981.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 27 Nov 2007 23:35:36 +0100, Arnd Bergmann wrote:
> On Monday 26 November 2007, Jan Kratochvil wrote:
> > Hi,
> > 
> > this testcase:
> >         http://people.redhat.com/jkratoch/dabr-lost.c
> > 
> > reproduces a PPC DABR kernel bug.  The variable `variable' should not get
> > modified as the thread modifying it should be caught by its DABR:
> > 
> > $ ./dabr-lost
> > TID 30914: DABR 0x10012a77 NIP 0x80f6ebb318
> > TID 30915: DABR 0x10012a77 NIP 0x80f6ebb318
> > TID 30916: DABR 0x10012a77 NIP 0x80f6ebb318
> > TID 30914: hitting the variable
> > TID 30915: hitting the variable
> > TID 30916: hitting the variable
> > variable found = 30916, caught TID = 30914
> > TID 30916: DABR 0x10012a77
> > Variable got modified by a thread which has DABR still set!
> > 
> 
> This sounds like a bug recently reported by Uli Weigand. BenH
> said he'd take a look, but it probably fell under the table.
> The problem found by Uli is that on certain processors (Cell/B.E.
> in his case), the DABRX register needs to be set in order for
> the DABR to take effect.

Please be aware DABR works fine if the same code runs just 1 (always) or
2 (sometimes) threads.  It starts failing with too many threads running:

$ ./dabr-lost
TID 32725: DABR 0x1001279f NIP 0xfecf41c
TID 32726: DABR 0x1001279f NIP 0xfecf41c
TID 32725: hitting the variable
variable found = -1, caught TID = 32725
TID 32726: hitting the variable
variable found = -1, caught TID = 32726
The kernel bug did not get reproduced - increase THREADS.

As I did not find any code in that kernel touching DABRX its value should not
be dependent on the number of threads running.


Regards,
Lace
