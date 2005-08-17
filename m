Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 2A58E67F79
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2005 15:43:34 +1000 (EST)
In-Reply-To: <20050816.203312.77701192.davem@davemloft.net>
References: <20050816.203312.77701192.davem@davemloft.net>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <032E6AED-9456-4271-9B06-C5DCE5970193@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 17 Aug 2005 00:43:37 -0500
To: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
	linux-kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"Gala Kumar K.-galak" <galak@freescale.com>
Subject: Re: [PATCH] ppc32: removed usage of <asm/segment.h> 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 16, 2005, at 10:33 PM, David S. Miller wrote:

> From: Paul Mackerras <paulus@samba.org>
> Date: Wed, 17 Aug 2005 11:38:20 +1000
>
>
>> Kumar Gala writes:
>>
>>
>>> Made <asm/segment.h> a dummy include like it is in ppc64 and removed
>>>
> any
>
>>> users if it in arch/ppc.
>>>
>>
>> Why can't we just delete asm-ppc/segment.h (and asm-ppc64/segment.h
>> too, for that matter) entirely?
>>
>
> I concur, in fact we should really kill that thing off entirely.

I'm all for killing it off entirely but got some feedback that on  
i386 segment.h can be included by userspace programs.

Here is the in kernel consumers that are outside of arch specific  
directories:

./drivers/char/mxser.c:#include <asm/segment.h>
./drivers/isdn/hisax/hisax.h:#include <asm/segment.h>
./drivers/media/video/adv7170.c:#include <asm/segment.h>
./drivers/media/video/adv7175.c:#include <asm/segment.h>
./drivers/media/video/bt819.c:#include <asm/segment.h>
./drivers/media/video/bt856.c:#include <asm/segment.h>
./drivers/media/video/saa7111.c:#include <asm/segment.h>
./drivers/media/video/saa7114.c:#include <asm/segment.h>
./drivers/media/video/saa7185.c:#include <asm/segment.h>
./drivers/serial/68328serial.c:#include <asm/segment.h>
./drivers/serial/crisv10.c:#include <asm/segment.h>
./drivers/serial/icom.c:#include <asm/segment.h>
./drivers/serial/mcfserial.c:#include <asm/segment.h>
./drivers/video/q40fb.c:#include <asm/segment.h>
./include/linux/isdn.h:#include <asm/segment.h>
./sound/oss/os.h:#include <asm/segment.h>

- kumar
