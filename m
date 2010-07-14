Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) by ozlabs.org (Postfix) with ESMTP id 8CE611007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Jul 2010 15:48:07 +1000 (EST)
Received: by gyd10 with SMTP id 10so3868710gyd.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Jul 2010 22:48:06 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <AANLkTik-QCXFnjma3J28B9h27uajOcDhthTGz99zKgVi@mail.gmail.com>
References: <20100713114322.57c8b166.sfr@canb.auug.org.au>
	<AANLkTimC_vXCAOrfTSndZyk8lgkjTlILVSYVYeIg6cUt@mail.gmail.com>
	<AANLkTik-QCXFnjma3J28B9h27uajOcDhthTGz99zKgVi@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 13 Jul 2010 23:47:46 -0600
Message-ID: <AANLkTimYDDviG2no6RVPZZj8rD2d2URMAPUCWuftiFiB@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Enable building defconfigs from Kconfig files
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michal Marek <mmarek@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Catalin Marinas <catalin.marinas@arm.com>,
	LKML <linux-kernel@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 13, 2010 at 10:04 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Jul 13, 2010 at 7:26 PM, Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>>
>> I chose to use -D /dev/null (defconfig from an empty file) instead of
>> -n (allnoconfig) so that default values in Kconfig would get
>> respected. =A0For the benefit of everyone else, here's an excerpt from
>> our IRC conversation this afternoon:
>>
>> 19:49 < gcl> sfr: [...] Your patch and my patch are
>> =A0 =A0 =A0 =A0 =A0 =A0 essentially doing exactly the same thing, except=
 that I used '-d'
>> =A0 =A0 =A0 =A0 =A0 =A0 and you used '-n'.
>> 19:50 < gcl> s/-d/-D/
>> 19:55 < sfr> right
>> 19:55 < sfr> Linus wanted us to use -n
>
> Just a note: Linus doesn't really care.
>
> IOW, I used -n not because of any fundamental belief that it is
> correct, but just because ti happened to be how I happened to decide
> to solve it. It's entirely possible that starting from the Kconfig
> defaults (rather than "no") is the right way to go.
>
> I think either approach is likely fine. The -D /dev/null approach
> would presumably give smaller Kconfig.xyz files, assuming our defaults
> are sane (an maybe that could be at least a partial validation of the
> defaults we do have). While the -n approach is in some ways more
> stable, in that the resulting Kconfig.xyz entires would presumably be
> more stand-alone, and there wouldn't be any subtle interactions when
> somebody changes a default value int he Kconfig file.

Okay, well I advocate for the -D /dev/null approach then.  I think
that validating our defaults, and looking for the subtle interactions
are exactly what we want to be doing when it comes to defconfigs.  The
fact that a defconfig does *not* want the default value is exactly
what the defconfigs should be capturing.

> So I can see advantages to either model. And either model clearly
> would want the improvements to "select" that are independent (ie warn
> about unsatisfied 'depends on' constraints, and select recursively.
> Maybe we already fixed the recursive select thing, I forget).
>
> I also think we need to allow setting of actual values. I don't know
> what the syntax would be. A "set" statement that overrides a default
> in the Kconfig file, so that you can do
>
> =A0 =A0 =A0 =A0 =A0set NODES_SHIFT 10
>
> which would basically be equivalent to a "select" of a tristate
> variable, but instead set the actual value? I dunno.

I'm partial to extending select statements myself because it fits
nicely into the existing grammer; but I can see value in having a set
statement too.  It would eliminate the temporary config options that
both my and Stephen's patch would add.

> And quite frankly, maybe somebody comes up with a better model
> entirely. I like the Kconfig.xyz model, in that it should be
> human-readable/writable and shouldn't introduce any fundamentally new
> concepts (except the fairly simple extensions to the Kconfig
> language), but maybe there are better models.

Perhaps, but I can't think of anything and this one is simple,
elegant, and easy to implement.

> Regardless, I don't have anything against either set of patches
> (Grant's or Stephen's).

I think we should run with this.  Since the patch has been merged to
warn on unmet Kconfig dependences, the only major hole left is being
able to do negative selects and to select specific values.  Stephen,
I'm happy to either keep working on this, or drop my patch in favor of
yours.  Whichever you prefer.  I'll try to find some time to look at
the Kconfig grammer.

The solver would also be useful and could further reduce the size of
the Kconfig fragments, but it isn't necessary so we don't need to wait
for it to get implemented to take this approach..

Cheers,
g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
