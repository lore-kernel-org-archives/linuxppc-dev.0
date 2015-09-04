Return-Path: <jeclark2006@aim.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C5DA01A0796
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Sep 2015 09:37:33 +1000 (AEST)
Received: from mbob.nabble.com (mbob.nabble.com [162.253.133.15])
 by ozlabs.org (Postfix) with ESMTP id 58E591402A3
 for <linuxppc-dev@ozlabs.org>; Sat,  5 Sep 2015 09:37:32 +1000 (AEST)
Received: from mtom.nabble.com (unknown [162.253.133.81])
 by mbob.nabble.com (Postfix) with ESMTP id 2C5C914CD4DA
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Sep 2015 16:28:00 -0700 (PDT)
Date: Fri, 4 Sep 2015 15:59:06 -0700 (MST)
From: jeclark2006 <jeclark2006@aim.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <D62D6671-3577-4CE2-92E9-F3E10EFC2796@aim.com>
In-Reply-To: <55EA2678.5030801@linux.vnet.ibm.com>
References: <1439932430-13375-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1439932430-13375-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1440010450-4549-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20150903175624.GI829@google.com> <55EA2678.5030801@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] powerpc/PCI: Disable MSI/MSI-X interrupts at PCI
 probe time in OF case
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_Part_82604_1151393841.1441407546223"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------=_Part_82604_1151393841.1441407546223
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

One other thing.

The way to present all the people who submitted, such that each one got som=
e amount of exposure, was a dynamic thing that just occurred to me as we we=
re setting up.

Sort of like you first starting to select the judging panels, by =E2=80=98g=
uessing=E2=80=99 a number=E2=80=A6 which didn=E2=80=99t work very well, but=
 then counting out groups did. (even if there were groups that had some ext=
ras because the group was an odd number=E2=80=A6).

Next time, we will have this in mind and it will be very straightforward=E2=
=80=A6 1,2,3=E2=80=A6 for both how to select the panels, and how to present=
 the submissions.

Love,
John.


On Sep 4, 2015, at 3:46 PM, Guilherme G. Piccoli [via linuxppc] <ml-node+s1=
0917n98194h59@n7.nabble.com> wrote:

> Hello Bjorn,=20
>=20
> > of_create_pci_dev() already has a lot of code that duplicates=20
> > pci_setup_device(), and it's a shame to add more.  There's also a sparc=
=20
> > version of of_create_pci_dev() that presumably has the same problem you=
're=20
> > fixing for powerpc.=20
>=20
> Thanks for the information!=20
>=20
> > Michael originally called pci_msi_setup_pci_dev() from=20
> > pci_init_capabilities() [1].  A subsequent patch moved the call=20
> > to pci_setup_device() [2] because an early quirk (called from=20
> > pci_setup_device()) used pci_msi_off(), which depended on=20
> > pci_msi_setup_pci_dev().=20
> >=20
> > But we later removed pci_msi_off() completely, so I think we probably=
=20
> > *could* call pci_msi_setup_pci_dev() from pci_init_capabilities().=20
> >=20
> > That would be much nicer because it makes more sense there, and it=20
> > would do the right thing for powerpc and sparc because they both=20
> > already use that path.=20
> >=20
> > Can you look into moving the call?
>=20
> I might have misunderstood something here (sorry if it's the case), but=
=20
> moving the call to pci_init_capabilities() has the same practical=20
> implications than reverting my 2 commmits [1] [2] and Michael Tsirkin's=
=20
> commit [3], except when CONFIG_PCI_MSI is not set - in this case, moving=
=20
> the call would initialize MSI capabilities anyway, since=20
> pci_init_capabilities() executes even if CONFIG_PCI_MSI isn't set.=20
>=20
> My question is: is necessary to initialize MSI capabilities even with=20
> CONFIG_PCI_MSI not set? In negative case, would be "cleaner" revert the=
=20
> 3 commits, right?=20
>=20
> On the other hand, if it's necessary to initialize MSI capabilities on=20
> devices anyway, we can change the call place.=20
>=20
> Let me know your opinion, and I'm sorry if I misunderstood something here=
.=20
>=20
> Cheers,=20
>=20
>=20
> Guilherme Piccoli=20
>=20
>=20
>=20
> [1] commit 22b6839b914b ("PCI: Make pci_msi_setup_pci_dev() non-static=20
> for use by arch code")=20
>=20
> [2] commit 4d9aac397a5d ("powerpc/PCI: Disable MSI/MSI-X interrupts at=20
> PCI probe time in OF case")=20
>=20
> [3] commit 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even if=20
> kernel doesn't support MSI")=20
>=20
> _______________________________________________=20
> Linuxppc-dev mailing list=20
> [hidden email]=20
> https://lists.ozlabs.org/listinfo/linuxppc-dev=20
>=20
> If you reply to this email, your message will be added to the discussion =
below:
> http://linuxppc.10917.n7.nabble.com/PATCH-0-2-Disable-MSI-MSI-X-interrupt=
s-manually-at-PCI-probe-time-in-PowerPC-architecture-tp97680p98194.html
> To start a new topic under linuxppc-dev, email ml-node+s10917n3h38@n7.nab=
ble.com=20
> To unsubscribe from linuxppc, click here.
> NAML





--
View this message in context: http://linuxppc.10917.n7.nabble.com/PATCH-0-2=
-Disable-MSI-MSI-X-interrupts-manually-at-PCI-probe-time-in-PowerPC-archite=
cture-tp97680p98195.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
------=_Part_82604_1151393841.1441407546223
Content-Type: text/html; charset=UTF8
Content-Transfer-Encoding: quoted-printable

<meta http-equiv=3D"Content-Type" content=3D"text/html charset=3Dwindows-12=
52">One other thing.<div><br></div><div>The way to present all the people w=
ho submitted, such that each one got some amount of exposure, was a dynamic=
 thing that just occurred to me as we were setting up.</div><div><br></div>=
<div>Sort of like you first starting to select the judging panels, by =E2=
=80=98guessing=E2=80=99 a number=E2=80=A6 which didn=E2=80=99t work very we=
ll, but then counting out groups did. (even if there were groups that had s=
ome extras because the group was an odd number=E2=80=A6).</div><div><br></d=
iv><div>Next time, we will have this in mind and it will be very straightfo=
rward=E2=80=A6 1,2,3=E2=80=A6 for both how to select the panels, and how to=
 present the submissions.</div><div><br></div><div>Love,</div><div>John.</d=
iv><div><br></div><div><br><div><div>On Sep 4, 2015, at 3:46 PM, Guilherme =
G. Piccoli [via linuxppc] &lt;<a href=3D"/user/SendEmail.jtp?type=3Dnode&no=
de=3D98195&i=3D0" target=3D"_top" rel=3D"nofollow" link=3D"external">[hidde=
n email]</a>&gt; wrote:</div><br class=3D"Apple-interchange-newline"><block=
quote style=3D'border-left:2px solid #CCCCCC;padding:0 1em' type=3D"cite">

=09Hello Bjorn,
<br><br>&gt; of_create_pci_dev() already has a lot of code that duplicates
<br>&gt; pci_setup_device(), and it's a shame to add more. &nbsp;There's al=
so a sparc
<br>&gt; version of of_create_pci_dev() that presumably has the same proble=
m you're
<br>&gt; fixing for powerpc.
<br><br>Thanks for the information!
<br><div class=3D"shrinkable-quote"><div class=3D'shrinkable-quote'><br>&gt=
; Michael originally called pci_msi_setup_pci_dev() from
<br>&gt; pci_init_capabilities() [1]. &nbsp;A subsequent patch moved the ca=
ll
<br>&gt; to pci_setup_device() [2] because an early quirk (called from
<br>&gt; pci_setup_device()) used pci_msi_off(), which depended on
<br>&gt; pci_msi_setup_pci_dev().
<br>&gt;
<br>&gt; But we later removed pci_msi_off() completely, so I think we proba=
bly
<br>&gt; *could* call pci_msi_setup_pci_dev() from pci_init_capabilities().
<br>&gt;
<br>&gt; That would be much nicer because it makes more sense there, and it
<br>&gt; would do the right thing for powerpc and sparc because they both
<br>&gt; already use that path.
<br>&gt;
<br>&gt; Can you look into moving the call?
</div></div>I might have misunderstood something here (sorry if it's the ca=
se), but=20
<br>moving the call to pci_init_capabilities() has the same practical=20
<br>implications than reverting my 2 commmits [1] [2] and Michael Tsirkin's=
=20
<br>commit [3], except when CONFIG_PCI_MSI is not set - in this case, movin=
g=20
<br>the call would initialize MSI capabilities anyway, since=20
<br>pci_init_capabilities() executes even if CONFIG_PCI_MSI isn't set.
<br><br>My question is: is necessary to initialize MSI capabilities even wi=
th=20
<br>CONFIG_PCI_MSI not set? In negative case, would be "cleaner" revert the=
=20
<br>3 commits, right?
<br><br>On the other hand, if it's necessary to initialize MSI capabilities=
 on=20
<br>devices anyway, we can change the call place.
<br><br>Let me know your opinion, and I'm sorry if I misunderstood somethin=
g here.
<br><br>Cheers,
<br><br><br>Guilherme Piccoli
<br><br><br><br>[1] commit 22b6839b914b ("PCI: Make pci_msi_setup_pci_dev()=
 non-static=20
<br>for use by arch code")
<br><br>[2] commit 4d9aac397a5d ("powerpc/PCI: Disable MSI/MSI-X interrupts=
 at=20
<br>PCI probe time in OF case")
<br><br>[3] commit 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even =
if=20
<br>kernel doesn't support MSI")
<br><br>_______________________________________________
<br>Linuxppc-dev mailing list
<br>&lt;a href=3D&quot;x-msg://17/user/SendEmail.jtp?type=3Dnode&amp;amp;no=
de=3D98194&amp;amp;i=3D0&quot; target=3D&quot;_top&quot; rel=3D&quot;nofoll=
ow&quot; link=3D&quot;external&quot;&gt;[hidden email]</a>
<br><a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_t=
op" rel=3D"nofollow" link=3D"external">https://lists.ozlabs.org/listinfo/li=
nuxppc-dev</a>

=09
=09
=09
=09<br>
=09<br>
=09<hr noshade=3D"noshade" size=3D"1">
=09<div style=3D"color:#444; font: 12px tahoma,geneva,helvetica,arial,sans-=
serif;">
=09=09<div style=3D"font-weight:bold">If you reply to this email, your mess=
age will be added to the discussion below:</div>
=09=09<a href=3D"http://linuxppc.10917.n7.nabble.com/PATCH-0-2-Disable-MSI-=
MSI-X-interrupts-manually-at-PCI-probe-time-in-PowerPC-architecture-tp97680=
p98194.html" target=3D"_top" rel=3D"nofollow" link=3D"external">http://linu=
xppc.10917.n7.nabble.com/PATCH-0-2-Disable-MSI-MSI-X-interrupts-manually-at=
-PCI-probe-time-in-PowerPC-architecture-tp97680p98194.html</a>
=09</div>
=09<div style=3D"color:#666; font: 11px tahoma,geneva,helvetica,arial,sans-=
serif;margin-top:.4em;line-height:1.5em">
=09=09To start a new topic under linuxppc-dev, email <a href=3D"/user/SendE=
mail.jtp?type=3Dnode&node=3D98195&i=3D1" target=3D"_top" rel=3D"nofollow" l=
ink=3D"external">[hidden email]</a> <br>
=09=09To unsubscribe from linuxppc, <a href=3D"" target=3D"_top" rel=3D"nof=
ollow" link=3D"external">click here</a>.<br>
=09=09<a href=3D"http://linuxppc.10917.n7.nabble.com/template/NamlServlet.j=
tp?macro=3Dmacro_viewer&amp;id=3Dinstant_html%21nabble%3Aemail.naml&amp;bas=
e=3Dnabble.naml.namespaces.BasicNamespace-nabble.view.web.template.NabbleNa=
mespace-nabble.view.web.template.NodeNamespace&amp;breadcrumbs=3Dnotify_sub=
scribers%21nabble%3Aemail.naml-instant_emails%21nabble%3Aemail.naml-send_in=
stant_email%21nabble%3Aemail.naml" rel=3D"nofollow" style=3D"font:9px serif=
" target=3D"_top" link=3D"external">NAML</a>
=09</div></blockquote></div><br></div>

=09
=09
=09
<br/><hr align=3D"left" width=3D"300" />
View this message in context: <a href=3D"http://linuxppc.10917.n7.nabble.co=
m/PATCH-0-2-Disable-MSI-MSI-X-interrupts-manually-at-PCI-probe-time-in-Powe=
rPC-architecture-tp97680p98195.html">Re: [PATCH v2 2/2] powerpc/PCI: Disabl=
e MSI/MSI-X interrupts at PCI probe time in OF case</a><br/>
Sent from the <a href=3D"http://linuxppc.10917.n7.nabble.com/linuxppc-dev-f=
3.html">linuxppc-dev mailing list archive</a> at Nabble.com.<br/>
------=_Part_82604_1151393841.1441407546223--
