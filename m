Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C3C5D67BB9
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 17:25:50 +1000 (EST)
Subject: Re: [PATCH 2/2] uninorth: Add module param 'aperture' for aperture
	size
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
In-Reply-To: <1156176559.16513.78.camel@thor.lorrainebruecke.local>
References: <115608447678-git-send-email->  <11560844762890-git-send-email->
	<1156176559.16513.78.camel@thor.lorrainebruecke.local>
Content-Type: text/plain; charset=utf-8
Date: Tue, 22 Aug 2006 17:25:36 +1000
Message-Id: <1156231536.21752.100.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-08-21 at 18:09 +0200, Michel Dänzer wrote:

> In contrast to most if not all PC BIOSes, OpenFirmware (OF) on PowerMacs with
> UniNorth bridges does not allow changing the aperture size. The size set up by
> OF is usually 16 MB, which is too low for graphics intensive environments.
> Hence, add a module parameter that allows changing the aperture size at driver
> initialization time. When the parameter is not specified, the default is still
> to leave the size unchanged, usually as set up by OF.

The right fix is to allow changing it by the driver ... can't we do it
such that AGPSize will work & change it ? The firmware doesn't actually
configure it at all I suspect... those 16M are basically 
what the HW comes up with as a default setting (unless the firmware runs
some diagnostics and sets it as a result of these). It's basically
expected that we set it ourselves and a module option doesn't seem like
a terribly good idea to me...

Maybe we should just have the driver default to something more sensible
in addition to what AGPSize comes from userland ? like 64M ?

Ben.
