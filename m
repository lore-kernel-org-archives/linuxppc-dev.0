Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 84D53DDE9E
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Mar 2008 01:50:49 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so432261anc.78
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 07:50:48 -0700 (PDT)
Message-ID: <fa686aa40803220750h1d86589am9a26aeeb359178b7@mail.gmail.com>
Date: Sat, 22 Mar 2008 08:50:48 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: [PATCH 2/3] [POWERPC] Xilinx: of_serial support for Xilinx uart
	16550.
In-Reply-To: <18403.32257.725539.470771@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <12060242324116-git-send-email-john.linn@xilinx.com>
	<20080320144402.3063517C005D@mail148-sin.bigfish.com>
	<fa686aa40803201719i7bf02ba2qd259f1a36a24d943@mail.gmail.com>
	<18403.32257.725539.470771@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 21, 2008 at 3:21 AM, Paul Mackerras <paulus@samba.org> wrote:
> Grant Likely writes:
>
>  > Personally, I'm not fond of this approach.  There is already some
>  > traction to using the reg-shift property to specify spacing, and I
>  > think it would be appropriate to also define a reg-offset property to
>  > handle the +3 offset and then let the xilinx 16550 nodes use those.
>
>  Why do we need a reg-offset property when we can just add the offset
>  to the appropriate word(s) in the reg property?

Primarily because the device creates 32 byte registers starting at 0;
but they are also big-endian byte accessible so a byte read at offset
8 also works.  reg-offset seems to be a better description of the
hardware to me.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
