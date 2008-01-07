Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 4D2A4DDEED
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 02:33:32 +1100 (EST)
Message-ID: <47824641.8090208@windriver.com>
Date: Mon, 07 Jan 2008 10:33:21 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/7] powerpc: allow localbus compatible serial ports for
	console device
References: <11997159321859-git-send-email-paul.gortmaker@windriver.com>
	<11997159331132-git-send-email-paul.gortmaker@windriver.com>
	<11997159342128-git-send-email-paul.gortmaker@windriver.com>
	<200801071533.47018.arnd@arndb.de>
In-Reply-To: <200801071533.47018.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Monday 07 January 2008, Paul Gortmaker wrote:
>   
>> +       /* Next, fill our array with any localbus serial ports */
>> +       for_each_compatible_node(np, "serial", "ns16550") {
>> +               struct device_node *lbs = of_get_parent(np);
>> +               if (lbs && of_device_is_compatible(lbs, "localbus")) {
>> +                       index = add_legacy_soc_port(np, np);
>> +                       if (index >= 0 && np == stdout)
>> +                               legacy_serial_console = index;
>> +               }
>> +               of_node_put(lbs);
>> +       }
>> +
>>     
>
> This is getting a little silly. Can't you finally unify the code
> so it checks for any 8250/16450/16550 on any soc/isa/tsi-bridge/opb/localbus?
>   

I'd thought about doing that, but there are slight differences
in each test.  To remain 100% faithful to the original implementation
you'd have to have a table or similar that had these various fields
and loop over that -- something like:

compat      parent   pnt-compat  pnt-type   add-fcn
---------------------------------------------------------------
ns16550     NULL     NULL        soc        add_legacy_soc_port
NULL        isa      NULL        NULL       add_legacy_isa_port
ns16550     NULL     NULL        tsi-bridge add_legacy_soc_port
ns16550     NULL     ibm,opb     opb        add_legacy_soc_port
ns16550     NULL     localbus    NULL       add_legacy_soc_port

But, if we were willing to move away from checks based on
the parent->type and stick with parent->compat, then the
unification would be a lot cleaner and easier to implement.
(we could also leave the ISA one out as an oddball, and then
not have to carry an add-fcn either).

Paul.




> 	Arnd <><
>   
