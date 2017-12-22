Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z34M72VwrzDsQM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 21:22:26 +1100 (AEDT)
Subject: [PATCH] SB600 for the Nemo board has non-zero devices on non-root bus
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Bjorn Helgaas <helgaas@kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Darren Stevens <darren@stevens-zone.net>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20171202230052.34y2ivxgpgr3osct@localhost>
 <CAOesGMhfMpt+xG1vhVHU+O5o4W5y2S5mZyn9tp+CPn9G6XrNVA@mail.gmail.com>
 <4CEE49CE-68F3-457F-B302-54BA8550F36A@xenosoft.de>
 <1d5276c3-1d29-114a-c868-6f022eee58e7@xenosoft.de>
 <99f78122-cd53-100f-4f58-be5bf7927d4e@xenosoft.de>
 <87fu8odnfk.fsf@concordia.ellerman.id.au>
 <20171206210637.GO23510@bhelgaas-glaptop.roam.corp.google.com>
 <877etxh1lf.fsf@concordia.ellerman.id.au>
 <f5fe03d3-87f8-2a2d-2d83-fbefcd489a77@xenosoft.de>
 <98c7e034-b523-a703-e637-957e2857ab32@xenosoft.de>
 <20171215202509.GZ30595@bhelgaas-glaptop.roam.corp.google.com>
 <6326d79e-405b-2ae8-5295-97bf11219b81@xenosoft.de>
 <af18fb51-a0bc-68e2-7594-5583e3090f98@xenosoft.de>
Message-ID: <37306c17-816c-23fe-d03b-fb8ee98c03b0@xenosoft.de>
Date: Fri, 22 Dec 2017 11:22:01 +0100
MIME-Version: 1.0
In-Reply-To: <af18fb51-a0bc-68e2-7594-5583e3090f98@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I mean: I haven't gotten an answer from Darren yet. Sorry because of my 
English. I am still learning.

-- Christian


On 22 December 2017 at 10:57AM, Christian Zigotzky wrote:
 > Hi Bjorn,
 >
 > Sorry I'm bothering you again. Is this small out of tree init routine 
in the Nemo patch? I haven't get an answer from Darren yet and I didn't 
found the small out of tree init routine in the Nemo patch. Please find 
attached the Nemo patch. Maybe you can find this small out of tree init 
routine.
 >
 > What do you think of this following code?
 >
 > if (sb600_bus == -1)
 > +       {
 > +               busp = pci_find_bus(0, 0);
 > +               pa_pxp_read_config(busp, PCI_DEVFN(17,0), 
PCI_SECONDARY_BUS, 1, &val);
 > +
 > +               sb600_bus = val;
 > +
 > +               printk(KERN_CRIT "NEMO SB600 on bus %d.\n",sb600_bus);
 > +       }
 >
 > Thanks,
 > Christian
 >
 >
 > On 04 December 2017 at 12:40PM, Darren Stevens wrote:
 > > Hello Bjorn
 > >
 > > Firstly sorry for not being able to join in this discussion, I have 
been
 > > moving house and only got my X1000 set up again yesterday..
 > >
 > > On 30/11/2017, Bjorn Helgaas wrote:
 > >> I *think* something like the patch below should make this work if you
 > >> use the "pci=pcie_scan_all" parameter.  We have some x86 DMI quirks
 > >> that set PCI_SCAN_ALL_PCIE_DEVS automatically.  I don't know how to do
 > >> something similar on powerpc, but maybe you do?
 > >
 > > Actually the root ports on the Nemo's PA6T processor don't respond 
to the
 > > SB600 unless we turn on a special 'relax pci-e' bit in one of its 
control
 > > registers. We use a small out of tree init routine to do this, and 
there
 > > would be the ideal place to put a call to
 > > pci_set_flag(PCI_SCAN_ALL_PCIE_DEVS).
 > >
 > > This patch fixes the last major hurdle to getting the X1000 fully 
supported in
 > > the linux kernel, so thanks very much for that.
 > >
 > > Regards
 > > Darren
 > >
 > >
 >
