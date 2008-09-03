Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E428DDDE45
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Sep 2008 23:51:03 +1000 (EST)
Received: from LPSC0173W (lpsc0173w.in2p3.fr [134.158.40.173])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with SMTP id m83DowkG018914
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Sep 2008 15:50:58 +0200
Message-ID: <155401c90dcc$18026770$ad289e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: Xilinx GPIO API and kernel GPIO API differences
Date: Wed, 3 Sep 2008 15:50:51 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello all,
I can't fully understand the differences in what should be simple I/O 
read/writes.

If I write a standalone program using the Xilinx API calls, I have access to 
the following functions to control the direction of GPIO bits. For instance:

XGpio Input, Output;
XGpio_Initialize(&Input, InputDev);
XGpio_Initialize(&Output, OutputDev));
XGpio_SetDataDirection(&Input,  1, 0xFFFFFFFF);
XGpio_SetDataDirection(&Output, 1, 0);
Data = XGpio_DiscreteRead(&Input, 1);
XGpio_DiscreteWrite(&Output, 1, 0x12345678);

Now the equivalent using usermode linux calls _seems_ to be the following:

struct xgpio_ioctl_data Input, Output;
Input = open(GPIO_IN, O_RDWR);
Output = open(GPIO_OUT, O_RDWR);
gpio_info.chan = 1;
gpio_info.mask = 0xFFFFFFFF;
ioctl(Input, XGPIO_IN, &gpio_info);
Data=gpio_info.data;
gpio_info.data=0x12345678;
ioctl(Output, XGPIO_OUT, &gpio_info);

But where it all breaks down is if I have input and output bits mixed on the 
same GPIO, particularly if reading the outputs makes no sense like in my 
case (always return 0).
Using those ioctl calls, how do I specify which bits are input and which 
ones are output ?
In other words, the equivalent to this:

XGpio IO;
XGpio_Initialize(&IO, Dev);
XGpio_SetDataDirection(&Input,  1, 0x00FFFF00);
Data = XGpio_DiscreteRead(&Input, 1);
XGpio_DiscreteWrite(&Output, 1, 0x12000078);

Is there anything available from usermode besides those ioctl calls ?
This makes me regret assembly...
-- 
Guillaume Dargaud
http://www.gdargaud.net/
