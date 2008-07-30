Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 7AE1EDDE10
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 23:41:11 +1000 (EST)
Date: Wed, 30 Jul 2008 15:41:10 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH 2/6] kvmppc: add hypercall infrastructure - host part
In-Reply-To: <20080724014352.GI20457@bakeyournoodle.com>
Message-ID: <Pine.LNX.4.64.0807301540130.1993@vixen.sonytel.be>
References: <1216802207-32675-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1216802207-32675-3-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<20080724014352.GI20457@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584349381-374568469-1217425270=:1993"
Cc: embedded-hypervisor@power.org, kvm-ppc@vger.kernel.org, hollisb@us.ibm.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-374568469-1217425270=:1993
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 24 Jul 2008, Tony Breeds wrote:
> On Wed, Jul 23, 2008 at 10:36:43AM +0200, ehrhardt@linux.vnet.ibm.com wrote:
> > From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
> > diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
> > --- a/arch/powerpc/kvm/emulate.c
> > +++ b/arch/powerpc/kvm/emulate.c
> > @@ -203,6 +203,24 @@
> >  	kvmppc_set_msr(vcpu, vcpu->arch.srr1);
> >  }
> >  
> > +static int kvmppc_do_hypercall(struct kvm_vcpu *vcpu)
> > +{
> > +	int ret = 0;
> > +
> > +	switch (vcpu->arch.gpr[0]) {
> > +	default:
> > +		printk(KERN_ERR"unknown hypercall %d\n", vcpu->arch.gpr[0]);
> 
> I think the preffered style is printk(KERN_ERR "...)  You've made the
> same style mistake in most of you printk()'s in your other patches
> aswell.

Note that these days people use pr_err() instead.

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@eu.sony.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis 293-0376800-10 GEBA-BE-BB
---584349381-374568469-1217425270=:1993--
