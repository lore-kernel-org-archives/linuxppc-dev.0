Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 792D8DDDE9
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 08:52:50 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: benh@kernel.crashing.org
Subject: Re: [PATCH v2 2/2] [POWERPC] Use new machine_xxx_initcall hooks in
	platform code
Date: Tue, 4 Dec 2007 22:52:36 +0100
References: <20071202061028.21193.39309.stgit@trillian.secretlab.ca>
	<200712042036.00785.arnd@arndb.de>
	<1196800273.13230.333.camel@pasglop>
In-Reply-To: <1196800273.13230.333.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200712042252.37308.arnd@arndb.de>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, olof@lixom.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 04 December 2007, Benjamin Herrenschmidt wrote:
> On Tue, 2007-12-04 at 20:35 +0100, Arnd Bergmann wrote:
> > 
> > 1. If another platform gets added that uses the same firmware feature,
> > it
> > will automatically do the right thing.
> 
> Yes but is it something that we want to happen ? That is, do we want
> code somewhere in a platform/foo dir to run when using platform/bar
> because they happen to share a feature ?

It should be decided case-by-case of course. My assumption was that
in those places where we currently check the firmware feature, that
is actually the right thing to do.

For the lv1 specific device drivers (vuart, sound, graphics, ...),
my feeling is that they should really check for lv1, not for ps3,
because the check for lv1 is only needed in order to make sure
that you can run the hcall that probes for the actual device.

For some of the iseries checks, it would be more logical to test
the platform instead of the firmware feature IMHO, but I don't see a
significant reason to change that.

	Arnd <><
