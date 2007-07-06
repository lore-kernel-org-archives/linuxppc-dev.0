Return-Path: <SRS0+c1968525e2f9b8480a17+1412+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [209.217.80.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AEED3DDFBB
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jul 2007 00:41:28 +1000 (EST)
Subject: Re: Executing from readablee, no-exec pages
From: David Woodhouse <dwmw2@infradead.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <468D68D4.4050704@freescale.com>
References: <468D68D4.4050704@freescale.com>
Content-Type: text/plain
Date: Fri, 06 Jul 2007 10:42:01 -0400
Message-Id: <1183732922.2747.36.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-07-05 at 16:55 -0500, Scott Wood wrote:
> To maintain compatibility with these versions, we could change the test 
> in do_page_fault() to include VM_READ as well as VM_EXEC on targets that 
> don't have a separate exec-bit in hardware (are there any powerpc mmus 
> that do?).  

64-bit implementations since POWER4 have separate exec permissions,
don't they? So any userspace which tries to execute non-executable pages
is already broken when running on a ppc64 machine; I wouldn't worry too
much about letting it break on ppc32 too.

We already use vDSO signal trampolines even on the 32-bit kernel, right?

-- 
dwmw2
