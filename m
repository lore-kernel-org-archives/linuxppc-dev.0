Return-Path: <albert_herranz@yahoo.es>
Received: from smtp130.mail.ukl.yahoo.com (smtp130.mail.ukl.yahoo.com
	[77.238.184.61]) by ozlabs.org (Postfix) with SMTP id 606801007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 Nov 2009 05:08:22 +1100 (EST)
Message-ID: <4B0C2115.3010006@yahoo.es>
Date: Tue, 24 Nov 2009 19:08:21 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 09/19] powerpc: gamecube/wii: udbg support for usbgecko
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<E6251558-8B55-4A7C-952C-4989D876C69A@kernel.crashing.org>
In-Reply-To: <E6251558-8B55-4A7C-952C-4989D876C69A@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> +      If you say yes to this option, support will be included for the
>> +      USB Gecko adapter as an udbg console.
>> +      The USB Gecko is a EXI to USB Serial converter that can be plugged
>> +      into a memcard slot in the Nintendo GameCube/Wii.
> 
> Not "a" memcard slot, only the first one, you have it hardcoded.
> 

No. It's not hardcoded in the code. It's specified in the device tree source.
The hardcoded one is just the early udbg, not the "normal" udbg.

>> +#if 0
>> +/*
>> + * Trasmits a null terminated character string.
>> + */
>> +static void ug_puts(char *s)
>> +{
>> +    while (*s)
>> +        ug_putc(*s++);
>> +}
>> +#endif
> 
> Remove?
> 

Ok :)

>> +    stdout = of_find_node_by_path(path);
>> +    if (!stdout) {
>> +        udbg_printf("%s: missing path %s", __func__, path);
>> +        goto done;
>> +    }
>> +
>> +    for (np = NULL;
>> +        (np = of_find_compatible_node(np, NULL, "usbgecko,usbgecko"));)
>> +        if (np == stdout)
>> +            break;
>> +
>> +    of_node_put(stdout);
>> +    if (!np) {
>> +        udbg_printf("%s: stdout is not an usbgecko", __func__);
>> +        goto done;
>> +    }
> 
> Surely there is something called something like of_node_is_compatible()
> you can use here?  You already have the node pointer, there is no need
> to look at all other nodes.
> 

I see the point.
I didn't find of_node_is_compatible() but I'll look what's available here.

Thanks,
Albert
