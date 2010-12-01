Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0FAA4B6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Dec 2010 07:57:12 +1100 (EST)
Subject: Re: _extending_ platform support options?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20101201134719.GA1053@zod.rchland.ibm.com>
References: <4CF64CD7.2060802@gmx.de>
	<20101201134719.GA1053@zod.rchland.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 02 Dec 2010 07:57:02 +1100
Message-ID: <1291237022.32570.396.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Joachim Foerster <JOFT@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-12-01 at 08:47 -0500, Josh Boyer wrote:
> >Though, to me, it does not seem really OK to assign ppc_md members
> >that way. The original struct machdep for "virtex" (which is defined
> >in virtex.c with define_machine()) is not adjusted either. Ok, we
> >could modify that one, too.
> >Especially I'm not sure if it is OK to use machine_core_initcall()
> for such modifications.
> >
> >So my question is: Is there any recommended way for doing such
> >"extensions"? Or is it OK to just duplicate virtex.c (which does not
> >seem really OK, too)?
> 
> Duplicate it as you have done, naming the file something unique.  We
> try
> to prevent unnecessary duplication of code, but sometimes it's cleaner
> to just have a separate board file instead. 

Right. Best way is to turn the common code in virtex.c into "library"
code that you can hookup from your platform's ppc_md, so you avoid
duplication that way for most things.

You an do that by just linking in virtex.c and changing the stuff you
want to be non-static, or better if that becomes a habit, separate
virtex-lib.c (for example) from virtex-simple.c (generic platform for
example). You don't have to follow my proposed names :-)

Cheers,
Ben.
