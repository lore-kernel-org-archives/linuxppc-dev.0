Return-Path: <kalle.pokki@iki.fi>
Received: from smtp1.song.fi (smtp1.song.fi [194.100.2.121])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8DE9B683C9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Sep 2005 20:20:37 +1000 (EST)
Message-ID: <433A6E6D.4070403@iki.fi>
Date: Wed, 28 Sep 2005 12:20:29 +0200
From: Kalle Pokki <kalle.pokki@iki.fi>
MIME-Version: 1.0
To: Dan Malek <dan@embeddedalley.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B85946A@ismail.innsys.innovsys.com>
	<4333DF04.3000908@iki.fi> <43395322.1080407@iki.fi>
	<384d09b865d454875c447cc02c89d001@embeddedalley.com>
	<4339AD01.30708@iki.fi>
	<714c16295fbfa97caafd1d0aa3a5932e@embeddedalley.com>
In-Reply-To: <714c16295fbfa97caafd1d0aa3a5932e@embeddedalley.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: CPM2 early console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dan Malek wrote:

> On Sep 27, 2005, at 4:35 PM, Kalle Pokki wrote:
>
>> OK. Then the question really is why isn't the cache controller 
>> enforcing coherency between the G2_LE core and the CPM.
>
> Is the GBL and DTB set properly in the function code registers
> of the SCC parameter ram?


The 60x bus is used, but snooping wasn't enabled before.

However, even after enabling snooping it still doesn't work right. If 
I'm just within my boot loader I still cannot use e.g. the SMC with WIMG 
bits 0010 and the GBL 1. If I set the write-through in WIMG bits as 
1010, it works. The core now sees the RX buffers from the CPM and, of 
course, my TX buffers since they are written to the memory.

I guess Linux remaps the RAM as copy-back. But snooping should work with 
copy-back caches, shouldn't it?
