Return-Path: <zippel@linux-m68k.org>
Received: from smtp-vbr3.xs4all.nl (smtp-vbr3.xs4all.nl [194.109.24.23])
	by ozlabs.org (Postfix) with ESMTP id CE0E5DE02F
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 00:52:49 +1000 (EST)
Date: Thu, 10 Jul 2008 16:52:25 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: linux-next: kbuild tree build failure
In-Reply-To: <20080708211930.GA16897@uranus.ravnborg.org>
Message-ID: <Pine.LNX.4.64.0807101623100.6791@localhost.localdomain>
References: <20080707184038.aaeb8d40.sfr@canb.auug.org.au>
	<Pine.LNX.4.64.0807071424240.6791@localhost.localdomain>
	<20080708211930.GA16897@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Tue, 8 Jul 2008, Sam Ravnborg wrote:

> We use Kconfig for a mixture of user editable values and fixed
> configuration values.
> And I agree that asking the user to input a 64 bit number is not usefull.
> 
> But keeping support for 64 bit values is what I would consider
> expected functionality.

Isn't that a bit of a stretch? That's a rather generic argument, do we 
really have to keep everything, because someone _might_ want to use it?
I'd rather look at how useful it really is to keep that functionality and 
so far we exactly one user, which doesn't strictly require it.
So far it's more a convenience feature rather than a required feature. We 
don't lose any functionality, it's just shifted from kconfig to the header 
file.

> > This would also ease on any portability issues 
> > (kconfig is compiled with the host compiler not the target compiler).
> 
> We use strtol() in a few places in symbol.c already where we do an
> implicit conversion to int. Why did this not cause us problems before?
> 
> Is it because these code paths are only triggered when we deal with ranges?
> If so we could 'fix' strdup_type() to not use strto{,u}l() so it
> is 64 bit clean and we are back to old behaviour.

Ranges are the primary reason I made it consistent with this.
If we really wanted to support 64bit numbers, it would create only more 
problems. First you have to make sure that on every build host (i.e also 
non-Linux) strtoll() is available. Then how it should these numbers be 
represented? On 32bit these may need a 'll' postfix, but the powerpc 
example already shows, that there are different requirements, so they use 
ASM_CONST for that. How should this postprecessing be integrated into 
kconfig?
I would seriously prefer to keep things as simple as possible, unless 
there is a real requirement for it, but so far there isn't any.
If we really needed something like this, I'd rather introduce a new 
expression type, which works more like an unquoted string (e.g. you 
could define something like (1l<<$PAGE_SHIFT)), where things like ranges 
wouldn't work, but it also wouldn't have any content restrictions.

bye, Roman
