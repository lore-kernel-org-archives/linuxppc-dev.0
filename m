Return-Path: <gjalt007@chello.nl>
Received: from viefep12-int.chello.at (viefep18-int.chello.at [213.46.255.22])
	by ozlabs.org (Postfix) with ESMTP id 185C1DDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Nov 2007 04:56:24 +1100 (EST)
Received: from [192.168.1.203] (really [80.56.196.247])
	by viefep12-int.chello.at
	(InterMail vM.7.08.02.00 201-2186-121-20061213) with ESMTP
	id <20071118175619.HYBY19858.viefep12-int.chello.at@[192.168.1.203]>
	for <linuxppc-embedded@ozlabs.org>; Sun, 18 Nov 2007 18:56:19 +0100
Message-ID: <47407CCB.80503@chello.nl>
Date: Sun, 18 Nov 2007 18:56:27 +0100
From: Theo Gjaltema <gjalt007@chello.nl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: how to improve linux tcp/ip(UDP) efficiency on mpc8541 833Mhz.
References: <OF406A1338.BB8E4414-ON48257392.000CFC61-48257392.000F90D1@coship.com>
	<47398B44.2070902@anagramm.de>
In-Reply-To: <47398B44.2070902@anagramm.de>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

We use a 8250 and 8270 of which the performance is highly limited by the 
bandwidth of the memory to the very small internal cache.
I once modified a driver into a "polling" method polling the device 
every millisecond. The amount of messages processed trippled this way! 
On full speed the console could even be used for "normal" operation (in 
contrairy to the interrupt driver driver).
The penalties are obvious: When the bandwith used is low the delay for 
polled messages is higher and the CPU overhead is higher.

Succes,
   Theo.

Clemens Koller schreef:
> huangyun@coship.com schrieb:
>  > hi,everbody:
>  >       I have run linux-2.6.15 on my mpc8541 custom board. but when i test
>  > TSEC use UDP, i found it's efficinecy is lower.
>  > my test enviroment: i only run a UDP recieve program and not to handle data
>  > recieved. when i recevie 400Mbps data, 79% of MPC8541 have be consumed.
>  > so i think tcp/ip protocal have consume my mpc8541 resource.  i dont know
>  > how to improve tcp/ip code or TSEC driver(gianfar.c).
>  >       can somebody help me ?
>
> Hmm... you should first try one of the current kernels and check the
> performance there.
> For further details about linux networking, I recommend you to contact
> the guys at the netdev list, giving lots of details how you do your
> benchmarking and how your workload looks like.
>
> Regards,
>
> Clemens Koller
> __________________________________
> R&D Imaging Devices
> Anagramm GmbH
> Rupert-Mayer-Straße 45/1
> Linhof Werksgelände
> D-81379 München
> Tel.089-741518-50
> Fax 089-741518-19
> http://www.anagramm-technology.com
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>   
