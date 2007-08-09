Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EF142DDDF8
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Aug 2007 23:47:04 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IJ8Ll-0003E7-FB
	for linuxppc-embedded@ozlabs.org; Thu, 09 Aug 2007 15:46:53 +0200
Received: from p5497ff37.dip.t-dialin.net ([84.151.255.55])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 09 Aug 2007 15:46:53 +0200
Received: from dzu by p5497ff37.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 09 Aug 2007 15:46:53 +0200
To: linuxppc-embedded@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: signals handling in the kernel
Date: Thu, 09 Aug 2007 15:47:12 +0200
Message-ID: <m2ps1wyg4f.fsf@ohwell.denx.de>
References: <12032525.post@talk.nabble.com> <46B8A3C9.7060806@ovro.caltech.edu>
	<46B8BA93.8020909@ovro.caltech.edu> <12048974.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
Cc: Mirek23 <miroslaw.dach@psi.ch>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Miroslaw,

> I did not find however what would be the best way to propagate interrupt
> signals to the USER level / notify the client that interrupt has occurred.

Follow the advice given here before (and in the book you mention), and
implement poll() in the driver and use select() from userspace to
react to it.  That's the natural solution in the Unix context for what
you are trying to do.  It is not a coincidence that I can only find 3
references to kill_proc below drivers/.

Of course you are welcome to solve your actual problem (using
kill_proc like e.g. drivers/char/watchdog/wd.c) but I am very sure
that you will rediscover the information in the preceding paragraph
the hard way.

Bets wishes
  Detlev

-- 
You get 3 opportunities to advertise your Rock band, no more.
           -- Proposed Symbolics guidelines for mail messages (1984)
--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
