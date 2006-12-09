Return-Path: <minyard@acm.org>
Received: from mta16.adelphia.net (mta16.mail.adelphia.net [68.168.78.211])
	by ozlabs.org (Postfix) with ESMTP id 97BC167A3B
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 11:07:47 +1100 (EST)
Message-ID: <4579FE4F.8000206@acm.org>
Date: Fri, 08 Dec 2006 18:07:43 -0600
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Openipmi-developer] [patch 1/1] ipmi: add autosensing of ipmi
	device on powerpc using device-tree
References: <20061207172259.64168f8c@localhost>
	<20061208185902.GA14675@localdomain>
	<1165618236.1103.87.camel@localhost.localdomain>
	<200612090100.09380.arnd@arndb.de>
In-Reply-To: <200612090100.09380.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, openipmi-developer@lists.sourceforge.net,
	Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Friday 08 December 2006 23:50, Benjamin Herrenschmidt wrote:
>   
>>> +     info->io.regsize        = resource0.end - resource0.start + 1;
>>> +     info->io.regspacing     = resource1.start - resource0.start;
>>>
>>> Are you sure this is a reliable way to check the register spacing and
>>> register size?  Register size means "how big is a register (8, 16, 32
>>> bits)".  Register spacing means (how many bytes are there between
>>> registers.  If you had two registers that were 8 bits and 4 bytes
>>> apart, for instance, I don't believe the above calculations would work.
>>>       
>> How many registers do we expect here ? Might be better to have one
>> resource represent the whole MMIO area, and have a separate property
>> that indicates the stride between 2 registers.
>>     
>
> I think the current representation is perfect. AFAICS, there are always
> two registers, but depending on the HW implementation, they may be
> between 1 and 4 bytes wide, and can have a different spacing.
>   
The BT and SMIC interfaces have three registers.  Does that break things?

-Corey
