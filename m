Return-Path: <michel@tungstengraphics.com>
Received: from admin.zirkelwireless.com (admin.zirkelwireless.com
	[209.216.203.65])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 41CCF67BDF
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 18:56:04 +1000 (EST)
Subject: Re: [PATCH 2/2] uninorth: Add module param 'aperture' for aperture
	size
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1156231536.21752.100.camel@localhost.localdomain>
References: <115608447678-git-send-email->  <11560844762890-git-send-email->
	<1156176559.16513.78.camel@thor.lorrainebruecke.local>
	<1156231536.21752.100.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Aug 2006 10:55:54 +0200
Message-Id: <1156236954.16513.141.camel@thor.lorrainebruecke.local>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, davej@codemonkey.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-08-22 at 17:25 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2006-08-21 at 18:09 +0200, Michel Dänzer wrote:
> 
> > In contrast to most if not all PC BIOSes, OpenFirmware (OF) on PowerMacs with
> > UniNorth bridges does not allow changing the aperture size. The size set up by
> > OF is usually 16 MB, which is too low for graphics intensive environments.
> > Hence, add a module parameter that allows changing the aperture size at driver
> > initialization time. When the parameter is not specified, the default is still
> > to leave the size unchanged, usually as set up by OF.
> 
> The right fix is to allow changing it by the driver ... can't we do it
> such that AGPSize will work & change it ? 

Not sure, but it seems like the aperture size is fixed at backend
initialization time, i.e. in the driver's probe hook.


> It's basically expected that we set it ourselves and a module option 
> doesn't seem like a terribly good idea to me...

Well, wasn't it you who suggested this? :)


> Maybe we should just have the driver default to something more sensible
> in addition to what AGPSize comes from userland ? like 64M ?

Might be a good idea.


-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer
