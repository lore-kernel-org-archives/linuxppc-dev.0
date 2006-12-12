Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A7EE167BE8
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 13:31:55 +1100 (EST)
In-Reply-To: <1165890570.11914.5.camel@localhost.localdomain>
References: <20061208190758.6cee088f.kim.phillips@freescale.com>
	<1165648490.1103.117.camel@localhost.localdomain>
	<91EF8E0D-06BC-47FD-89E6-6350430946F9@kernel.crashing.org>
	<20061211155155.26868ca6.kim.phillips@freescale.com>
	<A1A95A77-B86C-41CF-87DC-58CD63843CE3@kernel.crashing.org>
	<20061211201055.21031c9b.kim.phillips@freescale.com>
	<1165890570.11914.5.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F03217B3-E190-418C-9B13-2B47BD6E088D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
Date: Mon, 11 Dec 2006 20:31:48 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 11, 2006, at 8:29 PM, Benjamin Herrenschmidt wrote:

>
>> how else is platform_probe going to find the right match?
>> it's either that, or adding _probe()s for each platform.
>
> Well, either you want all freescale boards have one platform.
> in which case you write one ppc_md() structure, call it
> mpc83xx_fslboards or something like that, and have a probe routine  
> that
> test for all matches, or create as many ppc_md structures as you have
> boards each with it's own probe().
>
> The point here is that other developpers making their own mpc83xx  
> based
> boards will not want to use your ppc_md. They will have differences  
> and
> those differences will be handled in their board support code via
> different hooks in ppc_md.
>
> It's goot if you provide them "generic" things they can use in  
> mpc83xx.c
> for areas where they don't differ from the freescale reference
> implementations, but don't make the fsl board support code try to  
> match
> on everything that has a mpc83xx in it !
>
> Thus, make sure that your DTs for the fsl boards have clear
> identification (via the model or compatible property at the root of  
> the
> tree is the usual way of doing so) and have a ppc_md or several, as  
> you
> like, match specifically those boards. Also, make that ppc_md live  
> in a
> different file that doesn't have to be compiled along with the generic
> mpc83xx code.
>
> That way, embedded developpers have the choice of either building a
> multiplatform kernel that supports their board -and- fsl ones, or a
> tailored kernel for their board that doesn't include the fsl specific
> stuff, all depending on config options.

Thank you Ben, you described this far better than I was.

- k
