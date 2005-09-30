Return-Path: <kalle.pokki@iki.fi>
Received: from smtp1.song.fi (smtp1.song.fi [194.100.2.121])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2031B683B6
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Oct 2005 06:11:01 +1000 (EST)
Message-ID: <433D9BCE.5000909@iki.fi>
Date: Fri, 30 Sep 2005 22:10:54 +0200
From: Kalle Pokki <kalle.pokki@iki.fi>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B85946A@ismail.innsys.innovsys.com>
	<4333DF04.3000908@iki.fi> <43395322.1080407@iki.fi>
	<384d09b865d454875c447cc02c89d001@embeddedalley.com>
	<4339AD01.30708@iki.fi>
	<714c16295fbfa97caafd1d0aa3a5932e@embeddedalley.com>
	<433A6E6D.4070403@iki.fi> <433BDCE7.2060206@iki.fi>
	<20050930142218.348041d6.ajz@cambridgebroadband.com>
	<2c578118c5d984e6e87ac3c073469866@embeddededge.com>
In-Reply-To: <2c578118c5d984e6e87ac3c073469866@embeddededge.com>
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

> On Sep 30, 2005, at 9:22 AM, Alex Zeffertt wrote:
>
>> Are there any drawbacks to this approach?
>
> The general system performance is going to suffer,
> and if you really have a cache coherency problem
> it only solves the write case and not the read case.

The read case seems to be solved by setting the appropriate GBL bits in 
the parameter ram areas, since the buffers work correctly in both 
directions by just setting cache write-through and coherent (coherent 
alone won't help). Still, there must be a correct way of doing this, but 
I think I have already tried modifying every register that sounds 
related. The errata doesn't list anything useful.

Another way of getting around the problem would be to place the buffers 
in a cache-inhibited memory area and have copy-back caches for other 
data. I successfully tried this in another application without Linux.
