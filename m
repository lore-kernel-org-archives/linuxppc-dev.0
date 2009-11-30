Return-Path: <albert_herranz@yahoo.es>
Received: from smtp144.mail.ukl.yahoo.com (smtp144.mail.ukl.yahoo.com
	[77.238.184.75]) by ozlabs.org (Postfix) with SMTP id 11DF91007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 Nov 2009 17:15:45 +1100 (EST)
Message-ID: <4B13630E.1050405@yahoo.es>
Date: Mon, 30 Nov 2009 07:15:42 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v2 08/11] powerpc: gamecube/wii: early debugging using
	usbgecko
References: <1259441037-15725-1-git-send-email-albert_herranz@yahoo.es>	
	<1259441037-15725-9-git-send-email-albert_herranz@yahoo.es>
	<1259536695.2076.40.camel@pasglop> <4B135D3D.9030006@yahoo.es>
In-Reply-To: <4B135D3D.9030006@yahoo.es>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Albert Herranz wrote:
> Benjamin Herrenschmidt wrote:
>> On Sat, 2009-11-28 at 21:43 +0100, Albert Herranz wrote:
>>> +        * Prepare again the same BAT for MMU_init.
>>> +        * This allows udbg I/O to continue working after the MMU is
>>> +        * turned on for real.
>>> +        *
>>> +        * We are assuming here that exi_io_base is identity mapped.
>>> +        */
>>> +       addr = ((unsigned long)exi_io_base) & 0xffff0000;
>>> +       setbat(1, addr, addr, 128*1024, PAGE_KERNEL_NCG); 
>> How do you prevent that from overlapping otherwise valid kernel
>> mappings ?
>>
> 
> ug_udbg_init() is called from ppc_md.init_early.

  ^^^
This got here, but although it's true it doesn't apply here :)

> It doesn't overlap any valid kernel mappings because exi_io_base is hardcoded to an i/o region not used yet by the kernel.
> See udbg_early_grab_exi_io_base().
> The setbat just prepares again, exactly in the same way, the same BAT that we got setup by setup_usbgecko_bat in head_32.S.
> 

Thanks,
Albert
