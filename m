Message-Id: <5.1.1.2.2.20020607225633.04090ea8@mail.lauterbach.com>
Date: Fri, 07 Jun 2002 22:58:38 +0200
To: Tom Rini <trini@kernel.crashing.org>
From: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>
Subject: Re: can/should we use gcc 3.1 to compile kernels
Cc: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20020607204535.GQ14252@opus.bloom.county>
References: <5.1.1.2.2.20020607222718.04331998@mail.lauterbach.com>
 <200206071544.56448.kevin.hendricks@sympatico.ca>
 <200206081337.31359.kevin.hendricks@sympatico.ca>
 <20020607193833.GO14252@opus.bloom.county>
 <200206071544.56448.kevin.hendricks@sympatico.ca>
 <5.1.1.2.2.20020607222718.04331998@mail.lauterbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 22:45 07.06.2002, Tom Rini wrote:
>On Fri, Jun 07, 2002 at 10:36:46PM +0200, Franz Sirl wrote:
> > At 22:19 07.06.2002, Tom Rini wrote:
> >
> > >On Fri, Jun 07, 2002 at 03:44:56PM -0400, Kevin B. Hendricks wrote:
> > >
> > >> Not too bad warnings-wize excpet for the controlfb.c where it constanly
> > >> gave a funny warning about "pasting ->".
> > >
> > >Sounds right.  I think there was a few other things too..
> >
> > The warning is correct, pasting "token1" (CNTRL_REG) with "token2" (->)
> > makes no sense, usually it's just a ## to much somewhere.
> >
> > >> It did this for every occurence of the macro CNTRL_REG which I must
> admit
> > >> has two ## which I think gcc was misinterpreting somehow.
> > >
> > >Well, isn't:
> > >#define x(foo) a_## foo ##_b
> > >A semi-common thing, like we do in indirect_pci.c ?  Or was it something
> > >different?
> >
> > Think about preprocessing tokens! If foo is "->" the ## make no sense at
> > all, cause "a_", "->" and "_b" are 3 separate preprocessing tokens, no
> need
> > to paste them together.
>
>Ah.  Got a patch? :)

Nope, not even worth a patch :-)), see the message to Kevin.



> > >> Other than that just the occaissioanal wanring about unused
> variables and
> > >> things like that.
> > >
> > >Lots of the USB stuff uses __FUNCTION__ which gcc-3.1 isn't happy
> > >about.
> >
> > It's not __FUNCTION__ per se that gcc is unhappy about, but string
> > concatenation with it. So instead of printk ( __FUNCTION__ "text %d",
> > value) use printk (" %s, text %d", __FUNCTION__, value). No big deal.
> >
> > I think current 3.2 already refuses to compile that.
>
>I thought it was 3.1 that gave a big warning about __FUNCTION__ being
>depreciated entirely and 3.2 which just removed __FUNCTION__ at all.  Or
>have things been changed abit?

No, but the warning was always about "string concatenation":
[fsirl@entropy:~]$ cat FUNCTION.c
#include <stdio.h>
int main (void)
{
   printf (__FUNCTION__ " text %d", 5);
   printf ("%s text %d", __FUNCTION__, 5);
   return 0;
}
[fsirl@entropy:~]$ gcc -O2 FUNCTION.c
FUNCTION.c: In function `main':
FUNCTION.c:5: warning: concatenation of string literals with __FUNCTION__
is deprecated

So, only one warning is issued.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
