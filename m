Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C296FDE5DB
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 08:47:12 +1000 (EST)
Subject: Re: [RFC/PATCH 1/3] powerpc: add ioremap_bat() function for
	setting up BAT translated IO regions.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <75A0A752-FF2C-41B6-A6D3-E510E8FD4E91@kernel.crashing.org>
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060223.30717.35175.stgit@trillian.secretlab.ca>
	<CD66FAA8-BC99-4630-9FFF-E2C651E5DE9A@kernel.crashing.org>
	<fa686aa40808061454t14737278h3fd15fb0ccdbf251@mail.gmail.com>
	<75A0A752-FF2C-41B6-A6D3-E510E8FD4E91@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 07 Aug 2008 08:28:29 +1000
Message-Id: <1218061709.24157.249.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, miltonm@bga.com
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> there is a bunch of error checking and difference in semantics that  
> you need to fix.  I think introduce a new API for this is silly,  
> especially since we expect there to only be one actual invocation of  
> the API for serial console access.

Not necessarily....

There's another aspect to BAT mappings here. First, they should be
permanent (ie, not unmappable). That way, we have ioremap just use
an existing BAT mapping when asked for a device that is covered
by a BAT. This allows to have platform code do something like setup
a BAT over a bunch of SOC registers or over a device, to automagically
get drivers doing ioremap to that area benefit from it.

Ben.
