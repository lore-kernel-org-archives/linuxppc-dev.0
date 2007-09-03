Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 06D33DDE00
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Sep 2007 02:11:58 +1000 (EST)
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 03 Sep 2007 18:11:56 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <20070903101234.GA12212@localhost.localdomain>
Message-ID: <20070903161156.306700@gmx.net>
MIME-Version: 1.0
References: <20070831175006.17240@gmx.net>
	<20070903013431.GG31499@localhost.localdomain>
	<1188808900.5972.133.camel@localhost.localdomain>
	<ad58529dfd4a248ab904c2c5871258bf@kernel.crashing.org>
	<20070903101234.GA12212@localhost.localdomain>
Subject: Re: [RFC] AmigaOne device tree source v2
To: David Gibson <david@gibson.dropbear.id.au>, segher@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

-------- Original-Nachricht --------
> Datum: Mon, 3 Sep 2007 20:12:34 +1000
> Von: David Gibson <david@gibson.dropbear.id.au>
> An: Segher Boessenkool <segher@kernel.crashing.org>
> CC: linuxppc-dev@ozlabs.org
> Betreff: Re: [RFC] AmigaOne device tree source v2

> On Mon, Sep 03, 2007 at 12:02:58PM +0200, Segher Boessenkool wrote:
> > Yeah, PCI is a special case for Linux.  Maybe add a "pciclass,XXXX"
> > compatible property though, for good measure.  Anything else isn't
> > all that useful I think.
Wouldn't that be the same as the class-code property?

> Indeed, since PCI is probable, it's unclear whether these device nodes
> are even necessary at all.  Depends on whether there's anything
> interesting in the omitted interrupt routing information.
Well, I mainly specified the device node for the IDE controller, because
it works in compatible mode and thus the IDE driver needs to know about
the I/O ports. I guess the driver doesn't probe the BARs, if the
controller is configured for compatible mode (and AFAIK a VIA IDE
controller cannot be made work in fully native mode). Also the ppc_ide_md
function hooks are considered obsolete.
The interrupts for the IDE controller are another story. Judging from
what some developers wrote on this mailing list, there doesn't seem to
be a way to define legacy IDE interrupts (14 & 15) for a PCI device node.
Therefore I'll reuse the IDE interrupt quirk for the Pegasos.

Gerhard
-- 
GMX FreeMail: 1 GB Postfach, 5 E-Mail-Adressen, 10 Free SMS.
Alle Infos und kostenlose Anmeldung: http://www.gmx.net/de/go/freemail
