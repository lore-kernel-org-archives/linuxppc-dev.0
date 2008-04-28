Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D27E6DDEF6
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 01:59:33 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m3SFxSXp003063
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 08:59:29 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3SFxS7P018342
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 10:59:28 -0500 (CDT)
Date: Mon, 28 Apr 2008 10:59:28 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: suggestions on handling additional exception levels on ppc32
Message-ID: <20080428155928.GE9849@ld0162-tx32.am.freescale.net>
References: <DF3B8F4C-EAE1-4F44-8884-44535A855139@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DF3B8F4C-EAE1-4F44-8884-44535A855139@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 28, 2008 at 10:40:56AM -0500, Kumar Gala wrote:
> A few possibilities:
> * introduce an additional function pointer as part of  
> EXC_XFER_TEMPLATE() to specifies the type of handler (normal, crit,  
> dbg, mcheck)
> * use the traps field low order bits to determine normal, crit, dbg,  
> mcheck at run time.
> * duplicate the code paths for each exception level
> 
> suggestions?

You could temporarily disable all asynchronous exceptions, and use the
registers of the highest-priority exception type.

-Scott
