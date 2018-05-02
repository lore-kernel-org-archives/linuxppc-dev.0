Return-Path: <srs0=udou=hv=suse.de=msuchanek@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bbvy3SzpzF2S2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 21:41:34 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40bbvy2cZ0z8svQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 21:41:34 +1000 (AEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40bbvx4HCNz9s0W
 for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2018 21:41:33 +1000 (AEST)
Date: Wed, 2 May 2018 13:41:28 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, npiggin@gmail.com
Subject: Re: [PATCH 4/6] powerpc/64s: Enable barrier_nospec based on
 firmware settings
Message-ID: <20180502134128.4a31b0fc@kitsune.suse.cz>
In-Reply-To: <87vac7r5px.fsf@concordia.ellerman.id.au>
References: <20180424041559.32410-1-mpe@ellerman.id.au>
 <20180424041559.32410-4-mpe@ellerman.id.au>
 <20180426180258.04e6bee6@kitsune.suse.cz>
 <87vac7r5px.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 01 May 2018 21:11:06 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Michal Such=C3=A1nek <msuchanek@suse.de> writes:
> > Hello,
> >
> > On Tue, 24 Apr 2018 14:15:57 +1000
> > Michael Ellerman <mpe@ellerman.id.au> wrote:
> > =20
> >> From: Michal Suchanek <msuchanek@suse.de>
> >>=20
> >> Check what firmware told us and enable/disable the barrier_nospec
> >> as appropriate.
> >>=20
> >> We err on the side of enabling the barrier, as it's no-op on older
> >> systems, see the comment for more detail.
> >>=20
> >> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au> =20
> ...
> >
> > I am missing the option for the barrier to be disabled by a kernel
> > commandline argument here.
> >
> > It does make sense to add a kernel parameter that is checked on
> > boot to be compatible with other platforms that implement one. =20
>=20
> No other platforms have an option to disable variant 1 mitigations, so
> there isn't an existing parameter we can use.

Right, I was looking at an older implementation which turned off both
v1 and v2 with same parameter. In current kernel the v1 mitigation is
not turned off at all.
>=20
> Which is not to say we can't add one, but I wasn't sure if it was
> really worth it.

The current thinking is that most performance relevant cases are
covered with array_nospec which has little overhead. The less code we
have for this the better ;-)

Thanks

Michal
