Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 306EDB6F16
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Jul 2010 14:04:47 +1000 (EST)
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with
	ESMTP id o6E44BtO011552
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jul 2010 21:04:12 -0700
Received: by gwaa20 with SMTP id a20so3379646gwa.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Jul 2010 21:04:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTimC_vXCAOrfTSndZyk8lgkjTlILVSYVYeIg6cUt@mail.gmail.com>
References: <20100713114322.57c8b166.sfr@canb.auug.org.au>
	<AANLkTimC_vXCAOrfTSndZyk8lgkjTlILVSYVYeIg6cUt@mail.gmail.com>
Date: Tue, 13 Jul 2010 21:04:06 -0700
Message-ID: <AANLkTik-QCXFnjma3J28B9h27uajOcDhthTGz99zKgVi@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Enable building defconfigs from Kconfig files
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Grant Likely <grant.likely@secretlab.ca>
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

On Tue, Jul 13, 2010 at 7:26 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
>
> I chose to use -D /dev/null (defconfig from an empty file) instead of
> -n (allnoconfig) so that default values in Kconfig would get
> respected. =A0For the benefit of everyone else, here's an excerpt from
> our IRC conversation this afternoon:
>
> 19:49 < gcl> sfr: [...] Your patch and my patch are
> =A0 =A0 =A0 =A0 =A0 =A0 essentially doing exactly the same thing, except =
that I used '-d'
> =A0 =A0 =A0 =A0 =A0 =A0 and you used '-n'.
> 19:50 < gcl> s/-d/-D/
> 19:55 < sfr> right
> 19:55 < sfr> Linus wanted us to use -n

Just a note: Linus doesn't really care.

IOW, I used -n not because of any fundamental belief that it is
correct, but just because ti happened to be how I happened to decide
to solve it. It's entirely possible that starting from the Kconfig
defaults (rather than "no") is the right way to go.

I think either approach is likely fine. The -D /dev/null approach
would presumably give smaller Kconfig.xyz files, assuming our defaults
are sane (an maybe that could be at least a partial validation of the
defaults we do have). While the -n approach is in some ways more
stable, in that the resulting Kconfig.xyz entires would presumably be
more stand-alone, and there wouldn't be any subtle interactions when
somebody changes a default value int he Kconfig file.

So I can see advantages to either model. And either model clearly
would want the improvements to "select" that are independent (ie warn
about unsatisfied 'depends on' constraints, and select recursively.
Maybe we already fixed the recursive select thing, I forget).

I also think we need to allow setting of actual values. I don't know
what the syntax would be. A "set" statement that overrides a default
in the Kconfig file, so that you can do

          set NODES_SHIFT 10

which would basically be equivalent to a "select" of a tristate
variable, but instead set the actual value? I dunno.

And quite frankly, maybe somebody comes up with a better model
entirely. I like the Kconfig.xyz model, in that it should be
human-readable/writable and shouldn't introduce any fundamentally new
concepts (except the fairly simple extensions to the Kconfig
language), but maybe there are better models.

Regardless, I don't have anything against either set of patches
(Grant's or Stephen's).

                       Linus
