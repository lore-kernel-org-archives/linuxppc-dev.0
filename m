Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcNjN11qQzDqK6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 02:18:48 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Segher Boessenkool' <segher@kernel.crashing.org>, Gabriel Paubert
 <paubert@iram.es>
CC: "paulus@samba.org" <paulus@samba.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH] powerpc: Avoid panic during boot due to divide by zero
 in init_cache_info()
Date: Mon, 6 Mar 2017 15:18:37 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DCFE78D11@AcuExch.aculab.com>
References: <1488671674-20833-1-git-send-email-anton@ozlabs.org>
 <87pohw3tp4.fsf@concordia.ellerman.id.au>
 <20170305123737.GM31469@gate.crashing.org>
 <20170305165837.GA2019@visitor2.iram.es>
 <20170305172456.GN31469@gate.crashing.org>
 <20170306120319.GA17443@visitor2.iram.es>
 <20170306141735.GR31469@gate.crashing.org>
In-Reply-To: <20170306141735.GR31469@gate.crashing.org>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Segher Boessenkool
> Sent: 06 March 2017 14:18
> On Mon, Mar 06, 2017 at 01:03:19PM +0100, Gabriel Paubert wrote:
> > > > > The PowerPC divw etc. instructions do not trap by themselves, but=
 recent
> > > > > GCC inserts trap instructions on code paths that are always undef=
ined
> > > > > behaviour (like, dividing by zero).
> > > >
> > > > Is it systematic or does it depend from, e.g., optimization levels?
> > >
> > > In this case it needs -fisolate-erroneous-paths-dereference which is
> > > default at -O2 and higher.
> >
> > Great, another optimization-dependent behaviour. :-(
>=20
> It makes the "behaviour" for undefined behaviour *less* surprising.
> It does not change anything else: malformed programs stay malformed,
> correct programs do exactly what they did before, too.

Yep, 'undefined behaviour' is exactly that.
It doesn't mean 'undefined result', or 'maybe a signal'.
Wiping the disk and targeting the user with an ICBM are both valid.

	David
