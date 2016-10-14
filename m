Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3swPck3gMfzDskZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 21:54:46 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Michael Ellerman' <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
CC: Nicholas Piggin <npiggin@gmail.com>
Subject: RE: [PATCH] powerpc: link error on orphan sections
Date: Fri, 14 Oct 2016 10:54:39 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB01E8778@AcuExch.aculab.com>
References: <20161012070020.30170-1-npiggin@gmail.com>
 <87zim7dag4.fsf@concordia.ellerman.id.au>
In-Reply-To: <87zim7dag4.fsf@concordia.ellerman.id.au>
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

From: Michael Ellerman
> Sent: 14 October 2016 01:46
...
> > +LDFLAGS_vmlinux	:=3D $(LDFLAGS_vmlinux-y) --orphan-handling=3Derror
>=20
> At least some old(er) toolchains don't support that:
>=20
>   /opt/cross/kisskb/gcc-4.6.3-nolibc/powerpc-linux/bin/powerpc-linux-ld: =
unrecognized option '--
> orphan-handling=3Derror'
>=20
> So we'll need an ld-option wrapper around it.

In the past I've caused orphan sections to error by assigning them
to the same address as something that exists.
Works with all linkers, even if the error message isn't as useful.

	David
