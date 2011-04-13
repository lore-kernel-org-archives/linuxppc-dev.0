Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 3EE2EB6F70
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Apr 2011 05:01:02 +1000 (EST)
Message-ID: <4DA5C531.1070508@windriver.com>
Date: Wed, 13 Apr 2011 11:45:53 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Michael Guntsche <mike@it-loops.com>
Subject: Re: Powerpc compile error with 2.6.39-rc3 and non-SMP configs
References: <20110413101737.GA25514@gibson.comsick.at>
In-Reply-To: <20110413101737.GA25514@gibson.comsick.at>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11-04-13 06:17 AM, Michael Guntsche wrote:
> Hi,
> 
> Commit b987812b3fc "powerpc/kexec: Fix mismatched ifdefs for PPC64/SMP."
> breaks compilation on non SMP powerpc machines.

Ah crap.  I compile tested on SMP, so didn't see that.

> I wonder if this commit is really neccessary in the first place. The
> function definition itself is already between an

Your analysis is right, but I think getting rid of the #ifdefs is
still the right approach where possible.  I'll send a fix shortly.

Thanks for the report.

P.

> 
> #ifdef CONFIG_SMP (line 56)
> #endif 
> 
> block so only exists if SMP=y and PPC_STD_MMU_64=y.
> Furthermore the stub in your patch is only created if SMP=y and
> PPC_STD_MMU_64=n which breaks non-SMP configs. 
> 
> Kind regards,
> Michael Guntsche
