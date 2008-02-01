Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 23857DE350
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 04:39:16 +1100 (EST)
Date: Fri, 1 Feb 2008 11:38:34 -0600
From: Scott Wood <scottwood@freescale.com>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: Kernel oops while duming user core.
Message-ID: <20080201173834.GD671@ld0162-tx32.am.freescale.net>
References: <DCEAAC0833DD314AB0B58112AD99B93B03EE44A5@ismail.innsys.innovsys.com>
	<20080131161527.GT14201@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080131161527.GT14201@localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 31, 2008 at 10:15:27AM -0600, Nathan Lynch wrote:
> Rune Torgersen wrote:
> > Hi
> > 
> > I get the following kernel core while a user program I have is dumping
> > core.
> > Any DIeas at what to look for? (this is runnign 2.6.24, arch/powerpc on
> > a 8280)
> > When runnign the program on 2.6.18 arch/ppc, the program gets a sig 11
> > and dumps core.
> > On 2.6.24, I ghet the kernel oops, and then the program hangs sround
> > forever and is unkillable.
> 
> Hmm, this is the second report of 2.6.24 crashing in
> __flush_dcache_icache during a core dump; see:
> http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048662.html
> 
> Is this easily recreatable?

Yes, this program does it reliably:

#include <pthread.h>
#include <stdio.h>
#include <unistd.h>
#include <signal.h>

void *threadfn(void *arg)
{
	fprintf(stderr, "threadfn\n");
	fflush(stderr);
	sleep(1);
	*(char *)0=0;
	return NULL;
}

int main(void)
{
	pthread_t thread[4];
	int i;

	for (i = 0; i < 4; i++)
		pthread_create(&thread[0], NULL, threadfn, NULL);

	for (;;);
}
