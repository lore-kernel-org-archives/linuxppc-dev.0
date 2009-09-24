Return-Path: <RFeany@mrv.com>
Received: from bos-spam.mrv.com (mx5.mrv.com [140.179.254.12])
	by ozlabs.org (Postfix) with ESMTP id B522BB7088
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 12:38:44 +1000 (EST)
Date: Wed, 23 Sep 2009 19:38:40 -0700
From: Rex Feany <RFeany@mrv.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm: Fix 40x and 8xx vs. _PAGE_SPECIAL
Message-ID: <20090924023840.GA16381@compile2.chatsunix.int.mrv.com>
References: <1253679146.7103.270.camel@pasglop>
	<20090924005300.GB11737@compile2.chatsunix.int.mrv.com>
	<1253756434.7103.377.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1253756434.7103.377.camel@pasglop>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, "Weirich,
	Bernhard" <Bernhard.Weirich@riedel.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thus spake Benjamin Herrenschmidt (benh@kernel.crashing.org):

> Hrm. This is really strange...

Is this a problem? in pte-8xx.h you added:

+#define _PAGE_SPECIAL  0x0008  /* SW entry, forced to 0 by the TLB miss */

but there is already this:

#define _PAGE_EXEC      0x0008  /* software: i-cache coherency required */

take care!
/rex.
