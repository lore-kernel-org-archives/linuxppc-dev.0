Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 522CADDF57
	for <linuxppc-dev@ozlabs.org>; Fri,  2 May 2008 02:14:57 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m41GEqtQ012665
	for <linuxppc-dev@ozlabs.org>; Thu, 1 May 2008 09:14:52 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m41GEp2X017057
	for <linuxppc-dev@ozlabs.org>; Thu, 1 May 2008 11:14:51 -0500 (CDT)
Date: Thu, 1 May 2008 11:14:51 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Rework EXC_LEVEL_EXCEPTION_PROLOG code
Message-ID: <20080501161451.GH17142@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.64.0804300424040.31028@blarg.am.freescale.net>
	<1209592495.18023.246.camel@pasglop>
	<12ECF63E-7CEA-48FD-9447-7D534C29271D@kernel.crashing.org>
	<18457.1279.401197.763726@cargo.ozlabs.ibm.com>
	<A9B566F7-D00B-4202-9B85-427C38EE6070@kernel.crashing.org>
	<18457.32297.485053.356477@cargo.ozlabs.ibm.com>
	<2DF41779-732B-4477-9DAC-147CDC5C9885@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2DF41779-732B-4477-9DAC-147CDC5C9885@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 01, 2008 at 08:17:07AM -0500, Kumar Gala wrote:
> On May 1, 2008, at 3:24 AM, Paul Mackerras wrote:
> >The most common cases are (a) something that ultimately generates
> >input on a tty (e.g. a character arriving on a serial port) and that
> >input turns out to be a ^C or similar, or (b) something that signals
> >I/O completion and the program doing the I/O has requested
> >notification by a SIGIO.  But in general any driver code can send a
> >signal to userspace if it wants.

And, of course, SIGALRM and similar timer mechanisms.

> ok.  Was just wondering how the async exception know that the signal  
> it wanted to send belonged to the particular process that is running.   
> But I guess there are cases that the signal is really intended for who  
> ever is currently running?

No, it knows based on its own data structures who it's intended for --
and sometimes that happens to be the currently running process.

-Scott
