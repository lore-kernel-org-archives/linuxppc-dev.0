Subject: Re: Building Glibc
To: rene.pachernegg@apus.co.at (Reni Pachernegg)
Date: Thu, 13 Jan 2000 09:55:39 +1100 (EST)
Cc: kd@flaga.is, linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <387C97CF.8F915DCF@apus.co.at> from "Reni Pachernegg" at Jan 12, 2000 04:03:43 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000112225539.62B021B152@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


=?iso-8859-1?Q?Ren=E9?= Pachernegg writes:
> I am trying to build the newest gcc as my powerpc-cross-compiler now
> (without installing the new gcc as my native compiler;is this really
> necessary?), but I have still problems with the configure options:

No, you shouldn't need to install gcc as your native compiler. However, you
need to make two passes at building your powerpc-linux-gcc cross. Before
building libc, configure it with:
    configure --with-languages=c --with-newlib

The '--with-newlib' should stop it complaining about libc missing, but the
libiberty build will still fail because of the missing headers. Nevertheless,
you can 'make install' and move on to configure/build glibc. After installing
glibc, go back and reconfigure & rebuild gcc (and g++ if you want it) without
the '--with-newlib' option.

Good luck!
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
