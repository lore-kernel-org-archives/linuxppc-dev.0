Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>,
	Tom Rini <trini@kernel.crashing.org>
Subject: Re: can/should we use gcc 3.1 to compile kernels
Date: Fri, 7 Jun 2002 19:39:44 -0400
Cc: linuxppc-dev@lists.linuxppc.org
References: <5.1.1.2.2.20020607222718.04331998@mail.lauterbach.com> <5.1.1.2.2.20020607225633.04090ea8@mail.lauterbach.com>
In-Reply-To: <5.1.1.2.2.20020607225633.04090ea8@mail.lauterbach.com>
MIME-Version: 1.0
Message-Id: <200206071939.44925.kevin.hendricks@sympatico.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

FYI: I counted 1175 occurences of warnings like the following:

inode.c:2462: warning: concatenation of string literals with __FUNCTION__
is deprecated

So I hope someone has a nice sed or awk script to fix all of these in some
automatic way.

Kevin


> > > It's not __FUNCTION__ per se that gcc is unhappy about, but string
> > > concatenation with it. So instead of printk ( __FUNCTION__ "text
> > > %d", value) use printk (" %s, text %d", __FUNCTION__, value). No big
> > > deal.
> > >
> > > I think current 3.2 already refuses to compile that.
> >
> >I thought it was 3.1 that gave a big warning about __FUNCTION__ being
> >depreciated entirely and 3.2 which just removed __FUNCTION__ at all.
> > Or have things been changed abit?
>
> No, but the warning was always about "string concatenation":
> [fsirl@entropy:~]$ cat FUNCTION.c
> #include <stdio.h>
> int main (void)
> {
>    printf (__FUNCTION__ " text %d", 5);
>    printf ("%s text %d", __FUNCTION__, 5);
>    return 0;
> }
> [fsirl@entropy:~]$ gcc -O2 FUNCTION.c
> FUNCTION.c: In function `main':
> FUNCTION.c:5: warning: concatenation of string literals with
> __FUNCTION__ is deprecated
>
> So, only one warning is issued.
>
> Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
