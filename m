Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y1CXv3crvzDsN9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 04:39:10 +1000 (AEST)
Date: Mon, 25 Sep 2017 20:39:01 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Tamara Diaconita <diaconitatamara@gmail.com>, Baoquan He
 <bhe@redhat.com>, Kamlakant Patel <kamlakant.patel@broadcom.com>, Jonathan
 Corbet <corbet@lwn.net>, Jani Nikula <jani.nikula@intel.com>, Mahesh
 Salgaonkar <mahesh@linux.vnet.ibm.com>, Trond Myklebust
 <trond.myklebust@primarydata.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Bamvor
 Jian Zhang <bamvor.zhangjian@linaro.org>, Andrew Morton
 <akpm@linux-foundation.org>, Paul Mackerras <paulus@samba.org>, Hari
 Bathini <hbathini@linux.vnet.ibm.com>, Ilya Matveychikov
 <matvejchikov@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/6] lib/cmdline.c: Add backslash support to kernel
 commandline parsing.
Message-ID: <20170925203901.0009b327@naga>
In-Reply-To: <20170915192856.1d5708b6@kitsune.suse.cz>
References: <4fabdf584ad18d6aae61e331f783a5020567f634.1505231820.git.msuchanek@suse.de>
 <28da60231eb848981e858fa33e3b7e33f8547111.1505494668.git.msuchanek@suse.de>
 <20170915171409.GZ5426@ZenIV.linux.org.uk>
 <20170915192856.1d5708b6@kitsune.suse.cz>
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

On Fri, 15 Sep 2017 19:28:56 +0200
Michal Such=C3=A1nek <msuchanek@suse.de> wrote:

> On Fri, 15 Sep 2017 18:14:09 +0100
> Al Viro <viro@ZenIV.linux.org.uk> wrote:
>=20
> > On Fri, Sep 15, 2017 at 07:02:46PM +0200, Michal Suchanek wrote:
> >  =20
> > >  	for (i =3D 0; args[i]; i++) {
> > > -		if (isspace(args[i]) && !in_quote)
> > > +		if (isspace(args[i]) && !in_quote && !backslash)
> > >  			break;
> > > -		if (equals =3D=3D 0) {
> > > -			if (args[i] =3D=3D '=3D')
> > > -				equals =3D i;
> > > +
> > > +		if ((equals =3D=3D 0) && (args[i] =3D=3D '=3D'))
> > > +			equals =3D i;
> > > +
> > > +		if (!backslash) {
> > > +			if ((args[i] =3D=3D '"') || (args[i] =3D=3D
> > > '\\')) {
> > > +				if (args[i] =3D=3D '"')
> > > +					in_quote =3D !in_quote;
> > > +				if (args[i] =3D=3D '\\')
> > > +					backslash =3D 1;
> > > +
> > > +				memmove(args + 1, args, i);
> > > +				args++;
> > > +				i--;
> > > +			}
> > > +		} else {
> > > +			backslash =3D 0;
> > >  		}
> > > -		if (args[i] =3D=3D '"')
> > > -			in_quote =3D !in_quote;
> > >  	}   =20
> >=20
> > ... and that makes for Unidiomatic Work With Strings Award for this
> > September. Using memmove() for string rewrite is almost always bad
> > taste; in this case it's also (as usual) broken. =20
>=20
> Care to share how it is broken?

Guess not. I will assume it is perfectly fine then. It works perfectly
fine in my testing.

Using memmove for string rewrite is not a matter of taste. It is the
only library function with sane semantics for rewrite of anything. Then
again open-coding it is always an option and maybe in better taste for
some :->

Michal
