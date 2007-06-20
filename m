Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: mita@fixstars.com
Subject: Re: [Cbe-oss-dev] [patch 2/5] Add support to OProfile for profiling
	Cell/B.E. SPUs
Date: Wed, 20 Jun 2007 11:35:58 +0200
References: <20070618224247.972139855@arndb.de>
	<20070618224923.221791941@arndb.de>
	<36420.202.32.178.37.1182306728.squirrel@webmail.fixstars.com>
In-Reply-To: <36420.202.32.178.37.1182306728.squirrel@webmail.fixstars.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706201135.58985.arnd@arndb.de>
Cc: Bob Nelson <rrnelson@us.ibm.com>, linuxppc-dev@ozlabs.org, paulus@samba.org,
	Maynard Johnson <mpjohn@us.ibm.com>, cbe-oss-dev@ozlabs.org,
	Carl Love <carll@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 20 June 2007, mita@fixstars.com wrote:
> > +
> > +=A0=A0=A0=A0=A0/* Allocate arrays for collecting SPU PC samples */
> > +=A0=A0=A0=A0=A0samples =3D (u32 *) kzalloc(SPUS_PER_NODE *
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =A0TRACE_ARRAY_SIZE * sizeof(u32), GFP_KERNEL);
> > +
>=20
> =A0- Unnecessary cast for kzalloc().
>=20
> =A0- Allocation failure is ignored here. But there is no error handling
> =A0 =A0in timer fuction (profile_spus), too.

Right. Bob, can you make a patch to remove the case and make sure that
we never access the sample array when the allocation has failed?

	Arnd <><
