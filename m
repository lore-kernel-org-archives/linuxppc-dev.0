Return-Path: <tnt@246tNt.com>
Received: from outmx002.isp.belgacom.be (outmx002.isp.belgacom.be
	[195.238.3.52]) by ozlabs.org (Postfix) with ESMTP id E44002BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Nov 2004 19:22:29 +1100 (EST)
Received: from outmx002.isp.belgacom.be (localhost [127.0.0.1])
	by outmx002.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id iAO8MKdF030977
	for <linuxppc-embedded@ozlabs.org>; Wed, 24 Nov 2004 09:22:21 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <41A444C6.204@246tNt.com>
Date: Wed, 24 Nov 2004 09:22:30 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: roger blofeld <blofeldus@yahoo.com>
References: <20041123224241.1791.qmail@web53506.mail.yahoo.com>
In-Reply-To: <20041123224241.1791.qmail@web53506.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 Cache coherency with BestComm issue (was: Lite5200 FEC
 Driver on linux 2.6 (updated))
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi roger

> Using your latest tree still shows the packet checksum errors, despite
>XLB snooping being enabled.
>
>I think that the cache flush is required
>
It really shouldn't be.
Take a look at 
http://www.freescale.com/files/microcontrollers/doc/app_note/AN2604.pdf,
page 3, 4th paragraph

quote : <<< In case the memory location interested by BestComm accesses 
are cached in
copy-back mode by the core, a "Snooping" activity can be forced to the 
core, so that an
'address retry' will be issued and the core will first flush it's cache 
line before allowing
BestComm to retry it's transaction. >>>


Note that performance wise, adding it is probably a good idea. It will 
have to be flushed
eventually  and forcing BestComm to retry a transaction is just waste of 
XLB cycles ...


>or
>that the skb pages must be marked coherent somehow.
>
Yes they must. I haven't checked if they were but since this requirement 
is common
for multiple ppc, I'd guess they are.


>I note that the 8xx
>fec.c file also has a cache flush, so it isn't that strange.
>  
>
I don't know 8xx in details, but in arch/ppc/Kconfig, 8xx defines
NOT_COHERENT_CACHE symbol. So they probably excpect it not to be.



    Sylvain
