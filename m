Return-Path: <mmarek@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 54F92B6F0E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Jul 2010 06:23:01 +1000 (EST)
Message-ID: <4C3CCB1C.40206@suse.cz>
Date: Tue, 13 Jul 2010 22:22:52 +0200
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] kbuild: Enable building defconfigs from Kconfig files
References: <20100713114322.57c8b166.sfr@canb.auug.org.au>
In-Reply-To: <20100713114322.57c8b166.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/13/2010 03:43 AM, Stephen Rothwell wrote:
> After this change, doing a "make xxx_defconfig" will check first for
> a file called arch/<arch>/configs/Kconfig.xxx and use that to generate
> the .config (effectively starting from an allnoconfig).  If that file
> doesn't exist, it will use arch/<ARCH>/configs/xxx_defconfig as now.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  scripts/kconfig/Makefile |   14 +++++++++++++-
>  1 files changed, 13 insertions(+), 1 deletions(-)
> 
> Hi Linus,
> 
> Is this more the direction you want to take?
> 
> There are still 2 main problems with is approach:
> 
> 	- there are some config options that are globally and
> unconditionally enabled that some platforms may not want.  The only way
> currently to turn them off is to reproduce the config entry with the
> different default.  I am not sure if we need a wa to turn them off or to
> just change them to being neede to be selected by those that do want them.
> 	- we have no way to select options that are neither bool or
> tristate to suitable values.  Again the only way to do that currently is
> to reproduce the config entry with a different default value.

Hi Stephen,

how are these Kconfig.xxx files going look like? A list of 'select FOO'
 and 'include "Kconfig.other"' statements?

What about adding support for an include statement to the .config file
format and using that in the defconfigs instead? The VARIABLE=VALUE
grammar seems much more suitable for this than the kconfig language.

Michal
