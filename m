Return-Path: <gregkh@linuxfoundation.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdtvr5GplzDvwx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 22:02:48 +1100 (AEDT)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tdtvr18msz9t3K
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Dec 2016 22:02:48 +1100 (AEDT)
Date: Wed, 14 Dec 2016 03:02:56 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Joel Stanley <joel@jms.id.au>
Cc: Michael Ellerman <patch-notifications@ellerman.id.au>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 linuxppc-dev@ozlabs.org, markus@trippelsdorf.de, amodra@gmail.com
Subject: Re: powerpc: cmp -> cmpd for 64-bit
Message-ID: <20161214110256.GB5664@kroah.com>
References: <551528846e6a2783184ba8a4228348a2fc9786bd.1475761214.git.segher@kernel.crashing.org>
 <3t3mJS0hfYz9sxS@ozlabs.org>
 <CACPK8Xf3X=bEj-EUXezYYEKNJwkqW4O0RiM2FcCtH4cNNxA-qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACPK8Xf3X=bEj-EUXezYYEKNJwkqW4O0RiM2FcCtH4cNNxA-qw@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 14, 2016 at 02:01:50PM +1030, Joel Stanley wrote:
> On Wed, Oct 26, 2016 at 8:51 PM, Michael Ellerman
> <patch-notifications@ellerman.id.au> wrote:
> > On Thu, 2016-06-10 at 13:42:19 UTC, Segher Boessenkool wrote:
> >> PowerPC's "cmp" instruction has four operands.  Normally people write
> >> "cmpw" or "cmpd" for the second cmp operand 0 or 1.  But, frequently
> >> people forget, and write "cmp" with just three operands.
> >>
> >> With older binutils this is silently accepted as if this was "cmpw",
> >> while often "cmpd" is wanted.  With newer binutils GAS will complain
> >> about this for 64-bit code.  For 32-bit code it still silently assumes
> >> "cmpw" is what is meant.
> >>
> >> Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
> >
> > Applied to powerpc fixes, thanks.
> >
> > I added:
> >   Fixes: 948cf67c4726 ("powerpc: Add NAP mode support on Power7 in HV mode")
> >   Cc: stable@vger.kernel.org # v3.0
> >
> > https://git.kernel.org/powerpc/c/80f23935cadb1c654e81951f5a8b7c
> 
> This one made it into 4.9-rc3 as "powerpc: Convert cmp to cmpd in idle
> enter sequence". We need it to build the 4.4 kernel with GCC 6.2, so
> my OpenPower firmware builds are failing.
> 
> The patch won't backport directly as in 4.4 the macro is in
> arch/powerpc/kernel/idle_power7.S.
> 
> Greg, is this one in your queue? Do we need to send a patch to stable
> that backports cleanly?

I need a clean backport, that is why it never showed up in 4.4-stable.

thanks,

greg k-h
