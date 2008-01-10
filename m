Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 30D59DE04D
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 05:25:10 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0AIP7EU010352
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 13:25:07 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0AIOwo5086790
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 11:25:00 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0AIOwQP006185
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 11:24:58 -0700
Date: Thu, 10 Jan 2008 12:24:27 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: ibm4xx_quiesce_eth?
Message-ID: <20080110122427.59102355@zod.rchland.ibm.com>
In-Reply-To: <47866614.3010203@pikatech.com>
References: <47866614.3010203@pikatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: 'linuxppc-dev' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 10 Jan 2008 13:38:12 -0500
Sean MacLennan <smaclennan@pikatech.com> wrote:

> What exactly does this function do?
> 
>     /* Quiesce the MAL and EMAC(s) since PIBS/OpenBIOS don't
>      * do this for us
>      */
> 
> On the taco, with the 440EP, it doesn't seem to make any difference if I 
> call this or not. Since I am using u-boot, is it not needed?

There are firmwares that do not reset the EMAC and MAL before passing
control to the client program (Linux in our case).  This can cause
weird things to happen, like spurious interrupts or DMAs from the
hardware overwriting kernel memory.  So we quiesce the hardware really
early on those.

I don't believe U-Boot has that problem.  If it does, it should be
fixed :)

josh
