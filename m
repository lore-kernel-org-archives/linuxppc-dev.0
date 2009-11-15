Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-6.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1B87DB6F2B
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Nov 2009 17:49:51 +1100 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 04/10] 8xx: Always pin kernel instruction TLB
References: <1258195348-2861-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258195348-2861-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258195348-2861-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258195348-2861-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258195348-2861-5-git-send-email-Joakim.Tjernlund@transmode.se>
	<8F89F37D-4EC1-4B1B-AA89-5BFF5707E5F8@embeddedalley.com>
	<OF76EB2F89.E66EDF7B-ONC125766E.00687237-C125766E.006921DF@transmode.se>
	<1258234866.2140.451.camel@pasglop>
Date: Sat, 14 Nov 2009 22:49:47 -0800
In-Reply-To: <1258234866.2140.451.camel@pasglop> (Benjamin Herrenschmidt's
	message of "Sun, 15 Nov 2009 08:41:06 +1100")
Message-ID: <adalji8cmes.fsf@roland-alpha.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


 > > How to make better use of the remaining ITLB slots is tricky.
 > > Somehow one would want to map at lest one to modules but I cannot see how.
 > 
 > No. If you use modules, you pay the price. Sane embedded solutions
 > running in "tight" environments don't use modules :-) No point pinning
 > TLB entries on the vmalloc space, really.

Long ago (2.4 days I think) when using modules on ppc 4xx we hacked the
module_alloc function (or whatever it was called back then) to allocate
space in the kernel pinned TLB instead of using vmalloc.  Gave something
like a 2x speedup for module code, since the 4xx TLB is so small and the
miss handling is so expensive.  I assume it should still be possible to
do a similar hack with current kernels.

 - R.
