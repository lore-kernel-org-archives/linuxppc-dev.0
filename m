Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 95F541007D7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Dec 2011 09:09:52 +1100 (EST)
Message-ID: <1324073384.4875.7.camel@pasglop>
Subject: Re: [PATCH v2] powerpc/setup_{32, 64}.c: remove unneeded
 boot_cpuid{, _phys}
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Sat, 17 Dec 2011 09:09:44 +1100
In-Reply-To: <4EEBB84C.2050001@freescale.com>
References: <1322192477.32635.15.camel@pasglop>
 <1322540669-6834-1-git-send-email-msm@freescale.com>
 <1324005174.4875.0.camel@pasglop>
 <CAEsOVNcZPH_MJUdy0q7AjwomHTZhg2DoHSV+y9xatq-2SohC2A@mail.gmail.com>
 <1324006543.4875.1.camel@pasglop> <4EEBB84C.2050001@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: McClintock Matthew-B29882 <B29882@freescale.com>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-12-16 at 15:29 -0600, Scott Wood wrote:
> It would be nice if we could eliminate all usage of the boot cpu dtb
> field -- it's easy to forget to set it, especially if you're not making
> an AMP config.  The default -1 means this patch would break booting with
> such a tree.
> 
> If we don't want to record the PIR of the first CPU to enter as the boot
> CPU (is the concern implementations where the CPU node's reg is not the
> same as what's in PIR?), how about just having a variable that gets set
> before releasing secondaries?  If you're in the boot entry code and that
> variable is set, you're a secondary.  Or, use a distinct release address
> for secondaries rather than __early_start.

Of course you can only do that on processors that have a reliable
PIR :-)

Cheers,
Ben.
