Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 3585EB7122
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Nov 2010 01:29:45 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 3/4][v2] fsl_rio: move machine_check handler into
	machine_check_e500 & machine_check_e500mc
Date: Thu, 11 Nov 2010 06:29:01 -0800
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E55201538C58@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <0B482EBF-AF82-4C61-A35E-D9619246D259@freescale.com>
References: <1288777018-24259-1-git-send-email-b21989@freescale.com>
	<0B482EBF-AF82-4C61-A35E-D9619246D259@freescale.com>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Kumar Gala" <kumar.gala@freescale.com>,
	"Shaohui Xie" <b21989@freescale.com>
Cc: akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala <kumar.gala@freescale.com> wrote:
> > @@ -527,8 +535,12 @@ int machine_check_e500(struct pt_regs *regs)
>=20
> To deal w/Alex's comment do:
>=20
> machine_check_e500(...) {
>=20
> 	int ret =3D 0;
>=20
>=20
> > 		printk("Bus - Write Address Error\n");
> > 	if (reason & MCSR_BUS_IBERR)
> > 		printk("Bus - Instruction Data Error\n");
> > -	if (reason & MCSR_BUS_RBERR)
> > +	if (reason & MCSR_BUS_RBERR) {
> > 		printk("Bus - Read Data Bus Error\n");
> > +#ifdef CONFIG_RAPIDIO
> > +		fsl_rio_mcheck_exception(regs);
> > +#endif
>=20
> make this like 'ret =3D fsl_rio...
>=20

Please, place it in the beginning of the machine_check_e500[mc](...) as
well to avoid any 'printk' if RIO exception was handled properly.

Alex.=20
