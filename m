Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yr5QC2yh3zDrvJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Dec 2017 00:31:59 +1100 (AEDT)
Content-Type: multipart/alternative;
 boundary=Apple-Mail-5D467DE6-51B4-44F9-88F1-E7CE1EBB7423
Mime-Version: 1.0 (1.0)
Subject: SB600 for the Nemo board has non-zero devices on non-root bus
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <4b18f51024d.45f899c9@auth.smtp.1and1.co.uk>
Date: Mon, 4 Dec 2017 14:31:52 +0100
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-pci@vger.kernel.org,
 olof@lixom.net
Message-Id: <9AED1664-A71D-4C15-A828-E64DF5C0498C@xenosoft.de>
References: <f3513294-6da0-456f-0f98-1f8c3bac90c9@xenosoft.de>
 <87tvxl15qx.fsf@concordia.ellerman.id.au>
 <4cfe3cc0-7fe3-9774-7d20-1b7fcb7aa910@xenosoft.de>
 <CAErSpo55Q8Q=5p6_+uu7ahnw+53ibVDNRXxrzRV9QnUr_9EUfw@mail.gmail.com>
 <28b43e1a-3643-9edb-7123-be1cb0dc846a@xenosoft.de>
 <CAErSpo7fup7+doD6A7RKh8kdE8HQaQrEh=gq35+nC-dBeOQ1uA@mail.gmail.com>
 <527175f7-8a13-37a1-9f0a-0b918aeebd64@xenosoft.de>
 <20171130224243.GB19640@bhelgaas-glaptop.roam.corp.google.com>
 <4b18f51024d.45f899c9@auth.smtp.1and1.co.uk>
To: Darren Stevens <darren@stevens-zone.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail-5D467DE6-51B4-44F9-88F1-E7CE1EBB7423
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

Darren,

What do you think about Olof=E2=80=99s solution?

Link: http://forum.hyperion-entertainment.biz/viewtopic.php?f=3D35&t=3D3891&=
p=3D43206#p43201

Thanks,
Christian

Sent from my iPhone

> On 4. Dec 2017, at 12:40, Darren Stevens <darren@stevens-zone.net> wrote:
>=20
> Hello Bjorn
>=20
> Firstly sorry for not being able to join in this discussion, I have been
> moving house and only got my X1000 set up again yesterday..
>=20
>> On 30/11/2017, Bjorn Helgaas wrote:
>> I *think* something like the patch below should make this work if you
>> use the "pci=3Dpcie_scan_all" parameter.  We have some x86 DMI quirks
>> that set PCI_SCAN_ALL_PCIE_DEVS automatically.  I don't know how to do
>> something similar on powerpc, but maybe you do?
>=20
> Actually the root ports on the Nemo's PA6T processor don't respond to the
> SB600 unless we turn on a special 'relax pci-e' bit in one of its control
> registers. We use a small out of tree init routine to do this, and there
> would be the ideal place to put a call to
> pci_set_flag(PCI_SCAN_ALL_PCIE_DEVS).
>=20
> This patch fixes the last major hurdle to getting the X1000 fully supporte=
d in
> the linux kernel, so thanks very much for that.
>=20
> Regards
> Darren
>=20

--Apple-Mail-5D467DE6-51B4-44F9-88F1-E7CE1EBB7423
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto">Darren,<div><br></div><div>What do you thin=
k about Olof=E2=80=99s solution?</div><div><br></div><div>Link:&nbsp;<a href=
=3D"http://forum.hyperion-entertainment.biz/viewtopic.php?f=3D35&amp;t=3D389=
1&amp;p=3D43206#p43201">http://forum.hyperion-entertainment.biz/viewtopic.ph=
p?f=3D35&amp;t=3D3891&amp;p=3D43206#p43201</a></div><div><br></div><div>Than=
ks,</div><div>Christian<br><br><div id=3D"AppleMailSignature">Sent from my i=
Phone</div><div><br>On 4. Dec 2017, at 12:40, Darren Stevens &lt;<a href=3D"=
mailto:darren@stevens-zone.net">darren@stevens-zone.net</a>&gt; wrote:<br><b=
r></div><blockquote type=3D"cite"><div><span>Hello Bjorn</span><br><span></s=
pan><br><span>Firstly sorry for not being&nbsp;able to join in this discussi=
on, I have been</span><br><span>moving house and only got my X1000 set up ag=
ain yesterday..</span><br><span></span><br><span>On 30/11/2017, Bjorn Helgaa=
s wrote:</span><br><blockquote type=3D"cite"><span>I *think* something like t=
he patch below should make this work if you</span><br></blockquote><blockquo=
te type=3D"cite"><span>use the "pci=3Dpcie_scan_all" parameter. &nbsp;We hav=
e some x86 DMI quirks</span><br></blockquote><blockquote type=3D"cite"><span=
>that set PCI_SCAN_ALL_PCIE_DEVS automatically. &nbsp;I don't know how to do=
</span><br></blockquote><blockquote type=3D"cite"><span>something similar on=
 powerpc, but maybe you do?</span><br></blockquote><span></span><br><span>Ac=
tually the root ports on the Nemo's PA6T processor don't respond to the</spa=
n><br><span>SB600 unless we turn on a special 'relax pci-e' bit in one of it=
s control</span><br><span>registers. We use a small out of tree init routine=
 to do this, and there</span><br><span>would be the ideal place to put a cal=
l to</span><br><span>pci_set_flag(PCI_SCAN_ALL_PCIE_DEVS).</span><br><span><=
/span><br><span>This patch fixes the last major hurdle to getting the X1000 f=
ully supported in</span><br><span>the linux kernel, so thanks very much for t=
hat.</span><br><span></span><br><span>Regards</span><br><span>Darren</span><=
br><span></span><br></div></blockquote></div></body></html>=

--Apple-Mail-5D467DE6-51B4-44F9-88F1-E7CE1EBB7423--
