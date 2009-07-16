Return-Path: <norsk5@yahoo.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0ACA3B7B5C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jul 2009 10:20:56 +1000 (EST)
Received: from web50110.mail.re2.yahoo.com (web50110.mail.re2.yahoo.com
	[206.190.38.38]) by ozlabs.org (Postfix) with SMTP id F1108DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2009 10:20:54 +1000 (EST)
Message-ID: <356572.69677.qm@web50110.mail.re2.yahoo.com>
Date: Wed, 15 Jul 2009 17:14:12 -0700 (PDT)
From: Doug Thompson <norsk5@yahoo.com>
Subject: Re: [PATCH 2/4] edac: mpc85xx add mpc83xx support
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20090715125249.e746496f.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>, linux-kernel@vger.kernel.org,
	Dave Jiang <djiang@mvista.com>, linuxppc-dev@ozlabs.org,
	bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=0AIra or Kumar,=0A=0Acan you address Andrew's concerns below and what was =
posted in prior posts on this?=0A=0Athanks=0A=0Adoug t=0A=0A--- On Wed, 7/1=
5/09, Andrew Morton <akpm@linux-foundation.org> wrote:=0A=0A> From: Andrew =
Morton <akpm@linux-foundation.org>=0A> Subject: Re: [PATCH 2/4] edac: mpc85=
xx add mpc83xx support=0A> To: dougthompson@xmission.com=0A> Cc: bluesmoke-=
devel@lists.sourceforge.net, linux-kernel@vger.kernel.org=0A> Date: Wednesd=
ay, July 15, 2009, 1:52 PM=0A> On Wed, 15 Jul 2009 11:38:49 -0600=0A> dougt=
hompson@xmission.com=0A> wrote:=0A> =0A> > =0A> > Add support for the Frees=
cale MPC83xx memory=0A> controller to the existing=0A> > driver for the Fre=
escale MPC85xx memory controller.=0A> The only difference=0A> > between the=
 two processors are in the CS_BNDS register=0A> parsing code, which=0A> > h=
as been changed so it will work on both processors.=0A> > =0A> > The L2 cac=
he controller does not exist on the MPC83xx,=0A> but the OF subsystem=0A> >=
 will not use the driver if the device is not present=0A> in the OF device =
tree.=0A> > =0A> > =0A> > Kumar, I had to change the nr_pages calculation t=
o=0A> make the math work=0A> > out. I checked it on my board and did the ma=
th by hand=0A> for a 64GB 85xx=0A> > using 64K pages. In both cases, nr_pag=
es * PAGE_SIZE=0A> comes out to the=0A> > correct value. Thanks for the hel=
p.=0A> > =0A> > v1 -> v2:=0A> >=A0=A0=A0* Use PAGE_SHIFT to parse cs_bnds=
=0A> regardless of board type=0A> >=A0=A0=A0* Remove special-casing for the=
 83xx=0A> processor=0A> > =0A> > ...=0A> >=0A> > @@ -789,19 +791,20 @@ stat=
ic void __devinit=0A> mpc85xx_init_csrow=0A> >=A0 =A0=A0=A0 =A0=A0=A0 csrow=
 =3D=0A> &mci->csrows[index];=0A> >=A0 =A0=A0=A0 =A0=A0=A0 cs_bnds =3D=0A> =
in_be32(pdata->mc_vbase + MPC85XX_MC_CS_BNDS_0 +=0A> >=A0 =A0=A0=A0 =A0=A0=
=A0=0A> =A0=A0=A0 =A0=A0=A0 =A0 (index *=0A> MPC85XX_MC_CS_BNDS_OFS));=0A> =
> -=A0=A0=A0 =A0=A0=A0 start =3D=0A> (cs_bnds & 0xfff0000) << 4;=0A> > -=A0=
=A0=A0 =A0=A0=A0 end =3D ((cs_bnds=0A> & 0xfff) << 20);=0A> > -=A0=A0=A0 =
=A0=A0=A0 if (start)=0A> > -=A0=A0=A0 =A0=A0=A0=0A> =A0=A0=A0 start |=3D 0x=
fffff;=0A> > -=A0=A0=A0 =A0=A0=A0 if (end)=0A> > -=A0=A0=A0 =A0=A0=A0=0A> =
=A0=A0=A0 end |=3D 0xfffff;=0A> > +=0A> > +=A0=A0=A0 =A0=A0=A0 start =3D=0A=
> (cs_bnds & 0xffff0000) >> 16;=0A> > +=A0=A0=A0 =A0=A0=A0=0A> end=A0=A0=A0=
=3D (cs_bnds & 0x0000ffff);=0A> >=A0 =0A> >=A0 =A0=A0=A0 =A0=A0=A0 if (star=
t=0A> =3D=3D end)=0A> >=A0 =A0=A0=A0 =A0=A0=A0=0A> =A0=A0=A0 continue;=A0=
=A0=A0 /* not=0A> populated */=0A> >=A0 =0A> > +=A0=A0=A0 =A0=A0=A0 start <=
<=3D=0A> (24 - PAGE_SHIFT);=0A> > +=A0=A0=A0 =A0=A0=A0=0A> end=A0=A0=A0<<=
=3D (24 - PAGE_SHIFT);=0A> > +=A0=A0=A0 =A0=A0=A0 end=A0=0A> =A0 |=3D (1 <<=
 (24 - PAGE_SHIFT)) - 1;=0A> =0A> <stares for a while>=0A> =0A> That looks =
like the original code was really really wrong.=0A> =0A> The setting of all=
 the lower bits in `end' is=0A> funny-looking.=A0 What's=0A> happening here=
?=A0 Should it be commented?=0A> =0A> =0A> >=A0 =A0=A0=A0 =A0=A0=A0=0A> csr=
ow->first_page =3D start >> PAGE_SHIFT;=0A> >=A0 =A0=A0=A0 =A0=A0=A0=0A> cs=
row->last_page =3D end >> PAGE_SHIFT;=0A> > -=A0=A0=A0 =A0=A0=A0=0A> csrow-=
>nr_pages =3D csrow->last_page + 1 -=0A> csrow->first_page;=0A> > +=A0=A0=
=A0 =A0=A0=A0=0A> csrow->nr_pages =3D end + 1 - start;=0A> >=A0 =A0=A0=A0 =
=A0=A0=A0=0A> csrow->grain =3D 8;=0A> >=A0 =A0=A0=A0 =A0=A0=A0=0A> csrow->m=
type =3D mtype;=0A> >=A0 =A0=A0=A0 =A0=A0=A0=0A> csrow->dtype =3D DEV_UNKNO=
WN;=0A> > @@ -985,6 +988,7 @@ static struct of_device_id=0A> mpc85xx_mc_er=
=0A> >=A0 =A0=A0=A0 { .compatible =3D=0A> "fsl,mpc8560-memory-controller", =
},=0A> >=A0 =A0=A0=A0 { .compatible =3D=0A> "fsl,mpc8568-memory-controller"=
, },=0A> >=A0 =A0=A0=A0 { .compatible =3D=0A> "fsl,mpc8572-memory-controlle=
r", },=0A> > +=A0=A0=A0 { .compatible =3D=0A> "fsl,mpc8349-memory-controlle=
r", },=0A> >=A0 =A0=A0=A0 { .compatible =3D=0A> "fsl,p2020-memory-controlle=
r", },=0A> >=A0 =A0=A0=A0 {},=0A> >=A0 };=0A> > @@ -1001,13 +1005,13 @@ sta=
tic struct=0A> of_platform_driver mpc85xx=0A> >=A0 =A0=A0=A0 =A0=A0=A0=0A> =
=A0=A0=A0},=0A> >=A0 };=0A> >=A0 =0A> > -=0A> > +#ifdef CONFIG_MPC85xx=0A> =
>=A0 static void __init mpc85xx_mc_clear_rfxe(void=0A> *data)=0A> >=A0 {=0A=
> >=A0 =A0=A0=A0 orig_hid1[smp_processor_id()]=0A> =3D mfspr(SPRN_HID1);=0A=
> >=A0 =A0=A0=A0 mtspr(SPRN_HID1,=0A> (orig_hid1[smp_processor_id()] & ~0x2=
0000));=0A> >=A0 }=0A> > -=0A> > +#endif=0A> >=A0 =0A> >=A0 static int __in=
it mpc85xx_mc_init(void)=0A> >=A0 {=0A> > @@ -1040,26 +1044,32 @@ static in=
t __init=0A> mpc85xx_mc_init(void)=0A> >=A0 =A0=A0=A0 =A0=A0=A0=0A> printk(=
KERN_WARNING EDAC_MOD_STR "PCI fails to=0A> register\n");=0A> >=A0 #endif=
=0A> >=A0 =0A> > +#ifdef CONFIG_MPC85xx=0A> >=A0 =A0=A0=A0 /*=0A> >=A0 =A0=
=A0=A0=A0=A0* need to clear=0A> HID1[RFXE] to disable machine check int=0A>=
 >=A0 =A0=A0=A0=A0=A0* so we can catch=0A> it=0A> >=A0 =A0=A0=A0=A0=A0*/=0A=
> >=A0 =A0=A0=A0 if (edac_op_state =3D=3D=0A> EDAC_OPSTATE_INT)=0A> >=A0 =
=A0=A0=A0 =A0=A0=A0=0A> on_each_cpu(mpc85xx_mc_clear_rfxe, NULL, 0);=0A> > =
+#endif=0A> >=A0 =0A> >=A0 =A0=A0=A0 return 0;=0A> >=A0 }=0A> =0A> The patc=
h adds lots of ifdefs :(=0A> =0A> >=A0 module_init(mpc85xx_mc_init);=0A> >=
=A0 =0A> > +#ifdef CONFIG_MPC85xx=0A> >=A0 static void __exit mpc85xx_mc_re=
store_hid1(void=0A> *data)=0A> >=A0 {=0A> >=A0 =A0=A0=A0 mtspr(SPRN_HID1,=
=0A> orig_hid1[smp_processor_id()]);=0A> >=A0 }=0A> > +#endif=0A> =0A> afac=
it this will run smp_processor_id() from within=0A> preemptible code,=0A> w=
hich is often buggy on preemptible kernels and will cause=0A> runtime=0A> w=
arnings on at least some architectures.=0A> =0A> >=A0 static void __exit mp=
c85xx_mc_exit(void)=0A> >=A0 {=0A> > +#ifdef CONFIG_MPC85xx=0A> >=A0 =A0=A0=
=A0=0A> on_each_cpu(mpc85xx_mc_restore_hid1, NULL, 0);=0A> > +#endif=0A> >=
=A0 #ifdef CONFIG_PCI=0A> >=A0 =A0=A0=A0=0A> of_unregister_platform_driver(=
&mpc85xx_pci_err_driver);=0A> >=A0 #endif=0A> 
