Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id E78FCDDE17
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 16:45:35 +1100 (EST)
Message-ID: <478C487D.9050407@pikatech.com>
Date: Tue, 15 Jan 2008 00:45:33 -0500
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
>   
The __devinitdata solves this.
>> WARNING: vmlinux.o(.init.text+0x16ba8): Section mismatch: reference to .exit.text:zmii_detach (between 'emac_probe' and 'zmii_probe')
>> WARNING: vmlinux.o(.init.text+0x16bb4): Section mismatch: reference to .exit.text:mal_unregister_commac (between 'emac_probe' and 'zmii_probe')
>>     
>
> These will be similar but function calls.
>
>   
The problem here is that emac_probe calls zmii_detach. emacs_probe is a 
__devinit and zmii_detach is a __devexit. At least I assume that is the 
problem.

I am a long time emacs (actually xemacs) user. If I had a nickel for 
every time I typed emacs rather than emac, I would be a very rich man.

Cheers,
   Sean
