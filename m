Return-Path: <sam@ravnborg.org>
Received: from pasmtpA.tele.dk (pasmtpa.tele.dk [80.160.77.114])
	by ozlabs.org (Postfix) with ESMTP id 545D6DDFE8
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 07:00:18 +1000 (EST)
Date: Mon, 7 Jul 2008 23:01:04 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: linux-next: kbuild tree build failure
Message-ID: <20080707210104.GB23647@uranus.ravnborg.org>
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

On Mon, Jul 07, 2008 at 06:13:55PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Mon, 7 Jul 2008, Stephen Rothwell wrote:
> 
> > Hi Sam,
> > 
> > Today's linux-next build (powerpc ppc64_defconfig) failed like this:
> > 
> > arch/powerpc/platforms/cell/spu_base.c: In function '__spu_trap_data_seg':
> > arch/powerpc/platforms/cell/spu_base.c:194: error: duplicate case value
> > arch/powerpc/platforms/cell/spu_base.c:177: error: previously used here
> 
> I guess there also has been a kconfig warning somewhere. :)
> I should have gone through all archs to test this, sorry about that.
> Luckily it's only powerpc that uses 64bit values. I would prefer to 
> standardize on 32bit values, as it doesn't really make sense to expect 
> from the user to input full 64bit values and it's easy to generate the 
> full value in a header. This would also ease on any portability issues 
> (kconfig is compiled with the host compiler not the target compiler).
> 
> Below is a patch that fixes this for all archs (generated against the git 
> tree). The powerpc parts need a more careful review, the rest isn't really 
> critical.
> 
> bye, Roman

Hi Roman.

>From your patch:

>  config PINT3_ASSIGN
>  	hex "PINT3_ASSIGN"
>  	depends on PINTx_REASSIGN
> -	default 0x02020303
> +	default 0x2020303


But ths change actually decrease readability of the
value. Before we had 4x2 hex characters. But now we have 3x2 + 1x1.
Does this check really by us enough to warrant this?

I am aware that the check is implmented by:

+                       str = strdup_type(def_sym->name, sym->type);
+                       if (strcmp(str, def_sym->name)) {
+                               prop_warn(prop,
+                                       "default for config symbol '%s'"
+                                       " should be %s", sym->name, str);
+                               prop->expr->left.sym = sym_lookup(str, SYMBOL_CO
+                       }
+                       free(str);
                        break;

Could we soften this check a little maybe?
At least so we accept leading null's.

As for the patch in general I will await an ack from powerpc
before applying it.

	Sam
