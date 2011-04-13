Return-Path: <mike@it-loops.com>
Received: from lvps87-230-0-242.dedicated.hosteurope.de
	(lvps87-230-0-242.dedicated.hosteurope.de [87.230.0.242])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "plesk", Issuer "plesk" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 739A9B6EED
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Apr 2011 20:24:29 +1000 (EST)
Date: Wed, 13 Apr 2011 12:17:37 +0200
From: Michael Guntsche <mike@it-loops.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Powerpc compile error with 2.6.39-rc3 and non-SMP configs
Message-ID: <20110413101737.GA25514@gibson.comsick.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Commit b987812b3fc "powerpc/kexec: Fix mismatched ifdefs for PPC64/SMP."
breaks compilation on non SMP powerpc machines.
I wonder if this commit is really neccessary in the first place. The
function definition itself is already between an

#ifdef CONFIG_SMP (line 56)
#endif 

block so only exists if SMP=y and PPC_STD_MMU_64=y.
Furthermore the stub in your patch is only created if SMP=y and
PPC_STD_MMU_64=n which breaks non-SMP configs. 

Kind regards,
Michael Guntsche
