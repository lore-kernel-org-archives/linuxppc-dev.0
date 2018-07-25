Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41b5hn2kyWzDrHF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 17:00:25 +1000 (AEST)
Message-ID: <0f185351330a7f1d66409fe6a2dc02aae6826039.camel@neuling.org>
Subject: Re: [PATCH 0/7] powerpc: Modernize unhandled signals message
From: Michael Neuling <mikey@neuling.org>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 linux-kernel@vger.kernel.org
Cc: Alastair D'Silva <alastair@d-silva.org>, Andrew Donnellan
 <andrew.donnellan@au1.ibm.com>, Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christophe Leroy
 <christophe.leroy@c-s.fr>, Cyril Bur <cyrilbur@gmail.com>,  "Eric W .
 Biederman" <ebiederm@xmission.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Simon Guo <wei.guo.simon@gmail.com>, Sukadev Bhattiprolu
 <sukadev@linux.vnet.ibm.com>,  "Tobin C . Harding" <me@tobin.cc>,
 linuxppc-dev@lists.ozlabs.org
Date: Wed, 25 Jul 2018 17:00:21 +1000
In-Reply-To: <20180724192720.32417-1-muriloo@linux.ibm.com>
References: <20180724192720.32417-1-muriloo@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 On Tue, 2018-07-24 at 16:27 -0300, Murilo Opsfelder Araujo wrote:
> Hi, everyone.
>=20
> This series was inspired by the need to modernize and display more
> informative messages about unhandled signals.
>=20
> The "unhandled signal NN" is not very informative.  We thought it would
> be helpful adding a human-readable message describing what the signal
> number means, printing the VMA address, and dumping the instructions.
>=20
> We can add more informative messages, like informing what each code of a
> SIGSEGV signal means.  We are open to suggestions.
>=20
> I have collected some early feedback from Michael Ellerman about this
> series and would love to hear more feedback from you all.

Nice.. the instruction dump would have been very handy when debugging the P=
CR
init issue I had a month or so back.

> Before this series:
>=20
>     Jul 24 13:01:07 localhost kernel: pandafault[5989]: unhandled signal =
11 at 00000000100007d0 nip 000000001000061c lr 00003fff85a75100 code 2
>=20
> After this series:
>=20
>     Jul 24 13:08:01 localhost kernel: pandafault[10758]: segfault (11) at=
 00000000100007d0 nip 000000001000061c lr 00007fffabc85100 code 2 in pandaf=
ault[10000000+10000]
>     Jul 24 13:08:01 localhost kernel: Instruction dump:
>     Jul 24 13:08:01 localhost kernel: 4bfffeec 4bfffee8 3c401002 38427f00=
 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
>     Jul 24 13:08:01 localhost kernel: 392988d0 f93f0020 e93f0020 39400048=
 <99490000> 39200000 7d234b78 383f0040

What happens if we get a sudden flood of these from different processes tha=
t
overlap their output? Are we going to be able to match up the process with
instruction dump?

Should we prefix every line with the PID to avoid this?

Mikey
