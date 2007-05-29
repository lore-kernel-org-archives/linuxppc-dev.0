Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 8838CDDF5C
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 18:01:33 +1000 (EST)
Message-ID: <465BDF45.1010904@ru.mvista.com>
Date: Tue, 29 May 2007 12:07:33 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: John Williams <jwilliams@itee.uq.edu.au>
Subject: Re: Xilinx git tree at source.mvista.com
References: <46555294.6040104@ru.mvista.com>
	<465561A4.9020403@dlasys.net>	<46558E54.80909@ru.mvista.com>	<20070524154211.169C7AE8051@mail10-fra.bigfish.com>	<465640C1.1060206@dlasys.net>
	<20070525042616.35988808054@mail150-dub.bigfish.com>
	<465B6611.1070107@itee.uq.edu.au>
In-Reply-To: <465B6611.1070107@itee.uq.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org,
	Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>,
	"David H. Lynch Jr." <dhlii@dlasys.net>, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

John Williams wrote:
> Hi Wolfgang,
> 
> Wolfgang Reissnegger wrote:
>> David H. Lynch Jr. wrote:
>>
>>> For me the most significant issue is the bazillion layers of nested
>>> macro's and includes.
>>
>>
>> I don't see the macros as an issue, just look at the implementation of,
>> for example, spin_lock_irq() and Xilinx's macros seem like child's 
>> play :-)
>> As for includes, yes, there are a few too many header files. But, as
>> time progresses and the need arises they can be merged into fewer files.
> 
> It seems the kernel.org decision has been made re: the style issue. None 
> of the *_i.[ch], *_g.[ch] + adapter.c drivers will make it to mainline.

BTW, all the current drivers I am aware of have been moved to platform bus,
and do not use *_g.[ch] already.

> I understand why Xilinx did it this way, but to be honest never agreed 
> with it myself either.  Style issues aside, three levels of function 
> calls in an interrupt handler might be portable, but it still isn't a 
> good thing!

Another thing we've encountered while moving our current spi driver to the spi
framework is that sometimes there is too much "policy" in the level 1 drivers.
The level 1 spi driver controls the chip select on its own. For this reason
we were not able to use the spi_bitbang stuff. And even then we have to copy
the buffers into a single one to avoid CS toggling in the middle of the EEPROM
write sequence. The latter could probably be worked around, and could be due
to us not making the most of the level 1 driver, but at least this is not
trivial.

Yet another thing is that if one wants just FIFO mode for the TEMAC, he has
to include a bit of SGDMA code too as e.g. XTemac_Start() references
XDmaV3_SgStart() et al. IMHO wider usage of "virtual functions" would
help here (see e.g. how the System ACE driver by Grant L. handles different
bus widths).

Personally and in general, I like the idea of reusable OS independent code.
But it is hard to implement the way everyone would be happy with ;)

Thanks,
Andrei
