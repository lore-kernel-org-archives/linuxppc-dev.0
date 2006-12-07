Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9110267CAF
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 07:29:55 +1100 (EST)
Message-ID: <457879BE.9000704@am.sony.com>
Date: Thu, 07 Dec 2006 12:29:50 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ps3: add vuart support
References: <45775D89.7030904@am.sony.com> <200612071937.22607.arnd@arndb.de>
In-Reply-To: <200612071937.22607.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Thursday 07 December 2006 01:17, Geoff Levand wrote:
>> Adds support for the PS3 virtual UART (vuart).  The vuart provides a
>> bi-directional byte stream data link between logical partitions.
> 
> Looks good now, just a few minor comments:
> 
>> +struct ports_bmp
>> +{
>> +	u64 status;
>> +	u64 unused[3];
>> +} __attribute__ ((packed));
> 
> Do you really want to have this structure packed? It will produce
> better code if it isn't.


Yes, it is a little obscure in the code, but the address of the ports_bmp
instance is passed to ps3_alloc_vuart_irq(), which in turn calls
lv1_configure_virtual_uart_irq().  The HV (actually the vuart service
in the policy module) uses this as a 256 bit bitmap to indicate the
interrupt status of the ports.  The system supports 256 ports, but
currently just two ports, 1 and 3, are used, so I took advantage of
that to simplify the code and just used the first word of the bitmap.

I'll post an updated patch to address your other comments.

-Geoff
