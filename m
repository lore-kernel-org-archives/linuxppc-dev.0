Return-Path: <gerhard_pircher@gmx.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0EC20B727C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 18:30:31 +1000 (EST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id CBACEDDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 18:30:28 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 19 Jun 2009 10:30:24 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <C81AEED1-5CEC-42B8-A893-5E6BDDD4EC54@kernel.crashing.org>
Message-ID: <20090619083024.309900@gmx.net>
MIME-Version: 1.0
References: <C81AEED1-5CEC-42B8-A893-5E6BDDD4EC54@kernel.crashing.org>
Subject: Re: killing use of ppc_md.init
To: Kumar Gala <galak@krnel.crashing.org>, benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Thu, 18 Jun 2009 09:38:50 -0500
> Von: Kumar Gala <galak@kernel.crashing.org>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: linuxppc-dev list <linuxppc-dev@ozlabs.org>
> Betreff: killing use of ppc_md.init

> ppc_md.init only exists on ppc32 and seems like its pretty useless  
> today.  The users seem to fall into two classes:
> 
> 1. called to do of_platform_bus_probe() - most platforms use  
> machine_device_initcall() for this
> 2. some platform init code which seems like it could move into  
> setup_arch().
> 
> The second one seems to only be on amigaone and chrp.  Anyone know if  
> there is any harm in moving the amigaone_init() into  
> amigaone_setup_arch() and similarly on chrp chrp_init2() into  
> chrp_setup_arch().
I guess converting amigaone_init() to a machine_device_initcall() is the
easiest approach. I'll send a patch soon.

Gerhard

-- 
GMX FreeDSL Komplettanschluss mit DSL 6.000 Flatrate und Telefonanschluss
für nur 17,95 Euro/mtl.!* http://portal.gmx.net/de/go/dsl02
