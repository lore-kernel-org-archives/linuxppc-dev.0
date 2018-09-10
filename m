Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4283Zp4xmKzF37s
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 20:05:38 +1000 (AEST)
Message-ID: <794308ed6aa6dcccf96e10bb0e3fa8d2dab9adff.camel@neuling.org>
Subject: Re: [PATCH] powerpc: Avoid code patching freed init sections
From: Michael Neuling <mikey@neuling.org>
To: Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, Haren Myneni
 <haren@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Paul
 Mackerras <paulus@ozlabs.org>
Date: Mon, 10 Sep 2018 20:05:38 +1000
In-Reply-To: <20180910115457.60366160@naga.suse.cz>
References: <20180910054405.32422-1-mikey@neuling.org>
 <20180910115457.60366160@naga.suse.cz>
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


> > +	/* Make sure we aren't patching a freed init section */
> > +	if (in_init_section(patch_addr) && init_freed())
> > +		return 0;
> > +
>=20
> Do we even need the init_freed() check?

Maybe not.  If userspace isn't up, then maybe it's ok to skip.

> What user input can we process in init-only code?

See the stack trace in the commit message. It's a weird case for KVM guests=
 in
KVM PR mode.=20

That's the only case I can found so far.

> Also it would be nice to write the function+offset of the skipped patch
> location into the kernel log.

OK. I'll update.

Mikey
