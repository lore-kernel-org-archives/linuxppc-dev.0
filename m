Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 92633B6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Aug 2011 04:56:30 +1000 (EST)
Subject: Re: [PATCH] powerpc/kvm: fix build errors with older toolchains
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
In-Reply-To: <4E429CAD.5050000@suse.de>
References: <1312397755-15737-1-git-send-email-nacc@us.ibm.com>
	<4E429CAD.5050000@suse.de>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 10 Aug 2011 13:56:25 -0500
Message-ID: <1313002585.1674.13.camel@pasglop>
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Avi Kivity <avi@redhat.com>,
	Nishanth Aravamudan <nacc@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-08-10 at 16:58 +0200, Alexander Graf wrote:
> On 08/03/2011 08:55 PM, Nishanth Aravamudan wrote:
> > On a box with gcc 4.3.2, I see errors like:
> >
> > arch/powerpc/kvm/book3s_hv_rmhandlers.S:1254: Error: Unrecognized opcode: stxvd2x
> > arch/powerpc/kvm/book3s_hv_rmhandlers.S:1316: Error: Unrecognized opcode: lxvd2x
> 
> Paul, mind to ack?

I merged it already :-) It was trivial & annoying enough.

Cheers,
Ben.

> 
> Alex
> 
> > Signed-off-by: Nishanth Aravamudan<nacc@us.ibm.com>
> > ---
> >   arch/powerpc/kvm/book3s_hv_rmhandlers.S |    4 ++--
> >   1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > index 6dd3358..de29501 100644
> > --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > @@ -1251,7 +1251,7 @@ BEGIN_FTR_SECTION
> >   	reg = 0
> >   	.rept	32
> >   	li	r6,reg*16+VCPU_VSRS
> > -	stxvd2x	reg,r6,r3
> > +	STXVD2X(reg,r6,r3)
> >   	reg = reg + 1
> >   	.endr
> >   FTR_SECTION_ELSE
> > @@ -1313,7 +1313,7 @@ BEGIN_FTR_SECTION
> >   	reg = 0
> >   	.rept	32
> >   	li	r7,reg*16+VCPU_VSRS
> > -	lxvd2x	reg,r7,r4
> > +	LXVD2X(reg,r7,r4)
> >   	reg = reg + 1
> >   	.endr
> >   FTR_SECTION_ELSE
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
