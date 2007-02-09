Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id BE4BDDDE9E
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 07:58:44 +1100 (EST)
Message-ID: <45CCE07F.9040107@ru.mvista.com>
Date: Fri, 09 Feb 2007 23:58:39 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] Check mac-address first in fsl_soc.c
References: <11710513671236-git-send-email-timur@freescale.com>
	<45CCDEFB.5050504@ru.mvista.com> <45CCDFBC.1090104@freescale.com>
In-Reply-To: <45CCDFBC.1090104@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Timur Tabi wrote:

>>> The mac-address property in the device tree should be checked first,
>>> before local-mac-address.  This is because mac-address contains the most
>>> recent MAC address, whereas local-mac-address is the default address.
>>> Depending on the platform and the version of U-Boot, U-Boot will set
>>> one or the other, or both.

>>    Argh, *when* it will be setting both?

> I'm working on a patch now to implement that for 83xx.  Whether/when it 
> will be applied is anyone's guess.

    I'm mainly concerned about 85xx. I guess the needed change should be very 
alike...

>>> -        mac_addr = (void *)get_property(np, "mac-address", NULL);
>>> -        memcpy(fs_enet_data.macaddr, mac_addr, 6);
>>> +        mac_addr = get_property(np, "mac-address", NULL);
>>> +        if (!mac_addr || (memcmp(mac_addr, "\0\0\0\0\0", 6) == 0)) {
>>> +            mac_addr = get_property(np, "local-mac-address", NULL);
>>> +            if (!mac_addr || (memcmp(mac_addr, "\0\0\0\0\0", 6) == 
>>> 0)) {
>>> +                /* Obsolete */
>>> +                mac_addr = get_property(np, "address", NULL);
>>> +            }
>>> +        }
>>> +
>>> +        if (mac_addr)
>>> +            memcpy(fs_enet_data.macaddr, mac_addr, 6);
>>
>>
>>    These are just asking to be put into a separate function... :-)

> I wanted to keep my patch simple.

    That's clearly an over-simplification to repeat the same code thrice.

WBR, Sergei
