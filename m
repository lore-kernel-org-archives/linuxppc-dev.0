Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r5h4K4yMlzDq72
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 May 2016 17:16:49 +1000 (AEST)
Received: by mail-io0-x241.google.com with SMTP id k129so13555833iof.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 May 2016 00:16:49 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <CAL_JsqJGpV-+JYyA1g0dw_nEduhmrMEouTH03kHtuCkGSOP57Q@mail.gmail.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-46-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_JsqJGpV-+JYyA1g0dw_nEduhmrMEouTH03kHtuCkGSOP57Q@mail.gmail.com>
Date: Fri, 13 May 2016 09:16:47 +0200
Message-ID: <CAMuHMdUnsDhTS5-C6_SvrqGb6hVTBZOz00=HBGhtqAQbwYv6hg@mail.gmail.com>
Subject: Re: [PATCH v7 45/50] drivers/of: Avoid recursively calling
 unflatten_dt_node()
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Rob Herring <robherring2@gmail.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, aik@ozlabs.ru,
 Bjorn Helgaas <bhelgaas@google.com>, Grant Likely <grant.likely@linaro.org>,
 Pantelis Antoniou <panto@antoniou-consulting.com>,
 Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 4, 2015 at 5:07 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Wed, Nov 4, 2015 at 7:12 AM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
>> In current implementation, unflatten_dt_node() is called recursively
>> to unflatten device nodes in FDT blob. It's stress to limited stack
>> capacity.
>
> Did you actually hit a problem?
>
> Now we have a max depth of 64. Seems like that should be plenty... Any
> idea how this compares to when we run out of stack space?

FWIW, on arm64:

drivers/of/fdt.c:443:1: warning: the frame size of 1136 bytes is
larger than 1024 bytes [-Wframe-larger-than=]

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
