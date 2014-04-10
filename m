Return-Path: <robherring2@gmail.com>
Received: from mail-ve0-f172.google.com (mail-ve0-f172.google.com
 [209.85.128.172])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 65A9B140097
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Apr 2014 01:06:32 +1000 (EST)
Received: by mail-ve0-f172.google.com with SMTP id jx11so3614378veb.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 08:06:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1397004291.32034.327.camel@snotra.buserror.net>
References: <1395754915-14534-1-git-send-email-valentin.longchamp@keymile.com>
 <1395754915-14534-3-git-send-email-valentin.longchamp@keymile.com>
 <1397004291.32034.327.camel@snotra.buserror.net>
Date: Thu, 10 Apr 2014 10:06:29 -0500
Message-ID: <CAL_JsqLLD4fAuhDzdQPWNSbWj444kWESvsprMBFmStUF-QNTiQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] devcietree: bindings: add some MFD Keymile FPGAs
From: Rob Herring <robherring2@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Valentin Longchamp <valentin.longchamp@keymile.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 8, 2014 at 7:44 PM, Scott Wood <scottwood@freescale.com> wrote:
> On Tue, 2014-03-25 at 14:41 +0100, Valentin Longchamp wrote:
>> These are the bindings for 2 MFD devices used on some of the Keymile boards.
>> The first one is the chassis managmenet bfticu FPGA.
>> The second one is the board controller (reset, LEDs, GPIOs) QRIO CPDL.
>> These FPGAs are used in the kmcoge4 board.
>>
>> This patch also add KEYMILE to the vendor-prefixes.

You can drop the keymile addition. I have that queued up.

[snip]

>> +Required properties:
>> +- compatible: "keymile,bfticu"
>> +- interrupt-controller: the bfticu FPGA is an interrupt controller
>> +- interrupts: the main IRQ line to signal the collected IRQs
>> +- #interrupt-cells : is 2
>> +     - The 1st cell is the local IRQ number on the bfticu
>> +     - The 2nd cell is the type of the IRQ (IRQ_TYPE_xxx)
>
> Device tree bindings should not depend on the content of Linux headers.
> One is stable ABI, and the other isn't.
>
> If you want you can make the values the same for convenience, as is done
> by IPIC, CPM PIC, etc -- but the values need to be explicitly stated in
> the binding.  It'll still break if the Linux values change (so it may
> not be a good idea to try to keep the values the same), but at least the
> fix would be in Linux code rather than an ABI change.

You can simply refer to
Documentation/devicetree/bindings/interrupt-controller/interrupts.txt.

Rob
