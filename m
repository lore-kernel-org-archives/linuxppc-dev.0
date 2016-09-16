Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.192])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sbDPB3rMZzDsZw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 22:00:14 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Nicholas Piggin' <npiggin@gmail.com>, Madhavan Srinivasan
 <maddy@linux.vnet.ibm.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "paulus@samba.org" <paulus@samba.org>, "anton@samba.org" <anton@samba.org>
Subject: RE: [PATCH 04/13] powerpc: Use soft_enabled_set api to update
 paca->soft_enabled
Date: Fri, 16 Sep 2016 11:43:13 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB00FF817@AcuExch.aculab.com>
References: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1473944523-624-5-git-send-email-maddy@linux.vnet.ibm.com>
 <20160916195302.6b2f3320@roar.ozlabs.ibm.com>
In-Reply-To: <20160916195302.6b2f3320@roar.ozlabs.ibm.com>
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

From: Nicholas Piggin
> Sent: 16 September 2016 10:53
> On Thu, 15 Sep 2016 18:31:54 +0530
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
>=20
> > Force use of soft_enabled_set() wrapper to update paca-soft_enabled
> > wherever possisble. Also add a new wrapper function, soft_enabled_set_r=
eturn(),
> > added to force the paca->soft_enabled updates.
...
> > diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/a=
sm/hw_irq.h
> > index 8fad8c24760b..f828b8f8df02 100644
> > --- a/arch/powerpc/include/asm/hw_irq.h
> > +++ b/arch/powerpc/include/asm/hw_irq.h
> > @@ -53,6 +53,20 @@ static inline notrace void soft_enabled_set(unsigned=
 long enable)
> >  	: : "r" (enable), "i" (offsetof(struct paca_struct, soft_enabled)));
> >  }
> >
> > +static inline notrace unsigned long soft_enabled_set_return(unsigned l=
ong enable)
> > +{
> > +	unsigned long flags;
> > +
> > +	asm volatile(
> > +		"lbz %0,%1(13); stb %2,%1(13)"
> > +		: "=3Dr" (flags)
> > +		: "i" (offsetof(struct paca_struct, soft_enabled)),\
> > +		  "r" (enable)
> > +		: "memory");
> > +
> > +	return flags;
> > +}
>=20
> Why do you have the "memory" clobber here while soft_enabled_set() does n=
ot?

I wondered about the missing memory clobber earlier.

Any 'clobber' ought to be restricted to the referenced memory area.
If the structure is only referenced by r13 through 'asm volatile' it isn't =
needed.
OTOH why not allocate a global register variable to r13 and access through =
that?

	David
