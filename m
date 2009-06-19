Return-Path: <paulus@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F0349B72AD
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 10:47:54 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E06D3DDDA0
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 10:47:54 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <19002.57382.880505.913539@cargo.ozlabs.ibm.com>
Date: Fri, 19 Jun 2009 10:47:34 +1000
From: Paul Mackerras <paulus@samba.org>
To: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH 1/2] lib: Provide generic atomic64_t implementation
In-Reply-To: <8bd0f97a0906181655jd68835fg10fe0783b6a6068d@mail.gmail.com>
References: <18995.20685.227683.561827@cargo.ozlabs.ibm.com>
	<8bd0f97a0906181655jd68835fg10fe0783b6a6068d@mail.gmail.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mike Frysinger writes:

> On Sat, Jun 13, 2009 at 03:10, Paul Mackerras wrote:
> > +typedef struct {
> > + =A0 =A0 =A0 long long counter;
> > +} atomic64_t;
>=20
> lack of volatile seems odd compared to:
> include/linux/types.h:
> typedef struct {
>     volatile int counter;
> } atomic_t;
> -mike

It's only accessed under a spinlock, so I don't think it needs to be
volatile.  On UP it's accessed within local_irq_save/restore which
should also be compiler barriers and prevent memory access reordering,
so again volatile isn't needed.

Paul.
