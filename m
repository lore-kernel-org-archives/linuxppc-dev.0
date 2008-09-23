Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 53D11DDED3
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Sep 2008 14:55:53 +1000 (EST)
Subject: RE: Regarding select() on PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>
In-Reply-To: <7B7EF7F090B9804A830ACC82F2CDE95D56E135@insardxms01.ap.sony.com>
References: <7B7EF7F090B9804A830ACC82F2CDE95D56E135@insardxms01.ap.sony.com>
Content-Type: text/plain
Date: Tue, 23 Sep 2008 14:55:41 +1000
Message-Id: <1222145741.12085.88.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2008-09-23 at 10:20 +0530, Sadashiiv, Halesh wrote:
> Hi,
> 
> The below testcase requires to exit with setting errno as EINVAL, as per
> the man page.
> 
> I tested this on ARM, I686, PPC64 it was fine, for the same on PPC32 it
> used exit with errno set as EFAULT.
> 
> On further investigation found there was some long obsolete code in
> arch/powerpc/kernel/syscalls.c (function ppc_select()), which was
> written in 2.2.0 kernel for PPC32 specific , which resulted in EFAULT.
> 
> This needs to be verified, I have proposed patch for PPC32, Please check
> the link
> http://article.gmane.org/gmane.linux.kernel/735922
> 

I'm trying to sort out how obsolete it actually is and see if we can
remove the whole thing.

Your patch should be submitted to the linuxppc-dev mailing list btw.

Ben.
