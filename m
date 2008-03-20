Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id BA92ADE0FC
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 08:18:28 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so254997anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 14:18:27 -0700 (PDT)
Message-ID: <fa686aa40803201418j398a7b54n6fb03507b0f48c1a@mail.gmail.com>
Date: Thu, 20 Mar 2008 15:18:27 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Linn" <John.Linn@xilinx.com>
Subject: Re: [PATCH 3/3] [POWERPC] Xilinx: boot support for Xilinx uart 16550.
In-Reply-To: <20080320161834.A873BDE0072@mail96-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <12060242324116-git-send-email-john.linn@xilinx.com>
	<1206024232655-git-send-email-john.linn@xilinx.com>
	<20080320144402.695C1518064@mail63-sin.bigfish.com>
	<fa686aa40803200754j6972deenad63cf37a836f236@mail.gmail.com>
	<20080320161834.A873BDE0072@mail96-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 20, 2008 at 10:15 AM, John Linn <John.Linn@xilinx.com> wrote:
> You're right.  Rick and I were just talking about could we not check the
>  versions but just make sure the device is the right type independent of
>  the versions.
>
>  This issue will be true for all the Xilinx drivers.
>
>  I think FPGA IP is a little different in that the hardware can change
>  much more often than in hard devices.

Exactly, so all your compatible properties should look something like
one of the following:

compatible = "xlnx,xps-uart16550-2.00.b", "spares16550";
 - or -
compatible = "xlnx,xps-uart16550-2.00.b", "xlnx,opb-uart16550-1.00c",
"sparse16550";
 - or -
compatible = "xlnx,xps-uart16550-2.00.b", "xlnx,opb-uart16550-1.00c";

Notice that the exact version is *always* there.  Followed by versions
that it is exactly backwards compatible with.  As I said, I personally
like the string "sparse16550", but if other people complain about it
then pick the earliest version of the part that it is backwards
compatible with and use that version string (like in my third example
above).

The reason "xlnx,uart16550" isn't a good idea is because it isn't a
real part thing.  It is a made up idea of what the thing is, but it
isn't grounded in a particular implementation.  (Note that even
ns16550 is a real part).  The problem with 'virtual' compatible
properties is that because they aren't grounded; the temptation is to
shift their definition over time as newer parts come out that behave
differently.  It is really hard to shift the definition of something
that is exactly specified.

Side note; While I do like sparse16550, it may also not be a good idea
for the same reason that "xlnx,uart16550" is not a good idea.
However, the risk is much lower because there is already a fair amount
of precedence of 'sparse' 16550 devices in the wild and their behavior
is well known.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
