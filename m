Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 7BFF7DDF12
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 16:01:22 +1000 (EST)
Date: Mon, 18 Jun 2007 22:58:14 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch 30/33] PS3: Bootwrapper support.
Message-ID: <20070619055814.GA18392@mag.az.mvista.com>
References: <46730D8A.9090309@am.sony.com>
	<951969d2021fe6e78917ef8bdb47cf6f@bga.com>
	<20070618225537.GA19966@mag.az.mvista.com>
	<46771CE7.8040901@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46771CE7.8040901@am.sony.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 18, 2007 at 05:01:43PM -0700, Geoff Levand wrote:
> Mark A. Greer wrote:

> > As for the rest of Geoff's patch, I think I get the gist of what's going
> > on but it would be really nice to have it described in English (and put
> > in the patch description).  That way others (like me) could understand
> > the problem you're solving and what your solution is.
> 
> This is from the comment the patch adds to the wrapper script.  I think
> it gives you what you need:
> 
> +ps3)
> +    # The ps3's loader supports loading gzipped binary images from flash
> +    # rom to addr zero. The loader enters the image at addr 0x100.  A
> +    # bootwrapper overlay is use to arrange for the kernel to be loaded
> +    # to addr zero and to have a suitable bootwrapper entry at 0x100.
> +    # To construct the rom image, 0x100 bytes from offset 0x100 in the
> +    # kernel is copied to the bootwrapper symbol __system_reset_kernel.
> +    # The 0x100 bytes at the bootwrapper symbol __system_reset_overlay is
> +    # then copied to offset 0x100.  At runtime the bootwrapper program
> +    # copies the 0x100 bytes at __system_reset_kernel to addr 0x100.

Yes, that was what I needed.  I should have found that myself...my apologies.

Mark
