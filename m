Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id E666CDDFA6
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 05:38:24 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so367209anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 10:38:23 -0800 (PST)
Message-ID: <fa686aa40802151038l7488293clb0c47da5b1b1e4fc@mail.gmail.com>
Date: Fri, 15 Feb 2008 11:38:22 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Pavel Kiryukhin" <pkiryukhin@ru.mvista.com>
Subject: Re: [PATCH] booting-without-of: add Xilinx uart 16550.
In-Reply-To: <47B59631.10908@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47B59631.10908@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 15, 2008 at 6:40 AM, Pavel Kiryukhin
<pkiryukhin@ru.mvista.com> wrote:
> Add uart 16550 properties description to Xilinx portion of booting-without-of.txt
>
>  Signed-off-by: Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
>  ---
>   Documentation/powerpc/booting-without-of.txt |   16 ++++++++++++++--
>   1 files changed, 14 insertions(+), 2 deletions(-)
>
>  diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
>  index 7b4e8a7..dd77bbc 100644
>  --- a/Documentation/powerpc/booting-without-of.txt
>  +++ b/Documentation/powerpc/booting-without-of.txt
>  @@ -2575,10 +2575,22 @@ platforms are moved over to use the flattened-device-tree model.
>
>        Xilinx uartlite devices are simple fixed speed serial ports.
>
>  -      Requred properties:
>  +      Required properties:
>         - current-speed : Baud rate of uartlite
>
>  -      v) Xilinx hwicap
>  +      v) Xilinx Uart 16550
>  +
>  +      Xilinx uart 16550 device registers are compatible with all standard 16540
>  +      and 16550 UARTs.

Not strictly true; the xilinx uart is *almost* compatible with the
ns16550.  The same driver can be made to work, but it is not register
level compatible so we cannot claim compatible="ns16550".  We need a
new compatible property for 16550 like devices with a reg shift and
offset.  Instead of attempting to come up with a generic description
of this, I recommend just naming it after the actual device instance;
something like compatible="xlnx,opb-uart16550";

Cheers,
g.
