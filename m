Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 95F1868005
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 02:41:27 +1000 (EST)
Date: Tue, 9 Aug 2005 09:41:25 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Rune Torgersen <runet@innovsys.com>
Message-ID: <20050809164125.GC22053@gate.ebshome.net>
References: <DCEAAC0833DD314AB0B58112AD99B93B859416@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B859416@ismail.innsys.innovsys.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Wall clock accuracy
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Aug 09, 2005 at 10:23:19AM -0500, Rune Torgersen wrote:
> Hi
> 
> I have discovered that the accuracy of the wallclock (xtime) on ppc is
> not very good.
> I am running a custom telco board based on a 8266, and the main busclock
> is derived off of a T1 reference clock.
> I was noticing a huge number of logentries fron OpenNTPD about
> adjustiing the clock, so I started to check.
> The drift of the walltime was a little over 7 seconds in 15 hours (7
> seconds slow) (equals about 130us per s)

Hmm, if I'm correct this clock drift (130ppm) should be handled easily 
by NTPD without stepping clock but with slewing. This is why NTPD 
exists in the first place, so I don't see any reason to change 
the kernel.

It's not small drift (I usually have clock accuracy within +-50ppm), 
but still is much less than maximum 1024ppm NTPD can deal with.

Maybe it's an OpenNTPD problem? I use original NTPD (ntp.org) which 
handles such drifts quite well.

-- 
Eugene
