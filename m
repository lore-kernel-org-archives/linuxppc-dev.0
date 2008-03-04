Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C1B0DDEEF3
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 06:18:32 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m24JIMQv021993
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Mar 2008 12:18:23 -0700 (MST)
Date: Tue, 4 Mar 2008 13:18:44 -0600
From: Scott Wood <scottwood@freescale.com>
To: Jon Loeliger <jdl@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Re: dtc: Make some functions local to parser
Message-ID: <20080304191844.GA7810@loki.buserror.net>
References: <20080304043700.GB2757@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080304043700.GB2757@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 04, 2008 at 03:37:00PM +1100, David Gibson wrote:
> * The Bison documentation explicitly permits yyerror() to be a
>   variadic function, so fold yyerror() and yyerrorf() into a single
>   printf-style function.

Then the bison documentation is not consistent with the bison
implementation when verbose error messages are enabled.  How can it possibly
know whether to put % or %% in the string when an unexpected % is
encountered?

Reading bison internals makes my head hurt...

>   The combined function is defined and used
>   only in the parse, so make it static.

Static-izing something that is used externally in a posted patch where
you've provided no alternate to use is rather bad form...

-Scott
