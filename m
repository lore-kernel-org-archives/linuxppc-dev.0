Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 995A2689C0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Jan 2006 01:21:23 +1100 (EST)
In-Reply-To: <1137664156.8471.16.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0601190057130.8484-100000@gate.crashing.org>
	<1137664156.8471.16.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0D215BB4-D75D-439C-BB33-4880315C1191@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: remove useless spinlock from mpc83xx watchdog
Date: Thu, 19 Jan 2006 08:21:14 -0600
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, wim@iguana.be,
	LKML List <linux-kernel@vger.kernel.org>,
	"Linuxppc-Embedded \(\(E-Mail\)\)" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jan 19, 2006, at 3:49 AM, Alan Cox wrote:

> On Iau, 2006-01-19 at 00:58 -0600, Kumar Gala wrote:
>> Since we can only open the watchdog once having a spinlock to protect
>> multiple access is pointless.
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>
> NAK
>
> This is a common mistake.
>
> open is called on the open() call and is indeed in this case 'single
> open', but file handles can be inherited and many users may have  
> access
> to a single file handle.
>
> eg
>
> 	f = open("/dev/watchdog", O_RDWR);
> 	fork();
> 	while(1) {
> 		write(f, "Boing", 5);
> 	}
>
> Alan

Thanks, you learn something new every day.

- kumar
