Return-Path: <amodra@bigpond.net.au>
Received: from qsrv01ps.mx.bigpond.com (qsrv01ps.mx.bigpond.com
	[144.140.82.181]) by ozlabs.org (Postfix) with ESMTP id B162767C3A
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Aug 2006 14:17:02 +1000 (EST)
Date: Sun, 13 Aug 2006 12:59:57 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: PowerPC paxtest results w/ gcc-4.1
Message-ID: <20060813032957.GB14822@bubble.grove.modra.org>
References: <787b0d920608112250q551c98f5j328183c31eebaf77@mail.gmail.com>
	<17629.48408.564322.747132@cargo.ozlabs.ibm.com>
	<787b0d920608120736n1ba0bc03jccf2964bf7ebb1d5@mail.gmail.com>
	<17630.27174.711916.643790@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17630.27174.711916.643790@cargo.ozlabs.ibm.com>
Cc: Albert Cahalan <acahalan@gmail.com>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Aug 13, 2006 at 09:54:14AM +1000, Paul Mackerras wrote:
> To get the full benefit of -msecure-plt, every object file in your
> executable has to be compiled with it

Yes.  In particular, glibc startup files need to be compiled with
-msecure-plt.  If ld links any object file that uses the old scheme
requiring an executable .got into the executable, then the old layout is
forced.

>, and I think every shared
> library the program uses has to be compiled with it too.

No, this isn't necessary.

>  On a system
> where everything has been compiled with -msecure-plt, I believe the
> heap and stack will automatically be made non-executable.

Exec stack is a separate issue from the plt/got layout.  You need a
kernel that sets non-exec stack by default and respects PT_GNU_STACK
program header.

-- 
Alan Modra
IBM OzLabs - Linux Technology Centre
