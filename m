Return-Path: <marvin24@gmx.de>
Received: from mail.gmx.net (pop.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 7070068479
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Oct 2005 16:14:17 +1000 (EST)
From: Marc <marvin24@gmx.de>
To: "Rune Torgersen" <runet@innovsys.com>
Date: Tue, 4 Oct 2005 08:14:06 +0200
References: <DCEAAC0833DD314AB0B58112AD99B93B859476@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B859476@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510040814.07188.marvin24@gmx.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: clock skew on B/W G3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

given that this option causes problems on non i386 systems, may I propose t=
o=20
mark CONFIG_HZ as broken on these architectures and/or use a default value =
of=20
1000 ? I guess this issue can't be fixed in a sane way until 2.6.14 is out.

Marc

Le Montag 03 Oktober 2005 16:18, Rune Torgersen a =E9crit :
> > -----Original Message-----
> > From:  Marc
> > Sent: Sunday, October 02, 2005 11:46
> >
> > Some additions to the previous mail: I was able to isolate
> > the problem to the
> > introduction of a user specificable value of HZ (in
> > include/asm-ppc/parm.h).
> > I used a value of 250 while the former default was 1000.
> > Setting it back to
> > 1000 makes the clock tick right again.
> >
> > Is the CONFIG_HZ known to be broken on PPC ?
>
> CONFIG_HZ is not broken, but the whole clock configuration is.
> (I poseded something about it for 8260 earlier this summer)
>
> Basic problem is that CLOCK_TICK_RATE which is used for setting up the
> variables used for advancing the clock, is hardcoded to a value that
> only makes sence for an i386. (it is default set at 1193180Hz which
> happens to be the timer clock for timer1 on an i386 machine)
>
> Another problem here is that that value apparently hve to be #define'd
> which means you cannot insert the decrementer frequency from the
> boot-loader either.
