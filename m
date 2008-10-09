Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18669.28217.664373.869832@cargo.ozlabs.ibm.com>
Date: Thu, 9 Oct 2008 13:36:41 +1100
From: Paul Mackerras <paulus@samba.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: performance: memcpy vs. __copy_tofrom_user
In-Reply-To: <48ECF08F.7000400@freescale.com>
References: <48ECC611.3030309@mikroswiat.pl> <48ECF08F.7000400@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Dominik Bozek <domino@mikroswiat.pl>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood writes:

> I'm not sure why we don't use dcbt in memcpy(), as it's just ignored if 
> the memory is cache-inhibited.

Both dcbt and dcbz tend to slow things down if the relevant block is
already in the cache.  Since the kernel memcpy is mostly used for
copies that are only 1 or a small number of cache lines long, it's not
clear that the benefit of dcbt and/or dcbz would outweigh the cost.
And anyway, I have yet to be convinced that optimizing memcpy would
provide a measureable benefit.

Paul.
