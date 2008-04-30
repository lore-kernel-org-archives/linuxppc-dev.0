Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D2EBADDF3C
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 09:51:42 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3UNpdSK002703
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 19:51:39 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3UNpdSk266958
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 19:51:39 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3UNpdIL009706
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 19:51:39 -0400
Date: Wed, 30 Apr 2008 18:45:02 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] convert transfer_to_handler into a macro
Message-ID: <20080430184502.4f0c66e2@zod.rchland.ibm.com>
In-Reply-To: <2A2997EA-F3AF-4C90-8952-42CA48AA07BC@kernel.crashing.org>
References: <Pine.LNX.4.64.0804290856210.9230@blarg.am.freescale.net>
	<18455.37613.709102.30668@cargo.ozlabs.ibm.com>
	<73CD5806-5CE4-40A7-957B-8F164E26FAFB@kernel.crashing.org>
	<1209537128.18023.225.camel@pasglop>
	<EDF2E889-4B04-42A8-8D93-E04B35162661@kernel.crashing.org>
	<1209592794.18023.248.camel@pasglop>
	<2A2997EA-F3AF-4C90-8952-42CA48AA07BC@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 30 Apr 2008 17:04:08 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Apr 30, 2008, at 4:59 PM, Benjamin Herrenschmidt wrote:
> >
> > On Wed, 2008-04-30 at 03:02 -0500, Kumar Gala wrote:
> >> got that.  Does 40x/44x have anything similar we need to save/ 
> >> restore?
> >
> > MMUCR I'd say... look at what our tlbie does there...
> 
> thanks.  Will take a look.  I just plan on overloading MMUCR with MAS0.

Erg.  Why?  Please don't do that.  This is common code and MAS0 doesn't
make much sense on 4xx.  It'll be confusing to anyone that isn't aware
of this change.

Can we come up with a generic #define that gets used instead?

josh
