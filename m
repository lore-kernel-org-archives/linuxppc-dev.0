Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C230167B16
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 15:37:20 +1000 (EST)
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467306E04FEB@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD467306E04FEB@zch01exm40.ap.freescale.net>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <40ED911C-7485-42C6-BDBC-1581AD4BC426@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add QE device tree definition
Date: Fri, 30 Jun 2006 00:37:13 -0500
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>
>>>>>>> +   2) SPI (Serial Peripheral Interface)
>>>>>>> +
>>>>>>> +   Required properties:
>>>>>>> +   - device_type : should be "spi".
>>>>>>> +   - compatible : should be "fsl_spi".
>>>>>>> +   - mode : the spi operation mode, it can be "cpu" or "qe".
>>>>>>
>>>>>> What does it mean for the spi to be in "qe" mode?
>>>>> That means:
>>>>> The SPI can operate in QE mode or in CPU mode. In QE mode SPI is
>>>>> compatible to the MPC826x SPI, and is controlled by QE RISC. In  
>>>>> CPU
>>>>> mode, the SPI is controlled wholly by the CPU without any QE RISC
>>>>> intervention.
>>>>
>>>> In QE mode does software get involved at all?
>>>
>>> Yes, of course.  The driver needs to do initialization, and deal
>>> with the BDs.
>>
>> So what exactly does the QE do in this mode?
>
> Just like CPM.  Driver only deal with buffer and buffer  
> descriptor.  And QE will take care of the other things.
> While in CPU mode, it is up to the CPU to pack and unpack the  
> receive/transmit frames.  And tx/rx through data registers.

Ohh, so CPU mode matches the 834x then, and QE mode matches 82xx/CPM.

Has anyone looked at extending the 834x driver that is in the tree  
now for using descriptors for QE/82xx?

- k
