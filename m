Return-Path: <torvalds@linux-foundation.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.24])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2B97BDDEC2
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 11:24:37 +1100 (EST)
Date: Sun, 25 Feb 2007 16:24:41 -0800 (PST)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Make sure we populate the initroot filesystem late enough
In-Reply-To: <1172448057.3971.9.camel@shinybook.infradead.org>
Message-ID: <Pine.LNX.4.64.0702251614420.12485@woody.linux-foundation.org>
References: <200612112059.kBBKx1j7022473@hera.kernel.org>
	<1172448057.3971.9.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	john stultz <johnstul@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Sun, 25 Feb 2007, David Woodhouse wrote:
> 
> One side-effect of this patch is to move the call to free_initrd() much
> later in the init sequence, potentially after other memory management
> code is assuming it's already been freed.

Hmm. No, I don't think that should be a problem. free_initmem() only 
happens at the very, after do_basic_setup() has been run, which includes 
all the initcall stuff.

However, it's an interesting observation. How sure are you that it's this 
commit that triggers it. You say "This seems to be what's triggering ..", 
I'm wondering how firm that is..

		Linus
