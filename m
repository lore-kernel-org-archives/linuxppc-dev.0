Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 67B48DDE09
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 15:45:18 +1100 (EST)
Message-ID: <478C3A5D.5080209@pikatech.com>
Date: Mon, 14 Jan 2008 23:45:17 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: emac/zmii link warnings
References: <478C336D.2080307@pikatech.com>
	<20080115152748.d0a05e1b.sfr@canb.auug.org.au>
In-Reply-To: <20080115152748.d0a05e1b.sfr@canb.auug.org.au>
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

Stephen Rothwell wrote:
> On Mon, 14 Jan 2008 23:15:41 -0500 Sean MacLennan <smaclennan@pikatech.com> wrote:
>   
>> I keep getting these link(?) warnings:
>>
>> WARNING: vmlinux.o(.data+0x16178): Section mismatch: reference to .init.text:emac_of_bus_notify (between 'emac_of_bus_notifier' and 'emac_phy_map_lock')
>>     
>
> emac_of_bus_notify is marked __devinit and is referred to by
> emac_of_bus_notifier (which is not marked thus) (in
> drivers/net/ibm_newemac/core.c).
>   
Adding the __devinit to emacs_of_bus_notifier causes a problem with 
emac_phy_map_lock (a mutex). But removing the __devinit from 
emac_of_bus_notify cleans up that warning. Is the __devinit really 
necessary?

Cheers,
   Sean
