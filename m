Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206]) by ozlabs.org (Postfix) with ESMTP id B0C7BB713A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Sep 2010 08:37:59 +1000 (EST)
Received: from mail25-am1 (localhost.localdomain [127.0.0.1])	by
	mail25-am1-R.bigfish.com (Postfix) with ESMTP id 042371AE82F6	for
	<linuxppc-dev@lists.ozlabs.org>; Thu,  9 Sep 2010 22:37:52 +0000 (UTC)
Received: from am1ehsmhs004.bigfish.com (unknown [10.3.201.240])	by
	mail25-am1.bigfish.com (Postfix) with ESMTP id 9B64D2A8057	for
	<linuxppc-dev@lists.ozlabs.org>; Thu,  9 Sep 2010 22:37:51 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o89Mbc90016173	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 9 Sep 2010 15:37:48 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o89MqbRM000562	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 9 Sep 2010 17:52:37 -0500 (CDT)
Date: Thu, 9 Sep 2010 17:37:35 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: CONFIG_PROVE_LOCKING broken on 83xx (and all of powerpc?)
Message-ID: <20100909173735.503c4cc0@schlenkerla.am.freescale.net>
In-Reply-To: <1284070433.6515.39.camel@pasglop>
References: <20100908232124.GB30291@ovro.caltech.edu>
	<1283994156.6515.6.camel@pasglop>
	<20100909025214.GA21846@ovro.caltech.edu>
	<1284001096.6515.33.camel@pasglop>
	<20100909162306.GA3496@ovro.caltech.edu>
	<1284069534.6515.36.camel@pasglop>
	<20100909171116.1b9b6e44@schlenkerla.am.freescale.net>
	<1284070433.6515.39.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: peterz@infradead.org, mingo@redhat.com, linuxppc-dev@lists.ozlabs.org,
	"Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 10 Sep 2010 08:13:53 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Thu, 2010-09-09 at 17:11 -0500, Scott Wood wrote:
> > > I would have expected uboot to warn (the kernel ELF header contains
> > the
> > > BSS size) but apparently that isn't the case.
> > 
> > U-Boot doesn't use ELF files with Linux, so it has no idea where the
> > BSS is.  uImage is just a wrapper around a flat binary.
> 
> Oh, right, I forgot about that... -1 for uboot there. Seriously, it's
> time it grows the ability to load ELF or to at least stick an ELF in a
> uImage...

It actually can load an ELF file, but it doesn't currently support
passing a device tree to it (only argc/argv text arguments, or some
vxworks stuff).

> I've never understood the reasoning for that uImage wrapper
> thingy. Definitely causes more problems than it solves in my experience.

Wolfgang was just defending it on the U-Boot list the past couple
days...  seems like the main thing in its favor is the CRC, especially
as a final check before reflashing an image.

-Scott
