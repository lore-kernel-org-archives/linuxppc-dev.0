Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Chen Gang <gang.chen@asianux.com>
Subject: Re: [Suggestion] PowerPC: kernel: cross compiling issue with
 allmodconfig
In-reply-to: <514AA0D9.1090509@asianux.com>
References: <51428C81.6000204@asianux.com>
 <25841.1363323174@ale.ozlabs.ibm.com> <5142AE27.7060003@asianux.com>
 <514AA0D9.1090509@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Date: Fri, 22 Mar 2013 09:54:46 +1100
Message-ID: <10123.1363906486@ale.ozlabs.ibm.com>
Cc: sfr@canb.auug.org.au, matt@ozlabs.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "paulus@samba.org" <paulus@samba.org>, imunsie@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Chen Gang <gang.chen@asianux.com> wrote:

> Hello All:
>=20
> summary:
>   the root cause is no enough room in exception area (0x5500 -- 0x7000).
>=20
>   it is caused by the patches "for saving/restre PPR":
>     they consumed much space of this area (0x5500 -- 0x7000).
>     for pseries_defconfig and ppc64_defconfig, it is still ok.
>     but for allmodconfig and "some additional config", it will cause issu=
e.
>=20
>   the solving patch "Make room in exception vector area" can make room la=
rger.
>     it can let "some additional config" ok.
>     but for allmodconfig, it is still not enough.
>=20
>=20
> details
>   reason:
>     it is caused by:
>        commit number: 13e7a8e846c2ea38a552b986ea49332f965bbb7a
>        commit number: 44e9309f1f357794b7ae93d5f3e3e6f11d2b8a7f
>     they are "for saving/restore PPR"
>     by Haren Myneni <haren@linux.vnet.ibm.com> Thu, 6 Dec 2012
>     compiling result:
>       pseries_defconfig: pass   (cpu for POWER7)
>       ppc64_defconfig:   pass   (cpu for POWER7)
>       allmodconfig:      failed (cpu for POWER7)
>=20
>   analysing:
>     solving patch:
>       ------------------------------------------------------------------
>       commit number: 61383407677aef05928541a00678591abea2d84c
>       Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>       Date:   Thu Jan 10 17:44:19 2013 +1100
>=20
>         powerpc: Make room in exception vector area
>=20=20=20=20=20
>         The FWNMI region is fixed at 0x7000 and the vector are now
>         overflowing that with some configurations. Fix that by moving
>         some hash management code out of that region as it doesn't need
>         to be that close to the call sites (isn't accessed using
>         conditional branches).
>       ------------------------------------------------------------------
>=20
>       but for allmodconfig (not only for "some configurations"):
>         it really can reduce much overflow bytes,
>           (maybe from hundreds bytes to dozens bytes)
>         but still not enough (still content overflow bytes)
>=20
>     additional trying:
> 	after del CONFIG_VSX and CONFIG_PPC_970_NAP in allmodconfig,
>           (will reduce dozens bytes in the region .0x5500 -- .0x7000)
>         it can pass compiling (not overflow).
>=20
>=20
> next:
>   I am sorry:
>       I am not quite familiar with the detail features of powerpc.
>       it seems I am not the suitable member to continue trying.
>=20
>   I prefer Benjamin to continue trying (just like what he has done).
>=20
>   if Benjamin will not do it (e.g. maybe no time to do)
>     I should continue: "make additional room in exception vector area".
>       (if get no reply within a week: before 2013-03-28, I should continu=
e)
>=20
>=20
>=20
>   welcome any members' (especially Benjamin) suggestions or completions.

This is great, thanks a lot.=20=20

If you want this to be picked up by the maintainer, you'll need to add
your signed-off-by.

The signed-off-by is to indicate that your happy for it to be included
and that you're legally allowed to do so.  See
http://gerrit.googlecode.com/svn/documentation/2.0/user-signedoffby.html
for more info.

Mikey

>=20
>   thanks.
>=20
>   :-)
>=20
>=20
> On 2013=E5=B9=B403=E6=9C=8815=E6=97=A5 13:14, Chen Gang wrote:
> > =E4=BA=8E 2013=E5=B9=B403=E6=9C=8815=E6=97=A5 12:52, Michael Neuling =
=E5=86=99=E9=81=93:
> >> Yep it's a known problem but no one has bothered to fix it since it
> >> doesn't happen in a config that anyone cares about like
> >> pseries_defconfig and ppc64_defconfig.  We've been moving code around =
in
> >> this area a lot recently hence the breakage.
> >>
> >> It should be fixed though.  Patches welcome. :-)
> >=20
> >   thanks, and I should try, and very glad to try.
> >=20
> >   :-)  :-)
> >=20
> >   excuse me, I try to provide related patch within this month (2013-03-=
31), is it ok ?
> >   the reason is:
> >     I am not familiar with ppc assembly code, neither ppc kernel,
> >     so need additional time resource.
> >       (originally, I worked for x86(_64) core dump analysing for kernel=
 and user programs)
> >=20
> >   thanks.
> >=20
>=20
>=20
> --=20
> Chen Gang
>=20
> Asianux Corporation
>=20
