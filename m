Return-Path: <ranshalit@gmail.com>
Received: from mail-ig0-x22a.google.com (mail-ig0-x22a.google.com
 [IPv6:2607:f8b0:4001:c05::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 03A9B1A0997
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 08:14:55 +1100 (AEDT)
Received: by igbni9 with SMTP id ni9so45936556igb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 14:14:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1444618435.7194.2.camel@ellerman.id.au>
References: <CAJ2oMhLMi2PZvQoFU7JuYSsJM_UbuTsOaRfQKxqsJQq=KDG9vQ@mail.gmail.com>
 <1444618435.7194.2.camel@ellerman.id.au>
Date: Tue, 13 Oct 2015 00:14:52 +0300
Message-ID: <CAJ2oMhJeo=T3r_rG-dBATxZiC36XBnzxoiD+fnLu37QpoGmcpg@mail.gmail.com>
Subject: Re: use interrupt without clearing ?
From: Ran Shalit <ranshalit@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 12, 2015 at 5:53 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Sun, 2015-10-11 at 15:13 +0300, Ran Shalit wrote:
>> Hello,
>>
>> Is it possible to register an interrupt (in linux), without using the
>> automatic clear of interrupt.
>> I need this just for testing.
>
> Hi Ran,
>
> You need to give us much more info than that before anyone will be able to
> answer your question. Linux runs on lots of different powerpc machines, so
> without knowing what hardware you're talking about it's impossible to
> answer.
>
> cheers
>
>

Hi,

The interrupt for external IRQ.
It is configured in device tree as following:


intc4@0{
compatible = "intc4";
 #address-cells = <1>;
 #size-cells = <0>;
 reg = <0 0x1000>;
 interrupts = <20 0x8> ;
 interrupt-parent = <&ipic>;
};

It works OK (with normal clearing of interrupt), but we need to
implement a testing requirement as following (startup BIT  testing):

1. an interrupt is given - and not being cleared automatically
2. need to validate that there is a pending interrupt
3. and then we can clear the interrupt and restore the mechnism to its
normal usage (automatic cleari of interrupt)

Regards,
Ran
