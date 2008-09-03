Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DBD50DDE2A
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 07:23:15 +1000 (EST)
Date: Wed, 3 Sep 2008 14:22:36 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] Correct printk %pF to work on all architectures
In-Reply-To: <1220473137.3254.29.camel@localhost.localdomain>
Message-ID: <alpine.LFD.1.10.0809031419560.3515@nehalem.linux-foundation.org>
References: <1220473137.3254.29.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-ia64@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Wed, 3 Sep 2008, James Bottomley wrote:
> 
> Make dereference_function_descriptor() more accommodating by allowing
> architecture overrides.

Don't do it like this.

We don't want some stupid useless weak function that is empty on all sane 
platforms.

Just do

	.. declare or create an inline 'parisc_function_descriptor()' ..

	#define dereference_function_descriptor(p) parisc_function_descriptor(p)

in some arch header file. And then use

	#ifndef dereference_function_descriptor
	#define dereference_function_descriptor(p) (p)
	#endif

in the generic code, so that sane architectures don't need to do anything 
at all.

		Linus
