Return-Path: <Hiroshi.DOYU@nokia.com>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.nokia.com",
	Issuer "VeriSign Class 3 International Server CA - G3" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 93445B717A
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Feb 2011 19:56:55 +1100 (EST)
Date: Mon, 14 Feb 2011 10:55:53 +0200 (EET)
Message-Id: <20110214.105553.296482686007701595.Hiroshi.DOYU@nokia.com>
To: linus.walleij@linaro.org
Subject: Re: [RFC] Inter-processor Mailboxes Drivers
From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
In-Reply-To: <AANLkTimnHHhYKnvUgsMo_jsKaYdY+XuABZ+FV0p25JLi@mail.gmail.com>
References: <AANLkTikoExk30pqdcHXCA2K_oJB=VJ5_AnCkoYUrEt3X@mail.gmail.com>
	<20110214.093257.58795266617213863.Hiroshi.DOYU@nokia.com>
	<AANLkTimnHHhYKnvUgsMo_jsKaYdY+XuABZ+FV0p25JLi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: meador_inge@mentor.com, Hollis_Blanchard@mentor.com, sunder.svit@gmail.com,
	openmcapi-dev@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: ext Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC] Inter-processor Mailboxes Drivers
Date: Mon, 14 Feb 2011 09:39:32 +0100

> On Mon, Feb 14, 2011 at 8:32 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> 
>> OMAP mailbox is the interrupt driven 32bit unit H/W FIFO to other
>> cores.
> 
> How is it used? Is it a low-traffic (like single 32bit words etc) signal
> control-path link while the actual high-throughput data-path is done
> with shared memory? (That is how the db5500 mbox works anyways.)

Yes, maybe quite similar.

maibox is not single 32 bit but is 32 bit x 4(or 8?) slots fifo, IIRC,
and mainly it is used as notification between cores. And big amount of
data is transftered with sahred memory, which has been mapped onto the
virtual address space of the other side of core, in advance.

For example, typical usage of DSP, mp3 decoding,

1, ARM maps 2 shared memory area(input/output) onto DSP virtual
   address space.
2, ARM fills mp3 data in input buffer.
3, ARM notifies DSP that data is ready in input buffer.
4, DSP decodes input data and put output data on output buffer.
5, DSP notifies that output buffer is ready.

Roughly something like the above. DSP S/W is multi-tasking, though.

Does db5500 use IOMMU for mapping shared memories?
