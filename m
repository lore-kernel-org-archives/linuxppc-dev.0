Return-Path: <dan@embeddedalley.com>
Received: from smtp102.biz.mail.re2.yahoo.com (smtp102.biz.mail.re2.yahoo.com
	[68.142.229.216]) by ozlabs.org (Postfix) with SMTP id C4E3267BE8
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Dec 2006 04:30:13 +1100 (EST)
In-Reply-To: <B38E3DDE-A18F-4319-A968-B0C22C001391@kernel.crashing.org>
References: <20061213190408.1d4ddd93.kim.phillips@freescale.com>
	<B38E3DDE-A18F-4319-A968-B0C22C001391@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <58E9B419-8FFE-4191-B384-A2F7C22BCAFA@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
Date: Fri, 15 Dec 2006 12:23:46 -0500
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 15, 2006, at 11:09 AM, Kumar Gala wrote:

>
>> +	if (machine_is(mpc83xx))
>> +		of_platform_bus_probe(NULL, NULL, NULL);
>> +
>
> Does this every get called, meaning does anything match machine_is
> (mpc83xx)?


I truly dislike this "machine_is" method.  Other architectures
do this and it becomes a real PITA.  It seems to evolve
into something that never has the proper, useful granularity.
Surprisingly, it often ends up as a guarantee you can't boot
common kernels on similar boards, which is what
I suspect you are trying to achieve.

This is a case where your board specific initialization
should call this, or fill in a ppc_md indirect pointer that
if set is called at the proper time.


Thanks.

	-- Dan
