Return-Path: <sam@ravnborg.org>
Received: from pasmtpB.tele.dk (pasmtpb.tele.dk [80.160.77.98])
	by ozlabs.org (Postfix) with ESMTP id BC3FDDDF03
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 07:18:45 +1000 (EST)
Date: Tue, 8 Jul 2008 23:19:30 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: linux-next: kbuild tree build failure
Message-ID: <20080708211930.GA16897@uranus.ravnborg.org>
References: <20080707184038.aaeb8d40.sfr@canb.auug.org.au>
	<Pine.LNX.4.64.0807071424240.6791@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0807071424240.6791@localhost.localdomain>
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

Hi Roman.

I thought a bit more about this.

> I should have gone through all archs to test this, sorry about that.
> Luckily it's only powerpc that uses 64bit values. I would prefer to 
> standardize on 32bit values, as it doesn't really make sense to expect 
> from the user to input full 64bit values and it's easy to generate the 
> full value in a header.

We use Kconfig for a mixture of user editable values and fixed
configuration values.
And I agree that asking the user to input a 64 bit number is not usefull.

But keeping support for 64 bit values is what I would consider
expected functionality.
So removing support for 64 bit is not good IMO.

> This would also ease on any portability issues 
> (kconfig is compiled with the host compiler not the target compiler).

We use strtol() in a few places in symbol.c already where we do an
implicit conversion to int. Why did this not cause us problems before?

Is it because these code paths are only triggered when we deal with ranges?
If so we could 'fix' strdup_type() to not use strto{,u}l() so it
is 64 bit clean and we are back to old behaviour.

	Sam
