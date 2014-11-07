Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews07.kpnxchange.com (cpsmtpb-ews07.kpnxchange.com
 [213.75.39.10])
 by lists.ozlabs.org (Postfix) with ESMTP id 8D1051A006B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Nov 2014 19:48:49 +1100 (AEDT)
Message-ID: <1415350123.4390.43.camel@x220>
Subject: Re: powerpc/8xx: Remove Kconfig symbol FADS
From: Paul Bolle <pebolle@tiscali.nl>
To: Scott Wood <scottwood@freescale.com>
Date: Fri, 07 Nov 2014 09:48:43 +0100
In-Reply-To: <20141107035008.GA25204@home.buserror.net>
References: <1411545979.19525.5.camel@x220>
 <20141107035008.GA25204@home.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-11-06 at 21:50 -0600, Scott Wood wrote:
> On Wed, Sep 24, 2014 at 10:06:19AM +0200, Paul Bolle wrote: 
> > Another cleanup might be to remove MPC8XXFADS (or "FADS") from the "8xx
> > Machine Type" choice. Is there any reason left to pick "FADS" as a
> > machine type?
> 
> Nothing references MPC8XXFADS, so yes, it can be removed.

I'll try to look into this. For the (verbose) reasons below I'll do that
in a separate patch, if I ever get that far. What follows is mostly a
note to self.

MPC8XXFADS is indeed not referenced anywhere. But it's one of the
entries in the "8xx Machine Type" choice. And it's common for choice
blocks the have a "none of the above" entry. Ie, an entry that allows to
configure nothing. There's a chance MPC8XXFADS is currently used for
that role. (This is easier to determine for people that - unlike me -
know what all the symbols in this choice mean. To me they 're basically
random strings.)

Actually, there's an obscure "optional" Kconfig keyword that appears to
be added to take care of this use case. It's currently used exactly
twice in the tree, in smaller architectures: once in arch/avr32/ and
once in arch/sh/. This implies this "optional" keyword is used very
little. I'll have to look carefully to see whether it works as
advertised.


Paul Bolle
