Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 1D6D7DDE03
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jan 2008 08:23:21 +1100 (EST)
Date: Tue, 1 Jan 2008 15:31:35 -0600
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] [POWERPC] smp_call_function_map should be static
Message-ID: <20080101213135.GA1474@lixom.net>
References: <20071228040836.GA23635@lixom.net>
	<1199219313.6751.0.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1199219313.6751.0.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 02, 2008 at 07:28:33AM +1100, Benjamin Herrenschmidt wrote:
> 
> On Thu, 2007-12-27 at 22:08 -0600, Olof Johansson wrote:
> > smp_call_function_map should be static, and for consistency prepend it
> > with __ like other local helper functions in the same file.
> > 
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> NAK. I want it exported to other arch code, I'll need it in some stuff
> that I haven't released yet, like some BookE SMP stuff.

With the locking changes in 2/2, it will need a new exported function
that does the locking around the call to __*. With that, it'd be easier
to just merge this.

I.e. __smp_call_function_map() will be the internal (lockless) version,
and you'll end up adding a nonstatic smp_call_function_map() that does
locking and calls the __* one.

Is that OK with you?


-Olof
