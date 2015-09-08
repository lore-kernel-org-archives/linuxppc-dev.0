Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6DFBD1A0163
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Sep 2015 13:54:22 +1000 (AEST)
Message-ID: <1441684462.14597.3.camel@ellerman.id.au>
Subject: Re: memcpy regression
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Michal Sojka' <sojkam1@fel.cvut.cz>, Christophe LEROY
 <christophe.leroy@c-s.fr>, Scott Wood <scottwood@freescale.com>, Paul
 Mackerras <paulus@samba.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 08 Sep 2015 13:54:22 +1000
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CB8E77D@AcuExch.aculab.com>
References: <871teeux4w.fsf@steelpick.2x.cz> <55E9A354.6070600@c-s.fr>
 <87si6utfpf.fsf@steelpick.2x.cz> <55E9DE87.4070805@c-s.fr>
 <55E9F5CE.6050904@fel.cvut.cz> <55EA3281.3000806@fel.cvut.cz>
 <55EBF6CD.5010001@c-s.fr> <87twr74bdg.fsf@steelpick.2x.cz>
 <87r3mb4603.fsf@steelpick.2x.cz> <1441588450.12945.1.camel@ellerman.id.au>
 <55ED37D1.3080503@c-s.fr> <1441615249.8979.1.camel@ellerman.id.au>
 <55ED5CCE.5000200@fel.cvut.cz>
 <063D6719AE5E284EB5DD2968C1650D6D1CB8E77D@AcuExch.aculab.com>
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

On Mon, 2015-09-07 at 10:59 +0000, David Laight wrote:
> From: Michal Sojka
> > >> I think GCC uses memcpy() in well known situations like initialising
> > >> structures or copying structures.
> > >> Shouldn't we just avoid this kind of actions in the very few early init
> > >> functions ?
> > > Which are the "very few" early init functions? Can you make a list, for 32-bit
> > > and 64-bit? And can we keep it updated over time and not introduce regressions?
> > >
> > If the code that runs without caches is concentrated in few files, we
> > may either modify the buildsystem to check whether there is a call to
> > memcpy from these files (e.g. by using nm) or these files can be
> > "prelinked" with special version of memcpy that doesn't require caches.
> > Would any of these be acceptable?
> 
> What about run-time patching memcpy() after the caches are initialised?

Yeah, that's the solution we use on 64-bit.

It also means you can have cpu specific optimisations, which can be patched in
or out using the cpu feature patching.

cheers
