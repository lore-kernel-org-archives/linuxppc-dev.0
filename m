Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 84B4267C0F
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 00:57:55 +1000 (EST)
Message-ID: <451A916B.9010905@ru.mvista.com>
Date: Wed, 27 Sep 2006 18:57:47 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
References: <20060927155626.4d5ca19c@vitb.ru.mvista.com>	<4879B0C6C249214CBE7AB04453F84E4D19D865@zch01exm20.fsl.freescale.net>
	<20060927165556.04c8d5d7@vitb.ru.mvista.com>
In-Reply-To: <20060927165556.04c8d5d7@vitb.ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Vitaly Bordug wrote:

>>>>>+#define BCSR_PHYS_ADDR		((uint)0xf8000000)
>>>>>+#define BCSR_SIZE		((uint)(32 * 1024))

>>>>This sort of thing should really be in the device tree.

>>>Just a suggestion, but for the similar aim in pq2 I have those stuff

>>in memory node :

>>>+memory {
>>>+               device_type = "memory";
>>>+               linux,phandle = <300>;
>>>+               reg = <00000000 4000000 f4500000 00000020>;
>>>+       };
>>>the second pair is about bcsr and its size.

>>>Just in case this may help (and wondering if I'm not violating

>>something :) )

>>Well, this can make it work.  But I would prefer to use a new node
>>because the BCSR is by no means a memory type of device.  I have made my
>>change to use node like this:

>>        bcsr@f8000000 {
>>                device_type = "board-control";
>>                reg = <f8000000 8000>;
>>        };

> I though about that approach, but saw somewhere a reference that we should not summon new node types without utter necessity, and utilized memory because bcsr is memory-mapped stuff.

    You might have utilized "memory" even for the Ethernet controllers guided 
by such logic. Of course, that was a wrong criterion -- "memory" is for RAM, 
otherwise you'd be fooling the kernel device tree scanner which looks for the 
"memory" nodes.

> I can hardly imagine bcsr as a device (which would require respective spec inclusion btw).

    And this is hardly a memory, neverthless.

WBR, Sergei
