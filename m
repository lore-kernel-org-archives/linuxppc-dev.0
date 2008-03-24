Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id F2620DDF6D
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 03:48:33 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so614456anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Mar 2008 09:48:32 -0700 (PDT)
Message-ID: <fa686aa40803240948o74060305j46061c1eeff4a7fe@mail.gmail.com>
Date: Mon, 24 Mar 2008 10:48:32 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/3] [POWERPC] Xilinx: of_serial support for Xilinx uart
	16550.
In-Reply-To: <47E7D3BB.1050403@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <12060242324116-git-send-email-john.linn@xilinx.com>
	<20080320144402.3063517C005D@mail148-sin.bigfish.com>
	<fa686aa40803201719i7bf02ba2qd259f1a36a24d943@mail.gmail.com>
	<18403.32257.725539.470771@cargo.ozlabs.ibm.com>
	<fa686aa40803220750h1d86589am9a26aeeb359178b7@mail.gmail.com>
	<47E7B61B.70708@ru.mvista.com>
	<fa686aa40803240727p14c7e8c0r8575f7d5feb776dd@mail.gmail.com>
	<47E7D3BB.1050403@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 24, 2008 at 10:15 AM, Sergei Shtylyov
<sshtylyov@ru.mvista.com> wrote:
> Grant Likely wrote:
>  >>    Probably I misunderstood you: does it give the same result as offset 11?
>
>  > er; typo; oops.  A 32 bit read add offset 0 is the same as a byte read
>  > at offset *3*.
>
>     Oh, well... unfortunately, we can't use UPIO_MEM32 "register model" in
>  8250.c anyway since that makes use of readl()/writel() -- which treat the bus
>  as bigendian on PPC... anyway, we would need at least a "reg-size" property,
>  if not new "compatible"...

:-) ... and the *driver* itself isn't any sort of issue; it's just
figuring out the best way to describe the hardware
accurately/appropriately so the binding can decide how to configure
the driver.

>  >>    Have you considered using the existing "big-endian" property?
>
>  > No I haven't, but that would work too.  I'm happy with that if it
>  > works for you.  If the property was defined, then the byte offset to
>  > the first reg would be adjusted by 1^(reg-shift) - 1
>
>     You don't mean "xor" by ^, do you? :-O
>     In fact, it should be <<...

heh; pseudocoding in the wrong language.  You, of course, are right.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
