Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (unknown [192.88.158.102])
	by ozlabs.org (Postfix) with ESMTP id 9B17267A60
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Jun 2006 12:39:50 +1000 (EST)
In-Reply-To: <200606032255.05997.antonio.dibacco@aruba.it>
References: <c91756f0606030438y62772d89ib43f613cd5373739@mail.gmail.com>
	<200606032255.05997.antonio.dibacco@aruba.it>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <75593F2C-863B-4B19-8DD3-D3AD41180947@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: Making Two ethernet interfaces up in Linux
Date: Mon, 5 Jun 2006 10:12:22 -0500
To: Antonio Di Bacco <antonio.dibacco@aruba.it>
Cc: Shantanu Nalage <shantanu.nalage@gmail.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 3, 2006, at 15:55, Antonio Di Bacco wrote:

>>          We are trying to port Linux on Xilinx Board XUPV2Pro  
>> which is
>> similar in most aspects to the Xilinx ML300 board. Linux is up and
>> running for the original board i.e. having only one ethrnet  
>> interface.
>> Now since we wanted to have the board working as router, we  
>> designed a
>> daughter board with two ethernet phy interfaces. The MACs required  
>> for
>> that are instantiated in Xilinx ....
>
> You have already the driver for the first MAC, then you should  
> start from that
> modifying the init procedure for example and all the others. Your  
> driver
> should initialize both the MACs and also create two devices calling
> init_etherdev tow times. If you post your driver I can suggest what to
> change. It is not so difficult.


Generally, it's better to modify the driver so it can be used to  
control any number of instances of the same ethernet hardware.  Then  
instantiate 2 (or how many you like) instances of the device, using  
the device layer (typically done in the board-specific code).
