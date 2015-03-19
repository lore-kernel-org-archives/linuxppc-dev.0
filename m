Return-Path: <weiyang.kernel@gmail.com>
Received: from mail-oi0-x235.google.com (mail-oi0-x235.google.com
 [IPv6:2607:f8b0:4003:c06::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 22EFC1A02CB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 03:18:35 +1100 (AEDT)
Received: by oier21 with SMTP id r21so69226299oie.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 09:18:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150319150824.GE26935@google.com>
References: <1425446353-30513-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1425446353-30513-16-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150311135507.GA16664@google.com> <20150312011517.GA5833@richard>
 <20150319150824.GE26935@google.com>
Date: Fri, 20 Mar 2015 00:18:31 +0800
Message-ID: <CADLM8XOFfQmfEXeqObNatGmvonFRF29RVyhhOaKaxzdYxpHoEw@mail.gmail.com>
Subject: Re: [PATCH V13 15/21] powerpc/powernv: Reserve additional space for
 IOV BAR according to the number of total_pe
From: Wei Yang <weiyang.kernel@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Content-Type: multipart/alternative; boundary=001a11c360340e63140511a68d0c
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a11c360340e63140511a68d0c
Content-Type: text/plain; charset=UTF-8

Oh, I thought you are not comfortable with the "Patch v12 10/21 PCI:
Consider additional PF's IOV BAR alignment ..."

V14 is ready to send which is based on v4.0-rc1.

2015-03-19 23:08 GMT+08:00 Bjorn Helgaas <bhelgaas@google.com>:

> On Thu, Mar 12, 2015 at 09:15:17AM +0800, Wei Yang wrote:
> > On Wed, Mar 11, 2015 at 08:55:07AM -0500, Bjorn Helgaas wrote:
> > >On Wed, Mar 04, 2015 at 01:19:07PM +0800, Wei Yang wrote:
> > >> On PHB3, PF IOV BAR will be covered by M64 window to have better PE
> > >> isolation.  The total_pe number is usually different from total_VFs,
> which
> > >> can lead to a conflict between MMIO space and the PE number.
> > >>
> > >> For example, if total_VFs is 128 and total_pe is 256, the second half
> of
> > >> M64 window will be part of other PCI device, which may already belong
> > >> to other PEs.
> > >>
> > >> Prevent the conflict by reserving additional space for the PF IOV BAR,
> > >> which is total_pe number of VF's BAR size.
> > >>
> > >> [bhelgaas: make dev_printk() output more consistent, index resource[]
> > >> conventionally]
> > >> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> > >> ---
> > >>  arch/powerpc/include/asm/machdep.h        |    4 ++
> > >>  arch/powerpc/include/asm/pci-bridge.h     |    3 ++
> > >>  arch/powerpc/kernel/pci-common.c          |    5 +++
> > >>  arch/powerpc/kernel/pci-hotplug.c         |    4 ++
> > >>  arch/powerpc/platforms/powernv/pci-ioda.c |   61
> +++++++++++++++++++++++++++++
> > >>  5 files changed, 77 insertions(+)
> > >>
> > >> diff --git a/arch/powerpc/include/asm/machdep.h
> b/arch/powerpc/include/asm/machdep.h
> > >> index c8175a3..965547c 100644
> > >> --- a/arch/powerpc/include/asm/machdep.h
> > >> +++ b/arch/powerpc/include/asm/machdep.h
> > >> @@ -250,6 +250,10 @@ struct machdep_calls {
> > >>    /* Reset the secondary bus of bridge */
> > >>    void  (*pcibios_reset_secondary_bus)(struct pci_dev *dev);
> > >>
> > >> +#ifdef CONFIG_PCI_IOV
> > >> +  void (*pcibios_fixup_sriov)(struct pci_bus *bus);
> > >> +#endif /* CONFIG_PCI_IOV */
> > >> +
> > >>    /* Called to shutdown machine specific hardware not already
> controlled
> > >>     * by other drivers.
> > >>     */
> > >> diff --git a/arch/powerpc/include/asm/pci-bridge.h
> b/arch/powerpc/include/asm/pci-bridge.h
> > >> index 513f8f2..de11de7 100644
> > >> --- a/arch/powerpc/include/asm/pci-bridge.h
> > >> +++ b/arch/powerpc/include/asm/pci-bridge.h
> > >> @@ -175,6 +175,9 @@ struct pci_dn {
> > >>  #define IODA_INVALID_PE           (-1)
> > >>  #ifdef CONFIG_PPC_POWERNV
> > >>    int     pe_number;
> > >> +#ifdef CONFIG_PCI_IOV
> > >> +  u16     max_vfs;                /* number of VFs IOV BAR expended
> */
> > >> +#endif /* CONFIG_PCI_IOV */
> > >>  #endif
> > >>    struct list_head child_list;
> > >>    struct list_head list;
> > >> diff --git a/arch/powerpc/kernel/pci-common.c
> b/arch/powerpc/kernel/pci-common.c
> > >> index 8203101..022e9fe 100644
> > >> --- a/arch/powerpc/kernel/pci-common.c
> > >> +++ b/arch/powerpc/kernel/pci-common.c
> > >> @@ -1646,6 +1646,11 @@ void pcibios_scan_phb(struct pci_controller
> *hose)
> > >>    if (ppc_md.pcibios_fixup_phb)
> > >>            ppc_md.pcibios_fixup_phb(hose);
> > >>
> > >> +#ifdef CONFIG_PCI_IOV
> > >> +  if (ppc_md.pcibios_fixup_sriov)
> > >> +          ppc_md.pcibios_fixup_sriov(bus);
> > >> +#endif /* CONFIG_PCI_IOV */
> > >
> > >Here, and ...
> > >
> > >> +
> > >>    /* Configure PCI Express settings */
> > >>    if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
> > >>            struct pci_bus *child;
> > >> diff --git a/arch/powerpc/kernel/pci-hotplug.c
> b/arch/powerpc/kernel/pci-hotplug.c
> > >> index 5b78917..7d238ae 100644
> > >> --- a/arch/powerpc/kernel/pci-hotplug.c
> > >> +++ b/arch/powerpc/kernel/pci-hotplug.c
> > >> @@ -94,6 +94,10 @@ void pcibios_add_pci_devices(struct pci_bus * bus)
> > >>             */
> > >>            slotno = PCI_SLOT(PCI_DN(dn->child)->devfn);
> > >>            pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
> > >> +#ifdef CONFIG_PCI_IOV
> > >> +          if (ppc_md.pcibios_fixup_sriov)
> > >> +                  ppc_md.pcibios_fixup_sriov(bus);
> > >> +#endif /* CONFIG_PCI_IOV */
> > >
> > >here, you have the same code.  It's good that we now do it for hot-added
> > >devices as well as those present at boot.  But it's bad that it happens
> in
> > >two different paths.
> > >
> > >Isn't there some way we can unify this so the same path is used for the
> > >initial pcibios_scan_phb() and also the hot-add case?  Maybe call
> > >pcibios_fixup_sriov() from pcibios_add_device()?
> > >
> >
> >
> > This is a very good suggestion. I have changed this and works fine.
>
> I was expecting a v14 series with this change.  Is it coming, or are you
> waiting for something else from me?
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



-- 
Richard Yang
Help You, Help Me

--001a11c360340e63140511a68d0c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Oh, I thought you are not comfortable with the &quot;Patch=
=C2=A0v12 10/21 PCI: Consider additional PF&#39;s IOV BAR alignment ...&quo=
t;<div><br></div><div>V14 is ready to send which is based on v4.0-rc1.=C2=
=A0</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">20=
15-03-19 23:08 GMT+08:00 Bjorn Helgaas <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:bhelgaas@google.com" target=3D"_blank">bhelgaas@google.com</a>&gt;</spa=
n>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h=
5">On Thu, Mar 12, 2015 at 09:15:17AM +0800, Wei Yang wrote:<br>
&gt; On Wed, Mar 11, 2015 at 08:55:07AM -0500, Bjorn Helgaas wrote:<br>
&gt; &gt;On Wed, Mar 04, 2015 at 01:19:07PM +0800, Wei Yang wrote:<br>
&gt; &gt;&gt; On PHB3, PF IOV BAR will be covered by M64 window to have bet=
ter PE<br>
&gt; &gt;&gt; isolation.=C2=A0 The total_pe number is usually different fro=
m total_VFs, which<br>
&gt; &gt;&gt; can lead to a conflict between MMIO space and the PE number.<=
br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; For example, if total_VFs is 128 and total_pe is 256, the sec=
ond half of<br>
&gt; &gt;&gt; M64 window will be part of other PCI device, which may alread=
y belong<br>
&gt; &gt;&gt; to other PEs.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Prevent the conflict by reserving additional space for the PF=
 IOV BAR,<br>
&gt; &gt;&gt; which is total_pe number of VF&#39;s BAR size.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; [bhelgaas: make dev_printk() output more consistent, index re=
source[]<br>
&gt; &gt;&gt; conventionally]<br>
&gt; &gt;&gt; Signed-off-by: Wei Yang &lt;<a href=3D"mailto:weiyang@linux.v=
net.ibm.com">weiyang@linux.vnet.ibm.com</a>&gt;<br>
&gt; &gt;&gt; ---<br>
&gt; &gt;&gt;=C2=A0 arch/powerpc/include/asm/machdep.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 4 ++<br>
&gt; &gt;&gt;=C2=A0 arch/powerpc/include/asm/pci-bridge.h=C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 3 ++<br>
&gt; &gt;&gt;=C2=A0 arch/powerpc/kernel/pci-common.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 5 +++<br>
&gt; &gt;&gt;=C2=A0 arch/powerpc/kernel/pci-hotplug.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 4 ++<br>
&gt; &gt;&gt;=C2=A0 arch/powerpc/platforms/powernv/pci-ioda.c |=C2=A0 =C2=
=A061 +++++++++++++++++++++++++++++<br>
&gt; &gt;&gt;=C2=A0 5 files changed, 77 insertions(+)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerp=
c/include/asm/machdep.h<br>
&gt; &gt;&gt; index c8175a3..965547c 100644<br>
&gt; &gt;&gt; --- a/arch/powerpc/include/asm/machdep.h<br>
&gt; &gt;&gt; +++ b/arch/powerpc/include/asm/machdep.h<br>
&gt; &gt;&gt; @@ -250,6 +250,10 @@ struct machdep_calls {<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 /* Reset the secondary bus of bridge */<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 void=C2=A0 (*pcibios_reset_secondary_bus)(struct=
 pci_dev *dev);<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; +#ifdef CONFIG_PCI_IOV<br>
&gt; &gt;&gt; +=C2=A0 void (*pcibios_fixup_sriov)(struct pci_bus *bus);<br>
&gt; &gt;&gt; +#endif /* CONFIG_PCI_IOV */<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 /* Called to shutdown machine specific hardware =
not already controlled<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0* by other drivers.<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt;&gt; diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/pow=
erpc/include/asm/pci-bridge.h<br>
&gt; &gt;&gt; index 513f8f2..de11de7 100644<br>
&gt; &gt;&gt; --- a/arch/powerpc/include/asm/pci-bridge.h<br>
&gt; &gt;&gt; +++ b/arch/powerpc/include/asm/pci-bridge.h<br>
&gt; &gt;&gt; @@ -175,6 +175,9 @@ struct pci_dn {<br>
&gt; &gt;&gt;=C2=A0 #define IODA_INVALID_PE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(-1)<br>
&gt; &gt;&gt;=C2=A0 #ifdef CONFIG_PPC_POWERNV<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 int=C2=A0 =C2=A0 =C2=A0pe_number;<br>
&gt; &gt;&gt; +#ifdef CONFIG_PCI_IOV<br>
&gt; &gt;&gt; +=C2=A0 u16=C2=A0 =C2=A0 =C2=A0max_vfs;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* number of VFs IOV BAR expended */<br>
&gt; &gt;&gt; +#endif /* CONFIG_PCI_IOV */<br>
&gt; &gt;&gt;=C2=A0 #endif<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 struct list_head child_list;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 struct list_head list;<br>
&gt; &gt;&gt; diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/=
kernel/pci-common.c<br>
&gt; &gt;&gt; index 8203101..022e9fe 100644<br>
&gt; &gt;&gt; --- a/arch/powerpc/kernel/pci-common.c<br>
&gt; &gt;&gt; +++ b/arch/powerpc/kernel/pci-common.c<br>
&gt; &gt;&gt; @@ -1646,6 +1646,11 @@ void pcibios_scan_phb(struct pci_contr=
oller *hose)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 if (ppc_md.pcibios_fixup_phb)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ppc_md.pcibios_fixup=
_phb(hose);<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; +#ifdef CONFIG_PCI_IOV<br>
&gt; &gt;&gt; +=C2=A0 if (ppc_md.pcibios_fixup_sriov)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ppc_md.pcibios_fixup_srio=
v(bus);<br>
&gt; &gt;&gt; +#endif /* CONFIG_PCI_IOV */<br>
&gt; &gt;<br>
&gt; &gt;Here, and ...<br>
&gt; &gt;<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 /* Configure PCI Express settings */<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 if (bus &amp;&amp; !pci_has_flag(PCI_PROBE_ONLY)=
) {<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct pci_bus *chil=
d;<br>
&gt; &gt;&gt; diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc=
/kernel/pci-hotplug.c<br>
&gt; &gt;&gt; index 5b78917..7d238ae 100644<br>
&gt; &gt;&gt; --- a/arch/powerpc/kernel/pci-hotplug.c<br>
&gt; &gt;&gt; +++ b/arch/powerpc/kernel/pci-hotplug.c<br>
&gt; &gt;&gt; @@ -94,6 +94,10 @@ void pcibios_add_pci_devices(struct pci_bu=
s * bus)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slotno =3D PCI_SLOT(=
PCI_DN(dn-&gt;child)-&gt;devfn);<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_scan_slot(bus, P=
CI_DEVFN(slotno, 0));<br>
&gt; &gt;&gt; +#ifdef CONFIG_PCI_IOV<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ppc_md.pcibios_fixup_=
sriov)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ppc_md.pcibios_fixup_sriov(bus);<br>
&gt; &gt;&gt; +#endif /* CONFIG_PCI_IOV */<br>
&gt; &gt;<br>
&gt; &gt;here, you have the same code.=C2=A0 It&#39;s good that we now do i=
t for hot-added<br>
&gt; &gt;devices as well as those present at boot.=C2=A0 But it&#39;s bad t=
hat it happens in<br>
&gt; &gt;two different paths.<br>
&gt; &gt;<br>
&gt; &gt;Isn&#39;t there some way we can unify this so the same path is use=
d for the<br>
&gt; &gt;initial pcibios_scan_phb() and also the hot-add case?=C2=A0 Maybe =
call<br>
&gt; &gt;pcibios_fixup_sriov() from pcibios_add_device()?<br>
&gt; &gt;<br>
&gt;<br>
&gt;<br>
&gt; This is a very good suggestion. I have changed this and works fine.<br=
>
<br>
</div></div>I was expecting a v14 series with this change.=C2=A0 Is it comi=
ng, or are you<br>
waiting for something else from me?<br>
<div class=3D"HOEnZb"><div class=3D"h5">___________________________________=
____________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.=
org</a><br>
<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank=
">https://lists.ozlabs.org/listinfo/linuxppc-dev</a></div></div></blockquot=
e></div><br><br clear=3D"all"><div><br></div>-- <br><div class=3D"gmail_sig=
nature">Richard Yang<br>Help You, Help Me</div>
</div>

--001a11c360340e63140511a68d0c--
