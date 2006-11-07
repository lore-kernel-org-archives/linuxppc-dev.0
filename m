Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id E05B767D4F
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Nov 2006 08:52:27 +1100 (EST)
Message-ID: <45510013.8010509@ru.mvista.com>
Date: Wed, 08 Nov 2006 00:52:19 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH] adding ROM chips to device tree: respin
References: <20061107141923.16b2d2f1.vwool@ru.mvista.com>	
	<4550A5E6.50409@ru.mvista.com> <1162934221.2680.2.camel@barja>	
	<4550F9B8.40901@ru.mvista.com> <1162935862.2680.7.camel@barja>
In-Reply-To: <1162935862.2680.7.camel@barja>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hello.

Vitaly Wool wrote:

>>>>>+     - memory_space : Offset and length of the register set for the device.
>>>>
>>>>   NAK. There's no need to define an extra property where "reg" should be used.
>>
>>>The register set is actually not there and depends on flash chip type.
>>>So using regs here is misleading.
>>
>>    This is an I/O resource on the parent bus and using the property other 
>>than "reg" will be misleading.  That's the way this spec has it -- "reg" is 
>>used even for the PHY chip numbering on MDIO bus...

> So what? Lemme remind you that the actual registers *doesn't start* at
> the specified "start" so using regs is really a bad idea IMHO.

    We don't have any actual registers (at least "physmap" doesn't know about 
them anyway) I think, just a memory range. What registers are you talking about?

>>>>>+
>>>>>+	/*
>>>>>+	 * We care only about physmap devices now as there's no
>>>>>+	 * description defined for other ROM types yet
>>>>>+	 */

>>>>   Not true. The description only says that it's *most probably* compatible 
>>>>with "physmap", that's all. I don't see why we have to limit ourselves here.

>>>Effectively we care about NOR chips and similar which are
>>>memory-mapped. 

>>    So what? How "physmap" follows from this?

> Okay, probably we can go you way naming of_device by what it's
> compatible with. So that "physmap" compatible would be called
> "physmap-flash", "nand"-compatible would be called "nand-flash" etc.

    Actually, Generic Names spec tells to use the most generic user-parsable 
names, just like I used initally ("flash")...

> Does that work for you?

    No. Getting rid of "physmap" completely and using of_find_node_by_type() 
does. :-)

> Vitaly

WBR, Sergei
