Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qnQ3v3m36zDq5v
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Apr 2016 05:50:03 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Pan Xinhui <xinhui@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] powerpc: introduce {cmp}xchg for u8 and u16
Date: Sat, 16 Apr 2016 21:43:24 +0200
Message-ID: <10192543.Wmc5qtLitu@wuerfel>
In-Reply-To: <570E2A45.9080702@linux.vnet.ibm.com>
References: <570752AA.9050603@linux.vnet.ibm.com>
 <20160412143023.GH1087@worktop> <570E2A45.9080702@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 13 April 2016 19:15:17 Pan Xinhui wrote:
> Hello Peter,
>=20
> On 2016=E5=B9=B404=E6=9C=8812=E6=97=A5 22:30, Peter Zijlstra wrote:
> > On Sun, Apr 10, 2016 at 10:17:28PM +0800, Pan Xinhui wrote:
> >>
> >> On 2016=E5=B9=B404=E6=9C=8808=E6=97=A5 15:47, Peter Zijlstra wrote=
:
> >>> On Fri, Apr 08, 2016 at 02:41:46PM +0800, Pan Xinhui wrote:
> >>>> From: pan xinhui <xinhui.pan@linux.vnet.ibm.com>
> >>>>
> >>>> Implement xchg{u8,u16}{local,relaxed}, and
> >>>> cmpxchg{u8,u16}{,local,acquire,relaxed}.
> >>>>
> >>>> Atomic operation on 8-bit and 16-bit data type is supported from=
 power7
> >>>
> >>> And yes I see nothing P7 specific here, this implementation is fo=
r
> >>> everything PPC64 afaict, no?
> >>>
> >> Hello Peter,
> >> =09No, it's not for every ppc. So yes, I need add #ifdef here. Tha=
nks for pointing it out.
> >> We might need a new config option and let it depend on POWER7/POWE=
R8_CPU or even POWER9...
> >=20
> > Right, I'm not sure if PPC has alternatives, but you could of cours=
e
> > runtime patch the code from emulated with 32bit ll/sc to native 8/1=
6bit
> > ll/sc if present on the current CPU if you have infrastructure for =
these
> > things.
> >=20
> seems interesting. I have no idea about how to runtime patch the code=
. I will try to learn that.
> If so, we need change {cmp}xchg into uninline functions?

I think you don't need to, see do_feature_fixups()/patch_feature_sectio=
n()

Note that an #ifdef by itself has to worry about any combination of
architectures, so in a kernel that has both POWER6 and POWER7 enabled,
you cannot call the POWER7-only function.

=09Arnd
