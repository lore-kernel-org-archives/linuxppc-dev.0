Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 6B82DDDFDE
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 07:25:50 +1100 (EST)
Message-ID: <45BFA9CA.3010002@freescale.com>
Date: Tue, 30 Jan 2007 14:25:46 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 10/18] bootwrapper: Add ft_find_device_rel().
References: <20070129201208.GJ13485@ld0162-tx32.am.freescale.net>
	<EBA70DCA-527B-4804-848D-11EB56E907F9@kernel.crashing.org>
In-Reply-To: <EBA70DCA-527B-4804-848D-11EB56E907F9@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> +void *ft_find_device_rel(struct ft_cxt *cxt, const void *top,
>> +                         const char *srch_path)
>> +{
>> +    char *node;
>> +
>> +    node = ft_node_ph2node(cxt, top);
> 
> 
> Huh -- are phandles a pointer?  Why not just a u32?

I can't speak for whoever designed the interface, but I'd rather keep it 
as a pointer -- it provides more flexibility to the implementation.  For 
example, if the device tree were to be maintained as a normal 
pointer-based tree, and flattened only when finalize() is called, then a 
pointer would be a natural handle to export (which wouldn't fit into a 
u32 on 64-bit platforms, unless you make assumptions about where 
bootwrapper data is located).

The downside, of course, is that it's easier to get phandles and 
internal pointers mixed up.

-Scott
