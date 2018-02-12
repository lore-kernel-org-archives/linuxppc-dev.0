Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zfw7Q2n9fzF0dR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 17:02:39 +1100 (AEDT)
Content-Type: multipart/alternative;
 boundary=Apple-Mail-075E060E-FAD4-432A-89CD-3BD6BFA7B823
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1] PCI: Make PCI_SCAN_ALL_PCIE_DEVS work for Root as well
 as Downstream Ports
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <20180210154342.GE206223@bhelgaas-glaptop.roam.corp.google.com>
Date: Mon, 12 Feb 2018 07:02:32 +0100
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Message-Id: <5ED03D5D-B20A-48FE-AD56-E76A06B1DC7C@xenosoft.de>
References: <20171202002710.17686.21340.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20171202191827.GB18780@bhelgaas-glaptop.roam.corp.google.com>
 <33CA1586-051C-47F4-83CD-4A406FAE85F7@xenosoft.de>
 <20180210154342.GE206223@bhelgaas-glaptop.roam.corp.google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail-075E060E-FAD4-432A-89CD-3BD6BFA7B823
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

Sorry for my late answer. The X1000 boots and works since yesterday. I think=
 the following patch solved the issue: https://git.kernel.org/pub/scm/linux/=
kernel/git/torvalds/linux.git/commit/?id=3Dc591c2e36ccc9a08f265841d2fd68e353=
27ab3c4

Cheers,
Christian

Sent from my iPhone

> On 10. Feb 2018, at 16:43, Bjorn Helgaas <helgaas@kernel.org> wrote:
>=20
>> On Sat, Feb 10, 2018 at 09:05:40AM +0100, Christian Zigotzky wrote:
>> Hi All,
>>=20
>> The AmigaOne X1000 doesn=E2=80=99t boot anymore since the PCI updates. I
>> have seen, that the PCI updates are different to the updates below.
>> The code below works but the latest not. Is there a problem with the
>> latest PCI updates currently?
>=20
> I'm not aware of a problem, and it *looks* like the patch below is in
> Linus' tree (I'm looking at 9a61df9e5f74 ("Merge tag 'kbuild-v4.16-2'
> of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild"))=
.
>=20
> I assume you're still booting with "pci=3Dpcie_scan_all", since I don't
> think we ever got a quirk to set PCI_SCAN_ALL_PCIE_DEVS automatically.
>=20
> If AmigaOne X1000 doesn't boot with "pci=3Dpcie_scan_all", can you diff
> the working only_one_child() with the current upstream?  I compared
> the version in my pci/enumeration branch with what's upstream, and
> they're identical.  So maybe the original patch I applied was wrong?
>=20
> If you have a patch that works, can you post it and maybe I can sort
> out what's different?
>=20
>> On 2. Dec 2017, at 20:18, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>=20
>> On Fri, Dec 01, 2017 at 06:27:10PM -0600, Bjorn Helgaas wrote:
>> From: Bjorn Helgaas <bhelgaas@google.com>
>>=20
>> PCIe Downstream Ports normally have only a Device 0 below them.  To
>> optimize enumeration, we don't scan for other devices *unless* the
>> PCI_SCAN_ALL_PCIE_DEVS flag is set by set by quirks or the
>> "pci=3Dpcie_scan_all" kernel parameter.
>>=20
>> Previously PCI_SCAN_ALL_PCIE_DEVS only affected scanning below Switch
>> Downstream Ports, not Root Ports.
>>=20
>> But the "Nemo" system, also known as the AmigaOne X1000, has a PA Semi Ro=
ot
>> Port whose link leads to an AMD/ATI SB600 South Bridge.  The Root Port is=
 a
>> PCIe device, of course, but the SB600 contains only conventional PCI
>> devices with no visible PCIe port.
>>=20
>> Simplify and restructure only_one_child() so that we scan for all possibl=
e
>> devices below Root Ports as well as Switch Downstream Ports when
>> PCI_SCAN_ALL_PCIE_DEVS is set.
>>=20
>> This is enough to make Nemo work with "pci=3Dpcie_scan_all".  We would al=
so
>> like to add a quirk to set PCI_SCAN_ALL_PCIE_DEVS automatically on Nemo s=
o
>> users wouldn't have to use the "pci=3Dpcie_scan_all" parameter, but we do=
n't
>> have that yet.
>>=20
>> Link: https://lkml.kernel.org/r/CAErSpo55Q8Q=3D5p6_+uu7ahnw+53ibVDNRXxrzR=
V9QnUr_9EUfw@mail.gmail.com
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D198057
>> Reported-and-Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>=20
>> Applied to pci/enumeration for v4.16.
>>=20
>> ---
>> drivers/pci/probe.c |   25 +++++++++++++++----------
>> 1 file changed, 15 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 14e0ea1ff38b..303c0cb0550c 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -2215,22 +2215,27 @@ static unsigned next_fn(struct pci_bus *bus, stru=
ct pci_dev *dev, unsigned fn)
>>=20
>> static int only_one_child(struct pci_bus *bus)
>> {
>> -    struct pci_dev *parent =3D bus->self;
>> +    struct pci_dev *bridge =3D bus->self;
>>=20
>> -    if (!parent || !pci_is_pcie(parent))
>> +    /*
>> +     * Systems with unusual topologies set PCI_SCAN_ALL_PCIE_DEVS so
>> +     * we scan for all possible devices, not just Device 0.
>> +     */
>> +    if (pci_has_flag(PCI_SCAN_ALL_PCIE_DEVS))
>>       return 0;
>> -    if (pci_pcie_type(parent) =3D=3D PCI_EXP_TYPE_ROOT_PORT)
>> -        return 1;
>>=20
>>   /*
>> -     * PCIe downstream ports are bridges that normally lead to only a
>> -     * device 0, but if PCI_SCAN_ALL_PCIE_DEVS is set, scan all
>> -     * possible devices, not just device 0.  See PCIe spec r3.0,
>> -     * sec 7.3.1.
>> +     * A PCIe Downstream Port normally leads to a Link with only Device
>> +     * 0 on it (PCIe spec r3.1, sec 7.3.1).  As an optimization, scan
>> +     * only for Device 0 in that situation.
>> +     *
>> +     * Checking has_secondary_link is a hack to identify Downstream
>> +     * Ports because sometimes Switches are configured such that the
>> +     * PCIe Port Type labels are backwards.
>>    */
>> -    if (parent->has_secondary_link &&
>> -        !pci_has_flag(PCI_SCAN_ALL_PCIE_DEVS))
>> +    if (bridge && pci_is_pcie(bridge) && bridge->has_secondary_link)
>>       return 1;
>> +
>>   return 0;
>> }
>>=20

--Apple-Mail-075E060E-FAD4-432A-89CD-3BD6BFA7B823
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto">Hi Bjorn,<div><br></div><div>Sorry for my l=
ate answer. The X1000 boots and works since yesterday.&nbsp;<span style=3D"b=
ackground-color: rgba(255, 255, 255, 0);">I think the following patch solved=
 the issue:&nbsp;<a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/=
torvalds/linux.git/commit/?id=3Dc591c2e36ccc9a08f265841d2fd68e35327ab3c4">ht=
tps://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3D=
c591c2e36ccc9a08f265841d2fd68e35327ab3c4</a></span></div><div><br></div><div=
>Cheers,</div><div>Christian<br><br><div id=3D"AppleMailSignature">Sent from=
 my iPhone</div><div><br>On 10. Feb 2018, at 16:43, Bjorn Helgaas &lt;<a hre=
f=3D"mailto:helgaas@kernel.org">helgaas@kernel.org</a>&gt; wrote:<br><br></d=
iv><blockquote type=3D"cite"><div><span>On Sat, Feb 10, 2018 at 09:05:40AM +=
0100, Christian Zigotzky wrote:</span><br><blockquote type=3D"cite"><span>Hi=
 All,</span><br></blockquote><blockquote type=3D"cite"><span></span><br></bl=
ockquote><blockquote type=3D"cite"><span>The AmigaOne X1000 doesn=E2=80=99t b=
oot anymore since the PCI updates. I</span><br></blockquote><blockquote type=
=3D"cite"><span>have seen, that the PCI updates are different to the updates=
 below.</span><br></blockquote><blockquote type=3D"cite"><span>The code belo=
w works but the latest not. Is there a problem with the</span><br></blockquo=
te><blockquote type=3D"cite"><span>latest PCI updates currently?</span><br><=
/blockquote><span></span><br><span>I'm not aware of a problem, and it *looks=
* like the patch below is in</span><br><span>Linus' tree (I'm looking at 9a6=
1df9e5f74 ("Merge tag 'kbuild-v4.16-2'</span><br><span>of git://git.kernel.o=
rg/pub/scm/linux/kernel/git/masahiroy/linux-kbuild")).</span><br><span></spa=
n><br><span>I assume you're still booting with "pci=3Dpcie_scan_all", since I=
 don't</span><br><span>think we ever got a quirk to set PCI_SCAN_ALL_PCIE_DE=
VS automatically.</span><br><span></span><br><span>If AmigaOne X1000 doesn't=
 boot with "pci=3Dpcie_scan_all", can you diff</span><br><span>the working o=
nly_one_child() with the current upstream? &nbsp;I compared</span><br><span>=
the version in my pci/enumeration branch with what's upstream, and</span><br=
><span>they're identical. &nbsp;So maybe the original patch I applied was wr=
ong?</span><br><span></span><br><span>If you have a patch that works, can yo=
u post it and maybe I can sort</span><br><span>out what's different?</span><=
br><span></span><br><blockquote type=3D"cite"><span>On 2. Dec 2017, at 20:18=
, Bjorn Helgaas &lt;<a href=3D"mailto:helgaas@kernel.org">helgaas@kernel.org=
</a>&gt; wrote:</span><br></blockquote><blockquote type=3D"cite"><span></spa=
n><br></blockquote><blockquote type=3D"cite"><span>On Fri, Dec 01, 2017 at 0=
6:27:10PM -0600, Bjorn Helgaas wrote:</span><br></blockquote><blockquote typ=
e=3D"cite"><span>From: Bjorn Helgaas &lt;<a href=3D"mailto:bhelgaas@google.c=
om">bhelgaas@google.com</a>&gt;</span><br></blockquote><blockquote type=3D"c=
ite"><span></span><br></blockquote><blockquote type=3D"cite"><span>PCIe Down=
stream Ports normally have only a Device 0 below them. &nbsp;To</span><br></=
blockquote><blockquote type=3D"cite"><span>optimize enumeration, we don't sc=
an for other devices *unless* the</span><br></blockquote><blockquote type=3D=
"cite"><span>PCI_SCAN_ALL_PCIE_DEVS flag is set by set by quirks or the</spa=
n><br></blockquote><blockquote type=3D"cite"><span>"pci=3Dpcie_scan_all" ker=
nel parameter.</span><br></blockquote><blockquote type=3D"cite"><span></span=
><br></blockquote><blockquote type=3D"cite"><span>Previously PCI_SCAN_ALL_PC=
IE_DEVS only affected scanning below Switch</span><br></blockquote><blockquo=
te type=3D"cite"><span>Downstream Ports, not Root Ports.</span><br></blockqu=
ote><blockquote type=3D"cite"><span></span><br></blockquote><blockquote type=
=3D"cite"><span>But the "Nemo" system, also known as the AmigaOne X1000, has=
 a PA Semi Root</span><br></blockquote><blockquote type=3D"cite"><span>Port w=
hose link leads to an AMD/ATI SB600 South Bridge. &nbsp;The Root Port is a</=
span><br></blockquote><blockquote type=3D"cite"><span>PCIe device, of course=
, but the SB600 contains only conventional PCI</span><br></blockquote><block=
quote type=3D"cite"><span>devices with no visible PCIe port.</span><br></blo=
ckquote><blockquote type=3D"cite"><span></span><br></blockquote><blockquote t=
ype=3D"cite"><span>Simplify and restructure only_one_child() so that we scan=
 for all possible</span><br></blockquote><blockquote type=3D"cite"><span>dev=
ices below Root Ports as well as Switch Downstream Ports when</span><br></bl=
ockquote><blockquote type=3D"cite"><span>PCI_SCAN_ALL_PCIE_DEVS is set.</spa=
n><br></blockquote><blockquote type=3D"cite"><span></span><br></blockquote><=
blockquote type=3D"cite"><span>This is enough to make Nemo work with "pci=3D=
pcie_scan_all". &nbsp;We would also</span><br></blockquote><blockquote type=3D=
"cite"><span>like to add a quirk to set PCI_SCAN_ALL_PCIE_DEVS automatically=
 on Nemo so</span><br></blockquote><blockquote type=3D"cite"><span>users wou=
ldn't have to use the "pci=3Dpcie_scan_all" parameter, but we don't</span><b=
r></blockquote><blockquote type=3D"cite"><span>have that yet.</span><br></bl=
ockquote><blockquote type=3D"cite"><span></span><br></blockquote><blockquote=
 type=3D"cite"><span>Link: <a href=3D"https://lkml.kernel.org/r/CAErSpo55Q8Q=
=3D5p6_+uu7ahnw+53ibVDNRXxrzRV9QnUr_9EUfw@mail.gmail.com">https://lkml.kerne=
l.org/r/CAErSpo55Q8Q=3D5p6_+uu7ahnw+53ibVDNRXxrzRV9QnUr_9EUfw@mail.gmail.com=
</a></span><br></blockquote><blockquote type=3D"cite"><span>Link: <a href=3D=
"https://bugzilla.kernel.org/show_bug.cgi?id=3D198057">https://bugzilla.kern=
el.org/show_bug.cgi?id=3D198057</a></span><br></blockquote><blockquote type=3D=
"cite"><span>Reported-and-Tested-by: Christian Zigotzky &lt;<a href=3D"mailt=
o:chzigotzky@xenosoft.de">chzigotzky@xenosoft.de</a>&gt;</span><br></blockqu=
ote><blockquote type=3D"cite"><span>Signed-off-by: Bjorn Helgaas &lt;<a href=
=3D"mailto:bhelgaas@google.com">bhelgaas@google.com</a>&gt;</span><br></bloc=
kquote><blockquote type=3D"cite"><span></span><br></blockquote><blockquote t=
ype=3D"cite"><span>Applied to pci/enumeration for v4.16.</span><br></blockqu=
ote><blockquote type=3D"cite"><span></span><br></blockquote><blockquote type=
=3D"cite"><span>---</span><br></blockquote><blockquote type=3D"cite"><span>d=
rivers/pci/probe.c | &nbsp;&nbsp;25 +++++++++++++++----------</span><br></bl=
ockquote><blockquote type=3D"cite"><span>1 file changed, 15 insertions(+), 1=
0 deletions(-)</span><br></blockquote><blockquote type=3D"cite"><span></span=
><br></blockquote><blockquote type=3D"cite"><span>diff --git a/drivers/pci/p=
robe.c b/drivers/pci/probe.c</span><br></blockquote><blockquote type=3D"cite=
"><span>index 14e0ea1ff38b..303c0cb0550c 100644</span><br></blockquote><bloc=
kquote type=3D"cite"><span>--- a/drivers/pci/probe.c</span><br></blockquote>=
<blockquote type=3D"cite"><span>+++ b/drivers/pci/probe.c</span><br></blockq=
uote><blockquote type=3D"cite"><span>@@ -2215,22 +2215,27 @@ static unsigned=
 next_fn(struct pci_bus *bus, struct pci_dev *dev, unsigned fn)</span><br></=
blockquote><blockquote type=3D"cite"><span></span><br></blockquote><blockquo=
te type=3D"cite"><span>static int only_one_child(struct pci_bus *bus)</span>=
<br></blockquote><blockquote type=3D"cite"><span>{</span><br></blockquote><b=
lockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;struct pci_dev *parent =3D=
 bus-&gt;self;</span><br></blockquote><blockquote type=3D"cite"><span>+ &nbs=
p;&nbsp;&nbsp;struct pci_dev *bridge =3D bus-&gt;self;</span><br></blockquot=
e><blockquote type=3D"cite"><span></span><br></blockquote><blockquote type=3D=
"cite"><span>- &nbsp;&nbsp;&nbsp;if (!parent || !pci_is_pcie(parent))</span>=
<br></blockquote><blockquote type=3D"cite"><span>+ &nbsp;&nbsp;&nbsp;/*</spa=
n><br></blockquote><blockquote type=3D"cite"><span>+ &nbsp;&nbsp;&nbsp;&nbsp=
;* Systems with unusual topologies set PCI_SCAN_ALL_PCIE_DEVS so</span><br><=
/blockquote><blockquote type=3D"cite"><span>+ &nbsp;&nbsp;&nbsp;&nbsp;* we s=
can for all possible devices, not just Device 0.</span><br></blockquote><blo=
ckquote type=3D"cite"><span>+ &nbsp;&nbsp;&nbsp;&nbsp;*/</span><br></blockqu=
ote><blockquote type=3D"cite"><span>+ &nbsp;&nbsp;&nbsp;if (pci_has_flag(PCI=
_SCAN_ALL_PCIE_DEVS))</span><br></blockquote><blockquote type=3D"cite"><span=
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 0;</span><br></blockquote><bloc=
kquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;if (pci_pcie_type(parent) =3D=
=3D PCI_EXP_TYPE_ROOT_PORT)</span><br></blockquote><blockquote type=3D"cite"=
><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 1;</span><br></blo=
ckquote><blockquote type=3D"cite"><span></span><br></blockquote><blockquote t=
ype=3D"cite"><span> &nbsp;&nbsp;/*</span><br></blockquote><blockquote type=3D=
"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;* PCIe downstream ports are bridges t=
hat normally lead to only a</span><br></blockquote><blockquote type=3D"cite"=
><span>- &nbsp;&nbsp;&nbsp;&nbsp;* device 0, but if PCI_SCAN_ALL_PCIE_DEVS i=
s set, scan all</span><br></blockquote><blockquote type=3D"cite"><span>- &nb=
sp;&nbsp;&nbsp;&nbsp;* possible devices, not just device 0. &nbsp;See PCIe s=
pec r3.0,</span><br></blockquote><blockquote type=3D"cite"><span>- &nbsp;&nb=
sp;&nbsp;&nbsp;* sec 7.3.1.</span><br></blockquote><blockquote type=3D"cite"=
><span>+ &nbsp;&nbsp;&nbsp;&nbsp;* A PCIe Downstream Port normally leads to a=
 Link with only Device</span><br></blockquote><blockquote type=3D"cite"><spa=
n>+ &nbsp;&nbsp;&nbsp;&nbsp;* 0 on it (PCIe spec r3.1, sec 7.3.1). &nbsp;As a=
n optimization, scan</span><br></blockquote><blockquote type=3D"cite"><span>=
+ &nbsp;&nbsp;&nbsp;&nbsp;* only for Device 0 in that situation.</span><br><=
/blockquote><blockquote type=3D"cite"><span>+ &nbsp;&nbsp;&nbsp;&nbsp;*</spa=
n><br></blockquote><blockquote type=3D"cite"><span>+ &nbsp;&nbsp;&nbsp;&nbsp=
;* Checking has_secondary_link is a hack to identify Downstream</span><br></=
blockquote><blockquote type=3D"cite"><span>+ &nbsp;&nbsp;&nbsp;&nbsp;* Ports=
 because sometimes Switches are configured such that the</span><br></blockqu=
ote><blockquote type=3D"cite"><span>+ &nbsp;&nbsp;&nbsp;&nbsp;* PCIe Port Ty=
pe labels are backwards.</span><br></blockquote><blockquote type=3D"cite"><s=
pan> &nbsp;&nbsp;&nbsp;*/</span><br></blockquote><blockquote type=3D"cite"><=
span>- &nbsp;&nbsp;&nbsp;if (parent-&gt;has_secondary_link &amp;&amp;</span>=
<br></blockquote><blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;!pci_has_flag(PCI_SCAN_ALL_PCIE_DEVS))</span><br></blockquo=
te><blockquote type=3D"cite"><span>+ &nbsp;&nbsp;&nbsp;if (bridge &amp;&amp;=
 pci_is_pcie(bridge) &amp;&amp; bridge-&gt;has_secondary_link)</span><br></b=
lockquote><blockquote type=3D"cite"><span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;return 1;</span><br></blockquote><blockquote type=3D"cite"><span>+</span>=
<br></blockquote><blockquote type=3D"cite"><span> &nbsp;&nbsp;return 0;</spa=
n><br></blockquote><blockquote type=3D"cite"><span>}</span><br></blockquote>=
<blockquote type=3D"cite"><span></span><br></blockquote></div></blockquote><=
/div></body></html>=

--Apple-Mail-075E060E-FAD4-432A-89CD-3BD6BFA7B823--
