Return-Path: <glikely@secretlab.ca>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.242])
	by ozlabs.org (Postfix) with ESMTP id 8850ADDF0A
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 01:27:27 +1100 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so2719514hsz.9
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Mar 2008 07:27:25 -0700 (PDT)
Message-ID: <fa686aa40803240727p14c7e8c0r8575f7d5feb776dd@mail.gmail.com>
Date: Mon, 24 Mar 2008 08:27:23 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/3] [POWERPC] Xilinx: of_serial support for Xilinx uart
	16550.
In-Reply-To: <47E7B61B.70708@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <12060242324116-git-send-email-john.linn@xilinx.com>
	<20080320144402.3063517C005D@mail148-sin.bigfish.com>
	<fa686aa40803201719i7bf02ba2qd259f1a36a24d943@mail.gmail.com>
	<18403.32257.725539.470771@cargo.ozlabs.ibm.com>
	<fa686aa40803220750h1d86589am9a26aeeb359178b7@mail.gmail.com>
	<47E7B61B.70708@ru.mvista.com>
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

On Mon, Mar 24, 2008 at 8:09 AM, Sergei Shtylyov
<sshtylyov@ru.mvista.com> wrote:
> Grant Likely wrote:
>
>  >> > Personally, I'm not fond of this approach.  There is already some
>  >> > traction to using the reg-shift property to specify spacing, and I
>  >> > think it would be appropriate to also define a reg-offset property to
>  >> > handle the +3 offset and then let the xilinx 16550 nodes use those.
>
>  >> Why do we need a reg-offset property when we can just add the offset
>  >> to the appropriate word(s) in the reg property?
>
>  > Primarily because the device creates 32 byte registers starting at 0;
>  > but they are also big-endian byte accessible so a byte read at offset
>  > 8 also works.
>
>     Probably I misunderstood you: does it give the same result as offset 11?

er; typo; oops.  A 32 bit read add offset 0 is the same as a byte read
at offset *3*.

>
>
>  > reg-offset seems to be a better description of the hardware to me.
>
>     Have you considered using the existing "big-endian" property?

No I haven't, but that would work too.  I'm happy with that if it
works for you.  If the property was defined, then the byte offset to
the first reg would be adjusted by 1^(reg-shift) - 1

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
