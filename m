Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8A86CB6F05
	for <linuxppc-dev@ozlabs.org>; Wed,  4 May 2011 14:31:11 +1000 (EST)
Subject: Re: [PATCH 0/2] powerpc/pseries: Reworked support for IO event
	interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1304483324-11155-1-git-send-email-benh@kernel.crashing.org>
References: <1304483324-11155-1-git-send-email-benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 04 May 2011 14:31:05 +1000
Message-ID: <1304483465.2513.338.camel@pasglop>
Mime-Version: 1.0
Cc: tsenglin@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-05-04 at 14:28 +1000, Benjamin Herrenschmidt wrote:
> Hi Frank !
> 
> There were several issues with your patch. Some were nasty bugs such
> as kmalloc(...GFP_KERNEL) at interrupt time, or taking the rtas buffer
> lock from an interrupt, others simply the code being ugly.
> 
> I've removed the "generic" event log parsing as it's not useful at
> this point and simplified the code significantly.
> 
> Please test and let me know if it works for you before I commit.

FYI. This isn't even compile tested (oops... my bad). It shows you want
I want, feel free to tweak a bit if needed and hopefully we should have
something mergeable.

Also, get rid of your habit of naming pointers something_p, I find it
annoying and waste time removing the _p's

Cheers,
Ben.
