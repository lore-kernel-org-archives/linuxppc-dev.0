Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC] cell: saving spus information for kexec crash
Date: Fri, 11 May 2007 19:48:12 +0200
References: <200705111353.22781.adetsch@br.ibm.com>
	<20070511172233.GA14587@kryten>
In-Reply-To: <20070511172233.GA14587@kryten>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705111948.12664.arnd@arndb.de>
Cc: Andre Detsch <adetsch@br.ibm.com>, Anton Blanchard <anton@samba.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 11 May 2007, Anton Blanchard wrote:

> > This patch adds support for investigating spus information after a
> > kernel crash event, through kdump vmcore file.
> > Implementation is based on xmon code, but the new functionality was
> > kept independent.
> 
> This brings up a point: it looks like kdump doesnt capture the FP and
> altivec regs. Could be important for some bugs.

Yes, and there are more things that might be worth adding:

- SLB contents (as noticed by Luke Browning)
- some SPRs
- state of some device drivers

We have briefly discussed the idea of having generic notifiers into
which arbitrary subsystems can register, but unless we have more than
one or two users, it's probably not worth it.

> This brings up yet another point, it looks like our userspace core dumps
> dont capture altivec or SPU state.

Actually, the userspace core dumps do capture the SPU state as of 2.6.21,
thanks to the work of Dwayne McConnell :-)

	Arnd <><
