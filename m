Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-ua0-x22b.google.com (mail-ua0-x22b.google.com
 [IPv6:2607:f8b0:400c:c08::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdTYS5Ll9zF0hX
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 09:01:48 +1100 (AEDT)
Received: by mail-ua0-x22b.google.com with SMTP id x4so6079501uaj.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Feb 2018 14:01:48 -0800 (PST)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 9 Feb 2018 23:01:25 +0100
Message-ID: <CA+7wUszna8NoXLvpjJM7piveywBux33qFgA-mkV_yteACHsunw@mail.gmail.com>
Subject: powerpc/pci: Use of_irq_parse_and_map_pci() helper
To: Rob Herring <robh@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Rob,

I can no longer boot my old Mac Mini G4 using a custom config. After a
tedious bisect it appears that (*). Since Mac Mini does not provide
any serial port I cannot provide a kernel message dump (wish there was
some kind of null modem serial cable). All I can see is some crazy
stuff going on with ATA DMA/66 & DMA/100.

Is there anything suspicious in this commit which may prevent this
machine to boot ?

Thanks much,

(*)
$ git bisect good
59f47eff03a08cd2d91310f1c15a5343fa0071e5 is the first bad commit
commit 59f47eff03a08cd2d91310f1c15a5343fa0071e5
Author: Rob Herring <robh@kernel.org>
Date:   Thu Jan 4 15:12:14 2018 -0600

    powerpc/pci: Use of_irq_parse_and_map_pci() helper

    Instead of calling both of_irq_parse_pci() and irq_create_of_mapping(),
    call of_irq_parse_and_map_pci(), which does the same thing. This will allow
    making of_irq_parse_pci() a private, static function.

    This changes the logic slightly in that the fallback path will also be
    taken if irq_create_of_mapping() fails internally.

    Signed-off-by: Rob Herring <robh@kernel.org>
    [bhelgaas: fold in virq init from Stephen Rothwell <sfr@canb.auug.org.au>]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Cc: Paul Mackerras <paulus@samba.org>
    Cc: Michael Ellerman <mpe@ellerman.id.au>

:040000 040000 b979406deb8957af240d659be1e76ed75fa43288
ec3c127fe30428955e2ad1d716c9be2adbd2623d M arch
