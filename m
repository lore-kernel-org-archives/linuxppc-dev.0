Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 02C0C679E9
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Mar 2006 06:33:23 +1100 (EST)
In-Reply-To: <3E10742C-61F9-417C-A191-C0C8C46A4529@kernel.crashing.org>
References: <20060303135717.GA5707@suse.de> <20060303165253.GA6494@suse.de>
	<20060303191633.GA7792@suse.de>
	<3E10742C-61F9-417C-A191-C0C8C46A4529@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3DBB345E-9E55-4A88-8A73-7A35AA20D7D3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] force stackpointer alignment in 64bit kernel
Date: Fri, 3 Mar 2006 20:32:29 +0100
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>  	/* Make sure we are running in 64 bits mode */
>> +	addi	r1,r1,16
>> +	rlwinm	r1,r1,0,0,28
>>  	bl	.enable_64b_mode
>
> Not addi +16, not -16, just no addi at all...

Not rlwinm either, GPR1 can potentially be at >= 4GB
(of course we'd probably hit other problems then, but hey).
So please use rldicr or similar.


Segher
