Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-la0-f53.google.com (mail-la0-f53.google.com
 [209.85.215.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 065721A05D7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 16:32:23 +1000 (AEST)
Received: by laer8 with SMTP id r8so55796398lae.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 23:32:20 -0700 (PDT)
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH v3 2/3] powerpc/512x: add a device tree binding for
 LocalPlus Bus FIFO
References: <1443115737-3948-1-git-send-email-alex.popov@linux.com>
 <1443115737-3948-3-git-send-email-alex.popov@linux.com>
 <560492C1.307@tabi.org> <56093F89.1020004@linux.com>
 <5609401F.3010603@tabi.org>
To: Timur Tabi <timur@tabi.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Anatolij Gustschin <agust@denx.de>, Gerhard Sittig <gsi@denx.de>,
 Rob Herring <robh@kernel.org>, Grant Likely <grant.likely@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>,
 Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Popov <alex.popov@linux.com>
From: Alexander Popov <alex.popov@linux.com>
Message-ID: <560A3141.6090705@linux.com>
Date: Tue, 29 Sep 2015 09:35:45 +0300
MIME-Version: 1.0
In-Reply-To: <5609401F.3010603@tabi.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28.09.2015 16:26, Timur Tabi wrote:
> Alexander Popov wrote:
>> I've just followed devicetree/bindings/dma/dma.txt...
>> This "rx-tx" doesn't mean much but it could show that LocalPlus Bus FIFO
>> uses a single DMA read-write channel. Should I really drop it?
> 
> Hmmm, I'm not sure.  Is there anything else (besides your driver) that
> parses this device tree node?

No, mpc512x_lpbfifo.c is the only piece of code which is going to use this
device tree node.

> dma.txt says this:
> 
>     "The specific strings that can be used are defined in the binding of the
> DMA client device."
> 
> So this looks like it's driver-specific,

Yes.
MPC512x LocalPlus Bus FIFO uses the channel #26 of the DMA controller
both for reading and writing, and other DMA clients use other specific
DMA channels. This channel assignment is fixed in hardware and described
in the Reference Manual.

> but it is a required property.
> I guess you should keep it, but I think you should get a second opinion.

Ok, thanks.

Best regards,
Alexander
