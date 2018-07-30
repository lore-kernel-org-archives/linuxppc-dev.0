Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fQ6m3HQTzF14j
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 02:30:55 +1000 (AEST)
Date: Mon, 30 Jul 2018 18:30:47 +0200
Message-ID: <20180730183047.Horde.g9hQ_3EXmF6St0upNs2DDw1@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Alastair D'Silva <alastair@d-silva.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, Balbir Singh
 <bsingharora@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Cyril Bur <cyrilbur@gmail.com>, "Eric W . Biederman"
 <ebiederm@xmission.com>, Michael Ellerman <mpe@ellerman.id.au>, Michael
 Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>, Paul
 Mackerras <paulus@samba.org>, Simon Guo <wei.guo.simon@gmail.com>, Sukadev
 Bhattiprolu <sukadev@linux.vnet.ibm.com>, "Tobin C . Harding" <me@tobin.cc>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 04/10] powerpc/traps: Use REG_FMT in show_signal_msg()
References: <20180727145811.12334-1-muriloo@linux.ibm.com>
 <20180727145811.12334-5-muriloo@linux.ibm.com>
 <20180727184023.Horde.KRXPzZpG18uxt_B9sy_FBg5@messagerie.si.c-s.fr>
 <20180730152838.GA23704@kermit-br-ibm-com>
In-Reply-To: <20180730152838.GA23704@kermit-br-ibm-com>
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Murilo Opsfelder Araujo <muriloo@linux.ibm.com> a =C3=A9crit=C2=A0:

> Hi, Christophe.
>
> On Fri, Jul 27, 2018 at 06:40:23PM +0200, LEROY Christophe wrote:
>> Murilo Opsfelder Araujo <muriloo@linux.ibm.com> a =C3=A9crit=C2=A0:
>>
>> > Simplify the message format by using REG_FMT as the register format.  =
This
>> > avoids having two different formats and avoids checking for MSR_64BIT.
>>
>> Are you sure it is what we want ?
>
> Yes.
>
>> Won't it change the behaviour for a 32 bits app running on a 64bits kern=
el ?
>
> In fact, this changes how many zeroes are prefixed when displaying=20=20
>=20the registers
> (%016lx vs. %08lx format).  For example, 32-bits userspace, 64-bits kerne=
l:

Indeed that's what I suspected. What is the real benefit of this=20=20
change=20? Why not keep the current format for 32bits userspace ? All=20=20
those=20leading zeroes are pointless to me.

>
> before this series:
>   [66475.002900] segv[4599]: unhandled signal 11 at 00000000 nip=20=20
>=2010000420 lr 0fe61854 code 1
>
> after this series:
>   [   73.414535] segv[3759]: segfault (11) at 0000000000000000 nip=20=20
>=200000000010000420 lr 000000000fe61854 code 1 in segv[10000000+10000]
>   [   73.414641] segv[3759]: code: 4e800421 80010014 38210010=20=20
>=207c0803a6 4bffff30 9421ffd0 93e1002c 7c3f0b78
>   [   73.414665] segv[3759]: code: 39200000 913f001c 813f001c=20=20
>=2039400001 <91490000> 39200000 7d234b78 397f0030
>
> Have you spotted any other behaviour change?

Not as of today

Christophe

>
> Cheers
> Murilo
