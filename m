Return-Path: <leon.woestenberg@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id A4B01DDE19
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 08:05:03 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so341390ywh.39
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2008 15:05:01 -0700 (PDT)
Message-ID: <c384c5ea0809291505p5a12f5aerd48515cb5c305155@mail.gmail.com>
Date: Tue, 30 Sep 2008 00:05:01 +0200
From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
To: "=?ISO-8859-1?Q?Andr=E9_Schwarz?=" <Andre.Schwarz@matrix-vision.de>,
	linuxppc-dev@ozlabs.org
Subject: Re: How to prevent embedded ppc reset deadlock? (MPC83xx/85xx)
In-Reply-To: <48E14DAE.9040101@matrix-vision.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c384c5ea0809291433j10619a49xe713415f6bb90204@mail.gmail.com>
	<48E14DAE.9040101@matrix-vision.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Andr=E9,

On Mon, Sep 29, 2008 at 11:50 PM, Andr=E9 Schwarz
<Andre.Schwarz@matrix-vision.de> wrote:
> Leon,
>
> you're right.
> PORESET is just there to prevent the core from running as long as power m=
ay
> be unstable and/or PLLs are out of lock.
> HRESET is the signal that should reset everything. I did it on my board a=
nd
> it works fine.
>
Understood so far.

> Since you also have to assert HRESET when you assert PORESET
>
But when I assert PORESET, the processor will assert HRESET itself
AFAIK, so why do this?

> you can wire-or them with a low drop schottky diode.
>
Ooh, analog electronics, long time ago. Let me think: arrow of diode
symbol pointing from HRESET# to PORESET#, right, so that PORESET#
going low will pull HRESET# low enough, right?

> Hope this helps.
>
Yes it does, thanks.

Regards, Leon.


> Leon Woestenberg wrote:
>>
>> Hello all,
>>
>> not Linux related per se*, but I wonder how your board designs deal
>> with the reset circuitry for embedded PowerPC processors (MPC8313E in
>> my case).
>> My requirement is that both a processor-external hard reset and
>> processor-internal hard reset must both reset the boot device NOR
>> FlashROM, so that it does not remain in write mode (if it is).
>>
>> Given those processor pins:
>>
>> PORESET# (input pin to the processor, power on reset)
>> HRESET# (bidirectional pin on the processor, asserted by processor on
>> hard reset such as watchdog)
>>
>> I see many designs (even the Freescale reference designs) where the
>> HRESET# resets some of the board, but not the FlashROM, and where
>> PORESET# resets the FlashROM. This can cause a deadlock in the case
>> where the watchdog resets during writing to FlashROM, as the FlashROM
>> is not reset and remains in write mode, not allowing the processor to
>> boot from it.
>>
>> I am thinking of using this approach: PORESET# -> processor <-->
>> HRESET# -> board reset.
>>
>> Would that work? or why not?
>>
>> Regards,
>>
>
>
> MATRIX VISION GmbH, Talstra=DFe 16, DE-71570 Oppenweiler  - Registergeric=
ht:
> Amtsgericht Stuttgart, HRB 271090
> Gesch=E4ftsf=FChrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
>



--=20
Leon
