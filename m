Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0050.hostedemail.com
 [216.40.44.50])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wJjZ1pqbzDrBy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 02:15:29 +1000 (AEST)
Message-ID: <0ccd6834d0c4a24f351050d0cd7581e2d2aecd7c.camel@perches.com>
Subject: Re: [PATCH] powerpc/64s: Enhance the information in
 cpu_show_spectre_v1()
From: Joe Perches <joe@perches.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Michal
 =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Mauricio Faria
 de Oliveira <mauricfo@linux.vnet.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>, Michael Neuling <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org,  linux-kernel@vger.kernel.org
Date: Tue, 29 May 2018 09:15:21 -0700
In-Reply-To: <59492aa2-a12d-4f74-0a5a-14f89de64908@c-s.fr>
References: <20180424041559.32410-1-mpe@ellerman.id.au>
 <20180528131914.32231-1-msuchanek@suse.de>
 <1b720765-faf1-719e-ab76-b3eafa559896@c-s.fr>
 <20180529164640.02faedcd@kitsune.suse.cz>
 <59492aa2-a12d-4f74-0a5a-14f89de64908@c-s.fr>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-05-29 at 15:24 +0000, Christophe Leroy wrote:
> On 05/29/2018 02:46 PM, Michal Suchánek wrote:
> > On Tue, 29 May 2018 16:13:49 +0200 Christophe LEROY <christophe.leroy@c-s.fr> wrote:
[]
> > diff --git a/arch/powerpc/kernel/security.c
> > > > b/arch/powerpc/kernel/security.c index 0239383c7e4d..a0c32d53980b
> > > > 100644 --- a/arch/powerpc/kernel/security.c
> > > > +++ b/arch/powerpc/kernel/security.c
> > > > @@ -120,7 +120,10 @@ ssize_t cpu_show_spectre_v1(struct device
> > > > *dev, struct device_attribute *attr, c if
> > > > (!security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR)) return
> > > > sprintf(buf, "Not affected\n");
> > > > -	return sprintf(buf, "Vulnerable\n");
> > > > +	if (barrier_nospec_enabled)
> > > > +		return sprintf(buf, "Mitigation: __user pointer
> > > > sanitization\n");
> > > > +	else
> > > > +		return sprintf(buf, "Vulnerable\n");
> > > 
> > > Checkpatch would tell you that an else is unneeded after a return. So
> > > just leave it as it was before.
> > 
> > Where did you get your copy of checkpatch? The one in Linux tree does
> > not do that.

Correct as this particular style is a maintainer preference.

> Strange, it should, as checkpatch.pl includes the following code:
> 
> # check indentation of any line with a bare else
> # (but not if it is a multiple line "if (foo) return bar; else return baz;")

Note this comment and also that this case is

	if (foo)
		return bar;
	else
		return baz;

so no warning is generated.

> # if the previous line is a break or return and is indented 1 tab more...
> 		if ($sline =~ /^\+([\t]+)(?:}[ \t]*)?else(?:[ \t]*{)?\s*$/) {
> 			my $tabs = length($1) + 1;
> 			if ($prevline =~ /^\+\t{$tabs,$tabs}break\b/ ||
> 			    ($prevline =~ /^\+\t{$tabs,$tabs}return\b/ &&
> 			     defined $lines[$linenr] &&
> 			     $lines[$linenr] !~ /^[ \+]\t{$tabs,$tabs}return/)) {
> 				WARN("UNNECESSARY_ELSE",
> 				     "else is not generally useful after a break or return\n" . 
> $hereprev);
> 			}
> 		}
> 
> 
> Anyway, you should remove that 'else' in your patch.
> And the other sprintf line is over 80 characters.
> 
> Christophe
> 
> > 
> > Thanks
> > 
> > Michal
> > 
