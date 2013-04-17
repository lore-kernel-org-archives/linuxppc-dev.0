Return-Path: <glikely@secretlab.ca>
Received: from mail-ie0-x236.google.com (mail-ie0-x236.google.com
 [IPv6:2607:f8b0:4001:c03::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1FB222C0170
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2013 02:18:12 +1000 (EST)
Received: by mail-ie0-f182.google.com with SMTP id at1so2133526iec.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2013 09:18:09 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20130417161036.GB27197@titan.lakedaemon.net>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
 <1366107508-12672-2-git-send-email-Andrew.Murray@arm.com>
 <20130416103005.GB12726@arm.com>
 <20130417160015.777453E2B73@localhost>
 <20130417161036.GB27197@titan.lakedaemon.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 17 Apr 2013 17:17:48 +0100
Message-ID: <CACxGe6sNk=wNinTcMHbJa5o-56Tyh=0CnFSEW+Hk-ujpjeg2gQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] of/pci: Unify pci_process_bridge_OF_ranges from
 Microblaze and PowerPC
To: Jason Cooper <jason@lakedaemon.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "siva.kallam@samsung.com" <siva.kallam@samsung.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "thierry.reding@avionic-design.de" <thierry.reding@avionic-design.de>,
 Liviu Dudau <Liviu.Dudau@arm.com>,
 Gregory CLEMENT <gregory.clement@free-electrons.com>,
 "paulus@samba.org" <paulus@samba.org>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 "jg1.han@samsung.com" <jg1.han@samsung.com>,
 "jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>,
 "thomas.abraham@linaro.org" <thomas.abraham@linaro.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "kgene.kim@samsung.com" <kgene.kim@samsung.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "thomas.petazzoni@free-electrons.com" <thomas.petazzoni@free-electrons.com>,
 "monstr@monstr.eu" <monstr@monstr.eu>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 "suren.reddy@samsung.com" <suren.reddy@samsung.com>,
 Olof Johansson <olof@lixom.net>, Andrew Murray <andrew.murray@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 17, 2013 at 5:10 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> On Wed, Apr 17, 2013 at 05:00:15PM +0100, Grant Likely wrote:
>> On Tue, 16 Apr 2013 11:30:06 +0100, Andrew Murray <andrew.murray@arm.com> wrote:
>> > On Tue, Apr 16, 2013 at 11:18:26AM +0100, Andrew Murray wrote:
>> > > The pci_process_bridge_OF_ranges function, used to parse the "ranges"
>> > > property of a PCI host device, is found in both Microblaze and PowerPC
>> > > architectures. These implementations are nearly identical. This patch
>> > > moves this common code to a common place.
>> > >
>> > > Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
>> > > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
>> > > Reviewed-by: Rob Herring <rob.herring@calxeda.com>
>> > > Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> > > Tested-by: Linus Walleij <linus.walleij@linaro.org>
>> > > Acked-by: Michal Simek <monstr@monstr.eu>
>> > > ---
>> > >  arch/microblaze/include/asm/pci-bridge.h |    5 +-
>> > >  arch/microblaze/pci/pci-common.c         |  192 ----------------------------
>> > >  arch/powerpc/include/asm/pci-bridge.h    |    5 +-
>> > >  arch/powerpc/kernel/pci-common.c         |  192 ----------------------------
>> >
>> > Is there anyone on linuxppc-dev/linux-mips that can help test this patchset?
>> >
>> > I've tested that it builds on powerpc with a variety of configs (some which
>> > include fsl_pci.c implementation). Though I don't have hardware to verify that
>> > it works.
>> >
>> > I haven't tested this builds or runs on MIPS.
>> >
>> > You shouldn't see any difference in behaviour or new warnings and PCI devices
>> > should continue to operate as before.
>>
>> I've got through a line-by-line comparison between powerpc, microblaze,
>> and then new code. The differences are purely cosmetic, so I have
>> absolutely no concerns about this patch. I've applied it to my tree.
>
> oops.  Due to the number of dependencies the mvebu-pcie series has (this
> being one of them, we (arm-soc/mvebu) asked if we could take this
> through our tree.  Rob Herring agreed to this several days ago.  Is this
> a problem for you?
>
> It would truly (dogs and cats living together) upset the apple cart for
> us at this stage to pipe these through a different tree...

Not a problem at all. I'll drop it.

g.
