Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0138.outbound.protection.outlook.com [207.46.100.138])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 479A81A012C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Nov 2014 11:23:05 +1100 (AEDT)
Message-ID: <1415406169.3805.48.camel@snotra.buserror.net>
Subject: Re: powerpc/8xx: Remove Kconfig symbol FADS
From: Scott Wood <scottwood@freescale.com>
To: Paul Bolle <pebolle@tiscali.nl>
Date: Fri, 7 Nov 2014 18:22:49 -0600
In-Reply-To: <1415350123.4390.43.camel@x220>
References: <1411545979.19525.5.camel@x220>
 <20141107035008.GA25204@home.buserror.net> <1415350123.4390.43.camel@x220>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
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

On Fri, 2014-11-07 at 09:48 +0100, Paul Bolle wrote:
> On Thu, 2014-11-06 at 21:50 -0600, Scott Wood wrote:
> > On Wed, Sep 24, 2014 at 10:06:19AM +0200, Paul Bolle wrote: 
> > > Another cleanup might be to remove MPC8XXFADS (or "FADS") from the "8xx
> > > Machine Type" choice. Is there any reason left to pick "FADS" as a
> > > machine type?
> > 
> > Nothing references MPC8XXFADS, so yes, it can be removed.
> 
> I'll try to look into this. For the (verbose) reasons below I'll do that
> in a separate patch, if I ever get that far. What follows is mostly a
> note to self.

Yes, make it a separate patch -- I've already got this patch queued up.

> MPC8XXFADS is indeed not referenced anywhere. But it's one of the
> entries in the "8xx Machine Type" choice. And it's common for choice
> blocks the have a "none of the above" entry. Ie, an entry that allows to
> configure nothing. There's a chance MPC8XXFADS is currently used for
> that role. (This is easier to determine for people that - unlike me -
> know what all the symbols in this choice mean. To me they 're basically
> random strings.)

It's not a "none of the above" option.  It's a board type that was
supported in arch/ppc, and only some remnants made it over to
arch/powerpc.  If you don't pick a machine type that results in a
define_machine() struct (with a probe function that matches the device
tree), the kernel will not boot.

-Scott
