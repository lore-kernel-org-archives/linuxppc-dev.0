Return-Path: <paul.gortmaker@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
 [209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 5802DB6F64
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2011 12:42:17 +1100 (EST)
Received: by bkcjk13 with SMTP id jk13so914821bkc.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Dec 2011 17:42:13 -0800 (PST)
MIME-Version: 1.0
Sender: paul.gortmaker@gmail.com
In-Reply-To: <20111202005752.10ce5eea@bob.linux.org.uk>
References: <1322783258-20443-1-git-send-email-paul.gortmaker@windriver.com>
 <1322783258-20443-4-git-send-email-paul.gortmaker@windriver.com>
 <20111202005752.10ce5eea@bob.linux.org.uk>
Date: Thu, 1 Dec 2011 20:42:13 -0500
Message-ID: <CAP=VYLqG_+-vksaVLO5kPbj6qRUKK9z6AcEQOFnCgoPGrO2crg@mail.gmail.com>
Subject: Re: [PATCH 3/3] 8250: add workaround for MPC8[356]xx UART break IRQ
 storm
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Alan Cox <alan@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 1, 2011 at 7:57 PM, Alan Cox <alan@linux.intel.com> wrote:
>
>> @@ -1553,7 +1554,15 @@ static void serial8250_handle_port(struct
>> uart_8250_port *up)
>> =A0 =A0 =A0 spin_lock_irqsave(&up->port.lock, flags);
>>
>> - =A0 =A0 status =3D serial_inp(up, UART_LSR);
>> + =A0 =A0 /* Workaround for IRQ storm errata on break with Freescale
>> 16550 */
>> + =A0 =A0 if (UART_BUG_FSLBK & up->port.bugs && up->lsr_last &
>> UART_LSR_BI) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->lsr_last &=3D ~UART_LSR_BI;
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_inp(up, UART_RX);
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&up->port.lock, flags);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 status =3D up->lsr_last =3D serial_inp(up, UART_LSR);
>
> We've now had a recent pile of IRQ function changes adding more quirk
> bits and special casing. This doesn't scale. We either need to make
> handle_port a method the specific drivers can override or you could
> hide the mess in your serial_inp implementation and not touch any core
> code.

To be fair, this one is zero cost for !PPC, but I understand your point,
and the idea of hiding it somehow in serial_inp was something that
never crossed my mind.  I'll look into seeing if I can abuse that.

>
> I really don't mind which but I suspect dealing with it in your
> serial_inp handler so that when you read UART_LSR you do the fixup
> might be simplest providing you can just do that.
>
> Sorting out a ->handle_port override is probably ultimately the right
> thing to do and then we can push some of the other funnies out further.
>
> At this point it's becoming increasingly clear that 8250 UART cloners
> are both very bad at cloning the things accurately, and very busy adding
> extra useful features so we need to start to treat 8250.c as a library
> you can wrap.

Sad but true.  It is like a time warp back to lib8390.c  --- whee.

P.

>
> Alan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
