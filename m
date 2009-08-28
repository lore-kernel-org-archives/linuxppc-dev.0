Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 56B52B7B66
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 29 Aug 2009 08:34:08 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A6158DDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Aug 2009 08:34:07 +1000 (EST)
Subject: Re: [RFC] Clock binding
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rafal Jaworowski <raj@semihalf.com>
In-Reply-To: <B7829AEE-B751-403D-9A16-CFE1A4E0FAB0@semihalf.com>
References: <1250569288.19007.15.camel@pasglop>
	<1251346157.20467.22.camel@pasglop> <4A96F69A.5050003@firmworks.com>
	<1251411532.20467.74.camel@pasglop> <4A970C85.8090703@firmworks.com>
	<1251420686.20467.96.camel@pasglop> <4A974295.9020504@firmworks.com>
	<1251427388.20467.122.camel@pasglop>
	<955e48b80908280516m457530cfn3b07b52f2fa2c471@mail.gmail.com>
	<fa686aa40908280906w7953017ek44ee498d57e0a642@mail.gmail.com>
	<B7829AEE-B751-403D-9A16-CFE1A4E0FAB0@semihalf.com>
Content-Type: text/plain
Date: Sat, 29 Aug 2009 08:33:52 +1000
Message-Id: <1251498832.20467.184.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss@lists.ozlabs.org, Stuart Yoder <stuyoder@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-08-28 at 20:24 +0200, Rafal Jaworowski wrote:
> Grant,
> When choosing the best location for the bindings page please consider  
> it uniform enough so that various OSes can use it as a reference. We  
> are very much interested in bringing FDT support for embedded FreeBSD  
> (arm, powerpc), and one of the uncertainties is how to deal with  
> existing Linux bindings definitions: at the moment they are maintained  
> as part of kernel source tree, and there are doubts whether we should  
> come up with our own set (most likely *very* similar), which we'd like  
> to avoid.

I agree. We need to be OS neutral.

In fact, one of the main issue right now with the core binding is the
phandles, which are put into "linux,phandle" properties. That must
change and we need to make the kernel aware of the change.

We will still keep linux-specific properties around, I suppose, mostly
for linux-specific things exchanged between the boot wrapper and the
kernel, but the base tree should generally be devoid of a "linux,"
property.

Cheers,
Ben.
