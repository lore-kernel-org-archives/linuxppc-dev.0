Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF69F1A003F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jan 2016 15:29:06 +1100 (AEDT)
Message-ID: <1453091346.28504.8.camel@neuling.org>
Subject: Re: [PATCH V2 8/8] powerpc: Add the ability to save VSX without
 giving it up
From: Michael Neuling <mikey@neuling.org>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@ozlabs.org
Date: Mon, 18 Jan 2016 15:29:06 +1100
In-Reply-To: <20160118131052.7e3e02d9@camb691>
References: <1452834254-22078-1-git-send-email-cyrilbur@gmail.com>
 <1452834254-22078-9-git-send-email-cyrilbur@gmail.com>
 <1452839126.25634.43.camel@neuling.org> <20160118131052.7e3e02d9@camb691>
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


> > Also, put the #ifdef junk as part of the function so that the caller
> > doesn't have to deal with it.=20
> >=20
>=20
> Can do absolutely, however this means that in save_all I can't check if t=
he
> function needs to be called or not. For example, without CONFIG_VSX, MSR_=
VSX
> won't exist which means we might end up calling save_vsx THEN checking MS=
R_VSX
> and returning early.

MSR_VSX should exist even without CONFIG_VSX, so you should be able to
do it.

> I'm happy to defer to you and mpe on what's nicer, I would side with avoi=
ding
> the function call at the cost of ugly #ifdefs but I can always see the me=
rits
> of clean code.

I'd prefer the cleanup.  This code has been pretty bad in the past for
being a bit of an #ifdef mess, so it'd be nice to clean it up a bit if
possible.

Mikey
