Return-Path: <B08248@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DEFA42C007E
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2013 05:27:26 +1100 (EST)
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH][v2] KVM: PPC: add paravirt idle loop for 64-bit book E
Date: Thu, 24 Jan 2013 18:26:12 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E150352642A@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1358898883-16218-1-git-send-email-stuart.yoder@freescale.com>
 <1359051740.24865.10@snotra>
In-Reply-To: <1359051740.24865.10@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Thursday, January 24, 2013 12:22 PM
> To: Yoder Stuart-B08248
> Cc: agraf@suse.de; benh@kernel.crashing.org; linuxppc-dev@ozlabs.org; kvm=
-ppc@vger.kernel.org;
> kvm@vger.kernel.org; Yoder Stuart-B08248
> Subject: Re: [PATCH][v2] KVM: PPC: add paravirt idle loop for 64-bit book=
 E
>=20
> On 01/22/2013 05:54:43 PM, Stuart Yoder wrote:
> > +.macro BOOK3E_IDLE_LOOP
> > +1:
> > +	PPC_WAIT(0)
> >  	b	1b
> > +.endm
> > +
> > +.macro EPAPR_EV_IDLE_LOOP
> > +idle_loop:
> > +       LOAD_REG_IMMEDIATE(r11, EV_HCALL_TOKEN(EV_IDLE))
> > +
> > +.global epapr_ev_idle_start
> > +epapr_ev_idle_start:
> > +       li      r3, -1
> > +       nop
> > +       nop
> > +       nop
> > +       b       idle_loop
> > +.endm
> > +
> > +BOOK3E_IDLE epapr_ev_idle, EPAPR_EV_IDLE_LOOP
> > +
> > +BOOK3E_IDLE book3e_idle BOOK3E_IDLE_LOOP
>=20
> Why the comma after epapr_ev_idle but not after book3e_idle?
>=20
> Also you have spaces where there should be tabs.
>=20
> Otherwise looks good.

Hmm...there shouldn't be a comma there.  I'll respin
and fix the whitespace too.

Stuart
