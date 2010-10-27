Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CC389B70CD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 28 Oct 2010 09:05:35 +1100 (EST)
Message-ID: <50654.84.105.60.153.1288217125.squirrel@gate.crashing.org>
In-Reply-To: <20101027210457.23673.qmail@kosh.dhis.org>
References: <20101027210457.23673.qmail@kosh.dhis.org>
Date: Thu, 28 Oct 2010 00:05:25 +0200 (CEST)
Subject: Re: Pegasos OHCI bug (was Re: PROBLEM: memory corrupting bug,
From: "Segher Boessenkool" <segher@kernel.crashing.org>
To: pacman@kosh.dhis.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: Olaf Hering <olaf@aepfle.de>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> > |1. How do I locate all usb nodes in the device tree?
>> > |
>> > |2. How do I know if a particular usb node is OHCI?

You look for compatible "usb-ohci".

But this doesn't help you.  You do not know yet if the
problem happens for all usb-ohci; for example, it could be
that you have the console output device on usb; or as another
example, it could be that this firmware leaves all pci devices
in some active state.

So as I see it you have only two options:

1) Figure out what exactly is going on;
or 2) make the kernel shut down all pci devices early (either
in actual kernel code, or in an OF boot script).

> The big question that I'm still stumbling over is how to access the device
> registers. The "reg" property looks like this:

You should look at "assigned-addresses", not "reg".  Well,
you first need to look at "reg" to figure out what entry
in "assigned-addresses" to use.


Segher
