Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 39F3967BBD
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 23:33:11 +1000 (EST)
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4D19D866@zch01exm20.fsl.freescale.net>
References: <4879B0C6C249214CBE7AB04453F84E4D19D866@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C62AC4D8-39E5-44D0-88A3-E8D8042FC828@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
Date: Wed, 27 Sep 2006 08:33:33 -0500
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> +memory {
>>>> +               device_type = "memory";
>>>> +               linux,phandle = <300>;
>>>> +               reg = <00000000 4000000 f4500000 00000020>;
>>>> +       };
>>>> the second pair is about bcsr and its size.
>>>>
>>>> Just in case this may help (and wondering if I'm not violating
>>> something :) )
>>>
>>> Well, this can make it work.  But I would prefer to use a new node
>>> because the BCSR is by no means a memory type of device.  I have
> made my
>>> change to use node like this:
>>>
>>>         bcsr@f8000000 {
>>>                 device_type = "board-control";
>>>                 reg = <f8000000 8000>;
>>>         };
>>>
>>
>> I though about that approach, but saw somewhere a reference that we
> should not summon
>> new node types without utter necessity, and utilized memory because
> bcsr is
>> memory-mapped stuff. I can hardly imagine bcsr as a device (which
> would require
>> respective spec inclusion btw).
>
> Well I didn't see such a guideline.  However BCSR is truly a device  
> like
> any other peripherals on board.  Usually it is an FPGA on local bus to
> control the board.

Agree that a new node is better, calling it memory isn't right.   
However, I'm not sure this really needs a node in the device tree.  
The BCSR isn't really the same from board to board last time I  
checked.  I'd be interested in Paul's thinking about why it should be  
in the tree.

>> hence let's open a discussion what others think about that. The
> problem seems common
>> (and for some boards
>> is called somewhat else apparently), but at this point we should come
> to some
>> conclusion, document it, and use it.
>
> Agreed.  As we are adding more devices to the device tree, we should
> also have a guideline clearly stated for adding new nodes.
>
> I'm adding MURAM as a new node under QE bus.  Please comment.
>                 muram@10000 {
>                         device_type = "memory";
>                         ranges = <0 00010000 0000c000>;
>
>                         data-only@0{
>                                 reg = <0 c000>;
>                         };
>                 };

What was the need for this?

- kumar
