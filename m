Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE010.bigfish.com (va3ehsobe010.messaging.microsoft.com
	[216.32.180.30]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 96116B702E
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Aug 2011 04:51:38 +1000 (EST)
Message-ID: <4E5699A8.1070708@freescale.com>
Date: Thu, 25 Aug 2011 13:51:20 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] tty/powerpc: fix build break with ehv_bytechan.c on
	allyesconfig
References: <1314289245-14946-1-git-send-email-timur@freescale.com>
	<20110825163234.GA31629@kroah.com> <4E568E19.405@freescale.com>
	<20110825184655.GB1891@kroah.com>
In-Reply-To: <20110825184655.GB1891@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: sfr@canb.auug.org.au, linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg KH wrote:
> But don't you really want this type of check at runtime?  What happens
> if you load this driver on a machine that is not a guest?  Will things
> break?  Shouldn't you still refuse to load somehow?

This is in the udbg code, which falls under the category of, "turn this on only
if you know what you're doing."

The udbg code runs very early, before the device tree is available.  There's no
way of knowing at this point whether or not we're running under a hypervisor.
If you turn on udbg support, then it means that you're trying to do some very
specific debugging on a specific platform.

So I'm not removing this code just to fix the build break.  It really should
never have been there in the first place.

-- 
Timur Tabi
Linux kernel developer at Freescale
