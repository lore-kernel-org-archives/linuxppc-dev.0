Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9917FDE3B4
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 02:38:55 +1000 (EST)
Message-ID: <486BAEF4.9000904@freescale.com>
Date: Wed, 02 Jul 2008 11:38:12 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] mpc83xx: Power Management support
References: <20080625215051.GA11784@loki.buserror.net>
	<AEE09588-1480-450B-BEDF-237E2D59D3D0@kernel.crashing.org>
In-Reply-To: <AEE09588-1480-450B-BEDF-237E2D59D3D0@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> If we are going to allocate space for save area like this, can't we do 
> this in C code.  Its less error prone and easier to extend over time.  I 
> know the powermac code does something similar but it places the save 
> area on the stack.

Then we'd have to split it between things that can be saved from C 
versus things that can't (gpregs, cr, lr, etc), or mess around with 
exposing struct offsets to asm code.  I think it's just easier to do it 
this way.

-Scott
