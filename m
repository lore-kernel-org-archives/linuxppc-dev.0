Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 84EEADDE45
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Mar 2008 09:25:56 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m22MPq2U023037
	for <linuxppc-dev@ozlabs.org>; Sun, 2 Mar 2008 17:25:52 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m22MPpHc191862
	for <linuxppc-dev@ozlabs.org>; Sun, 2 Mar 2008 15:25:51 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m22MPp62018803
	for <linuxppc-dev@ozlabs.org>; Sun, 2 Mar 2008 15:25:51 -0700
Date: Sun, 2 Mar 2008 16:23:31 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH 3/2][NEWEMAC] Use status property for unused/unwired EMACs
Message-ID: <20080302162331.46d5d960@zod.rchland.ibm.com>
In-Reply-To: <47CB0363.6000705@pikatech.com>
References: <20080301081600.74598ce4@zod.rchland.ibm.com>
	<20080301084140.7abc703e@zod.rchland.ibm.com>
	<47CB0363.6000705@pikatech.com>
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

On Sun, 02 Mar 2008 14:43:31 -0500
Sean MacLennan <smaclennan@pikatech.com> wrote:

> Josh Boyer wrote:
> > Convert ibm_newemac to use the of_device_is_available function when checking
> > for unused/unwired EMACs.  We leave the current check for an "unused" property
> > to maintain backwards compatibility for older device trees.  Newer device
> > trees should simply use the standard "status" property in the EMAC node.
> >
> > The taishan DTS file is updated to reflect this.
> >   
> What is the advantage of documenting unwired devices? I ask because the 
> taco does not have emac1 connected. I handle it by not defining emac1 in 
> the dts file.

If it never has the possibility of becoming usable without some kind
of hardware rework, then that's probably best.

> Is it better to document it and disable it? Or is this mainly for 
> reference boards to show that while the PPC supports to emacs, only one 
> is enabled on the reference board?
> 
> i.e. We want reference design boards to show what *could* be done, but 
> production boards to show what *is* done?

Sort of.  A lot of these eval boards have DIP switches that change pins
to various devices.  So for those, we enumerate most things and we can
adjust the status property based on those settings in the
firmware/wrapper.

josh
