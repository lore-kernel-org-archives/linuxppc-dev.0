Return-Path: <linus971@gmail.com>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zY52V6wmrzF0PY
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Feb 2018 05:23:14 +1100 (AEDT)
Received: by mail-it0-x243.google.com with SMTP id h129so8924155ita.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Feb 2018 10:23:14 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <87y3kbpkxy.fsf@concordia.ellerman.id.au>
References: <87y3kbpkxy.fsf@concordia.ellerman.id.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Feb 2018 10:23:11 -0800
Message-ID: <CA+55aFypU331cQy-6ZJ6szF=2KVLqcbwCUGd+gTwPViRqRWN+g@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-4.16-1 tag
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: aik@ozlabs.ru, Alan Modra <amodra@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 "Aneesh Kumar K. V" <aneesh.kumar@linux.vnet.ibm.com>, anju@linux.vnet.ibm.com,
 Anton Blanchard <anton@samba.org>, Arnd Bergmann <arnd@arndb.de>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, bhaktipriya96@gmail.com,
 Bjorn Helgaas <bhelgaas@google.com>, bryantly@linux.vnet.ibm.com,
 Balbir Singh <bsingharora@gmail.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 clombard@linux.vnet.ibm.com, Cyril Bur <cyrilbur@gmail.com>,
 Daniel Thompson <daniel.thompson@linaro.org>, david@gibson.dropbear.id.au,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, fbarrat@linux.vnet.ibm.com,
 Geert Uytterhoeven <geert+renesas@glider.be>, geoff@infradead.org,
 gomonovych@gmail.com,
 gpiccoli@linux.vnet.ibm.com, gromero@linux.vnet.ibm.com,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>, ivan@de.ibm.com,
 Jeremy Kerr <jk@ozlabs.org>,
 joakim.tjernlund@infinera.com, Joe Perches <joe@perches.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, jsperbeck@google.com, julia@ni.com,
 kamalesh@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com, leoyang.li@nxp.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Ram Pai <linuxram@us.ibm.com>, maddy@linux.vnet.ibm.com,
 mahesh@linux.vnet.ibm.com,
 Mathieu Malaterre <malat@debian.org>, mwb@linux.vnet.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com, Nick Piggin <npiggin@gmail.com>, oss@buserror.net,
 Paul Mackerras <paulus@ozlabs.org>, Rob Herring <robh@kernel.org>,
 ruscur@russell.cc,
 santosh@fossix.org, Andreas Schwab <schwab@linux-m68k.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>, sukadev@linux.vnet.ibm.com,
 Tejun Heo <tj@kernel.org>, wei.guo.simon@gmail.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hmm. This adds a

   static inline void pci_uevent_ers(struct pci_dev *pdev, ..

to include/linux/pci.h.

Why?

You do realize that that header file is included by almost every
driver out there. Why is that magical function *so* important that it
needs to be an inline function, and those strings etc duplicated in
every user?

Yes, that header file is already full of random inline functions, but
they are generally wrapper functions that don't really do anything,
and in many cases ithey are also basically configurable to really do
nothing at all so that the compiler can remove all trace of something
that isn't enabled.

This function, in contrast, is simply not that at all. I see literally
_zero_ reason why it should be an inline in a really core file.

It's not important.

It's not performance critical.

It's not even used by any core drivers.

I pulled this, but honestly, this part was *GARBAGE*. I'm used to
people always thinking that *their* code is so important that it needs
to be front and center, but this is just ridiculous shit.

Get it fixed.

                 Linus
