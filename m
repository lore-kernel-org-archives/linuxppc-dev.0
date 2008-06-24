Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B7AE0DE093
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 23:26:17 +1000 (EST)
Message-ID: <4860F5E8.1060609@freescale.com>
Date: Tue, 24 Jun 2008 08:26:00 -0500
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 02/14] powerpc: Allow create_branch() to return errors
References: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
	<bda40d2750deae8e742dc9d115a6aab4843701ee.1214271072.git.michael@ellerman.id.au>
In-Reply-To: <bda40d2750deae8e742dc9d115a6aab4843701ee.1214271072.git.michael@ellerman.id.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> Currently create_branch() creates a branch instruction for you, and patches
> it into the call site. In some circumstances it would be nice to be able to
> create the instruction and patch it later, and also some code might want
> to check for errors in the branch creation before doing the patching. A
> future patch will change create_branch() to check for errors.
> 
> For callers that don't care, replace create_branch() with patch_branch(),
> which just creates the branch and patches it directly.
> 
> While we're touching all the callers, change to using unsigned int *, as
> this seems to match usage better. That allows (and requires) us to remove
> the volatile in the definition of vector in powermac/smp.c and mpc86xx_smp.c,
> that's correct because now that we're passing vector as an unsigned int *
> the compiler knows that it's value might change across the patch_branch()
> call.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---

86xx bits...

Acked-by: Jon Loeliger <jdl@freescale.com>
