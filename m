Return-Path: <glikely@secretlab.ca>
Received: from mail-ie0-x22d.google.com (mail-ie0-x22d.google.com
 [IPv6:2607:f8b0:4001:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 70EB62C0205
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2013 01:30:23 +1000 (EST)
Received: by mail-ie0-f173.google.com with SMTP id k5so3427908iea.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2013 08:30:16 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20130418142434.GA18881@arm.com>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
 <1366107508-12672-3-git-send-email-Andrew.Murray@arm.com>
 <20130418134401.84AEE3E1319@localhost>
 <20130418142434.GA18881@arm.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 18 Apr 2013 16:29:54 +0100
Message-ID: <CACxGe6u7yoecyTR2r-EzpcRxLuSw-p9KC7jA12wEQZs4of3vFA@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] of/pci: Provide support for parsing PCI DT ranges
 property
To: Andrew Murray <andrew.murray@arm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "siva.kallam@samsung.com" <siva.kallam@samsung.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "thierry.reding@avionic-design.de" <thierry.reding@avionic-design.de>,
 Liviu Dudau <Liviu.Dudau@arm.com>, "paulus@samba.org" <paulus@samba.org>,
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
 "suren.reddy@samsung.com" <suren.reddy@samsung.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 18, 2013 at 3:24 PM, Andrew Murray <andrew.murray@arm.com> wrote:
> On Thu, Apr 18, 2013 at 02:44:01PM +0100, Grant Likely wrote:
>> On Tue, 16 Apr 2013 11:18:27 +0100, Andrew Murray <Andrew.Murray@arm.com> wrote:
>> >             /* Act based on address space type */
>> >             res = NULL;
>> > -           switch ((pci_space >> 24) & 0x3) {
>> > -           case 1:         /* PCI IO space */
>> > +           res_type = range.flags & IORESOURCE_TYPE_BITS;
>> > +           if (res_type == IORESOURCE_IO) {
>>
>> Why the change from switch() to an if/else if sequence?
>
> Russell King suggested this change - see
> https://patchwork.kernel.org/patch/2323941/

Umm, that isn't what that link shows. That link shows the patch
already changing to an if/else if construct, and rmk is commenting on
that.

g.
