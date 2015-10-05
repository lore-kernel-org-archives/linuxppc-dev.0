Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-lb0-f178.google.com (mail-lb0-f178.google.com
 [209.85.217.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3EA861A0023
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Oct 2015 09:19:16 +1100 (AEDT)
Received: by lbbwt4 with SMTP id wt4so28414327lbb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2015 15:19:13 -0700 (PDT)
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH v3 1/3] powerpc/512x: add LocalPlus Bus FIFO device driver
References: <1443115737-3948-1-git-send-email-alex.popov@linux.com>
 <1443115737-3948-2-git-send-email-alex.popov@linux.com>
 <56049CD0.7080104@tabi.org> <560C5325.6070406@linux.com>
 <560D692E.1010309@tabi.org>
To: Timur Tabi <timur@tabi.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Anatolij Gustschin <agust@denx.de>, Rob Herring <robh@kernel.org>,
 Grant Likely <grant.likely@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>,
 Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Popov <alex.popov@linux.com>
From: Alexander Popov <alex.popov@linux.com>
Message-ID: <5612F832.9060407@linux.com>
Date: Tue, 6 Oct 2015 01:22:42 +0300
MIME-Version: 1.0
In-Reply-To: <560D692E.1010309@tabi.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01.10.2015 20:11, Timur Tabi wrote:
> On 09/30/2015 04:24 PM, Alexander Popov wrote:
>>> Driver code that has to parse #address-cells or #size-cells
>>> is usually wrong.
>>
>> I would not call it "parsing", I just check whether the dts-file is good.
>> Anyway, could you give me a clue how to do better?
> 
> You should use of_n_size_cells() and of_n_addr_cells().

It seems that of_n_size_cells() and of_n_addr_cells() don't work well in
my case. These functions just help to get "#address-cells" and "#size-cells"
from a parent node of a given node.

"sclpc" device tree node is a child of "soc" node (not "localbus" node),
but the driver must use "ranges" property of "localbus" to determine
the chip select number of a client device which ordered the DMA transfer.

It seems that ns2_leds_get_of_pdata() from linux/drivers/leds/leds-ns2.c
or pnv_init_idle_states() from arch/powerpc/platforms/powernv/idle.c do
something similar to get_cs_ranges().
Is it OK?

Best regards,
Alexander
