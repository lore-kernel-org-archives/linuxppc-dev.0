Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 9CCE6DDDF4
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 15:23:40 +1100 (EST)
Date: Sun, 18 Nov 2007 22:25:19 -0600
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2] [POWERPC] vdso: Fixes for cache block sizes
Message-ID: <20071119042519.GA28872@lixom.net>
References: <20071114192405.GA1637@lixom.net>
	<1195072102.28865.41.camel@pasglop>
	<20071114212823.GA3044@lixom.net>
	<18241.3066.346441.180033@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18241.3066.346441.180033@cargo.ozlabs.ibm.com>
Cc: dwmw2@infradead.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 19, 2007 at 03:07:22PM +1100, Paul Mackerras wrote:
> Olof Johansson writes:
> 
> > [POWERPC] vdso: Fixes for cache line sizes
> > 
> > Current VDSO implementation is hardcoded to 128 byte cache blocks,
> > which are only used on IBM's 64-bit processors.
> > 
> > Convert it to get the  blocks sizes out of vdso_data instead, similar
> > to how the ppc64 in-kernel cache flush does it.
> 
> OK, but you have removed a "crclr cr0*4+so" instruction in a couple of
> places.  They are there so that the functions follow the convention
> for system calls, where cr0.SO set on return indicates an error, and
> clear indicates no error.  Was there any special reason why you
> removed them?  If not, please put them back (after the last cmp or
> dot-form instruction).

Good catch. They must have fallen off when I copied over the in-kernel
versions. I'll repost tomorrow.


Thanks,

-Olof
