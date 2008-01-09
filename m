Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 5BDA8DE198
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Jan 2008 06:16:09 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so78263anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 09 Jan 2008 11:16:05 -0800 (PST)
Message-ID: <fa686aa40801091116n20d9b1cet131f57f41120e07e@mail.gmail.com>
Date: Wed, 9 Jan 2008 12:16:04 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Joachim Meyer" <Jogi95@web.de>
Subject: Re: Linux for ml310
In-Reply-To: <524369371@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <524369371@web.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 1/9/08, Joachim Meyer <Jogi95@web.de> wrote:
> Hi
>
> Thanks for your great help!
> I added following lines which I found at the old xparameters_ml300.h, which was part of the kernel-sources but was replaced with the one of the BSP:
> ----------------------------------------------------------------------------------------------------------------------------------
> #define XPAR_XUARTNS550_CLOCK_HZ 100000000
> #define XPAR_DCR_INTC_0_OPB_UART16550_0_IP2INTC_IRPT_INTR 6
> #define XPAR_OPB_UART16550_0_BASEADDR 0xA0000000
> #define XPAR_UARTNS550_0_CLOCK_FREQ_HZ XPAR_XUARTNS550_CLOCK_HZ
> #define XPAR_INTC_0_UARTNS550_0_VEC_ID XPAR_DCR_INTC_0_OPB_UART16550_0_IP2INTC_IRPT_INTR
> #define XPAR_UARTNS550_0_BASEADDR (XPAR_OPB_UART16550_0_BASEADDR+0x1000)

wait... Are you using the value from the *old* or *new*
xparameters_ml300.h?  The values from the old file *will* *not* *work*
for your design.  You must find the appropriate values from your new
xparams file.

Hmmm.... but, this whole discussion assmues that your using a 16550
serial port.  If you are using the uartlite instead then all of the
above is unnecessary; you just need to turn off 16550 console support
in the kernel config.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
