Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE009.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6DD37B6F6F
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Aug 2011 04:02:08 +1000 (EST)
Message-ID: <4E568E19.405@freescale.com>
Date: Thu, 25 Aug 2011 13:02:01 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] tty/powerpc: fix build break with ehv_bytechan.c on
	allyesconfig
References: <1314289245-14946-1-git-send-email-timur@freescale.com>
	<20110825163234.GA31629@kroah.com>
In-Reply-To: <20110825163234.GA31629@kroah.com>
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
> tested doesn't mean that it shouldn't still build properly for other
> platforms, right?

The problem is the dependency on MSR_GS, which is defined only for Book-E
PowerPC chips, not all PowerPC.

So I gave it some more thought, and technically ePAPR extends beyond Book-E, so
it's wrong for the driver to depend on anything specific to Book-E.  I've
removed the code that breaks:

	/* Check if we're running as a guest of a hypervisor */
	if (!(mfmsr() & MSR_GS))
		return;

> What is keeping the driver from building on all PPC, or even all arches
> today?

I've made a few changes, and it builds on all PPC now.  I'll post a new patch.

-- 
Timur Tabi
Linux kernel developer at Freescale
