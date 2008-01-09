Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.247])
	by ozlabs.org (Postfix) with ESMTP id 456B5DE0D1
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 03:48:56 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 33so226163agc.0
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jan 2008 08:48:55 -0800 (PST)
Message-ID: <fa686aa40801090848m33170951paed90d8a79d41e32@mail.gmail.com>
Date: Wed, 9 Jan 2008 09:48:55 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Joachim Meyer" <Jogi95@web.de>, linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: Linux for ml310
In-Reply-To: <524178230@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <524178230@web.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

always CC the mailing list when replying.

On 1/9/08, Joachim Meyer <Jogi95@web.de> wrote:
> arch/ppc/boot/common/ns16550.c:21: error: `XPAR_UARTNS550_0_CLOCK_FREQ_HZ' undeclared here (not in a function)
> arch/ppc/boot/common/ns16550.c:21: error: initializer element is not constant
> arch/ppc/boot/common/ns16550.c:21: error: (near initialization for `rs_table[0].baud_base')
> arch/ppc/boot/common/ns16550.c:21: error: `XPAR_INTC_0_UARTNS550_0_VEC_ID' undeclared here (not in a function)
> arch/ppc/boot/common/ns16550.c:21: error: initializer element is not constant
> arch/ppc/boot/common/ns16550.c:21: error: (near initialization for `rs_table[0].irq')
> arch/ppc/boot/common/ns16550.c:21: error: `XPAR_UARTNS550_0_BASEADDR' undeclared here (not in a function)
> arch/ppc/boot/common/ns16550.c:21: error: initializer element is not constant
> arch/ppc/boot/common/ns16550.c:21: error: (near initialization for `rs_table[0].iomem_base')
> arch/ppc/boot/common/ns16550.c:21: error: initializer element is not constant
> arch/ppc/boot/common/ns16550.c:21: error: (near initialization for `rs_table[0]'

You're xparameters_ml300.h file does not define
`XPAR_UARTNS550_0_CLOCK_FREQ_HZ', `XPAR_INTC_0_UARTNS550_0_VEC_ID' and
`XPAR_UARTNS550_0_BASEADDR'.

You'll need to look in your xparams file, find out what the real
#defines are for the uart and add fixups to xparameter.h so ns16550
can find them.

You're almost there!  :-)

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
