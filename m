Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DCB14DE0FE
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 07:36:53 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1MKajnU025605
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 15:36:45 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1MKaiRf207496
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 13:36:44 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1MKaiXU020710
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 13:36:44 -0700
Date: Fri, 22 Feb 2008 14:36:21 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] [POWERPC] AMCC Kilauea (405EX): Disable EMAC loopback mode
Message-ID: <20080222143621.0579729b@weaponx>
In-Reply-To: <1203669132-9385-1-git-send-email-sr@denx.de>
References: <1203669132-9385-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 22 Feb 2008 09:32:12 +0100
Stefan Roese <sr@denx.de> wrote:

> 405EX(r) has SDR0_MFR[E0CS/E1CS] set after reset. This selects
> the internal loopback mode. Clear these bits so that both EMACs
> don't use loopback mode as default.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> ---
> I'm not sure if this should be done here in the board platform code,
> or in the newemac driver or perhaps in some code common for 405EX.
> 
> Any thoughts on this welcome.

Why isn't this done in U-Boot?  Or is it done if the network interface
is used?  I know I've tftp'd a kernel onto my 405EXr board, so I'm
slightly confused why this is needed in the kernel.

Aside from that, I'm OK with it living in the platform code for Kilauea
(an Haleakala by inheritance).  Particularly given the fact that this
should be fixing in U-Boot for any further boards that use 405EX(r)...
right?

josh
