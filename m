Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5E036DDF99
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 11:41:03 +1000 (EST)
In-Reply-To: <1214215255.8011.257.camel@pasglop>
References: <20080623094539.GA16685@lisas.de>
	<1214215255.8011.257.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fbe00e06a9ca1745126a5b9cb9849290@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: starting with 2.6.26-rc1 cell_defconfig fails on QS22
Date: Tue, 24 Jun 2008 03:40:36 +0200
To: benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Finalizing device tree... using OF tree (promptr=0e1004c4)
>>
>>
>> ( 700 ) Program Exception [ e1004c4 ]
>
> The program check exception happens at 0xe1004c4 ? That looks like the
> OF entry point (promptr)... could it be possible that it got corrupted
> somewhat ? The only thing I see above there would be the stack but
> I fail to see how it would use that much...

I don't know what this [ e1004c4 ] is, if I read the current public
SLOF code (for JS2x) correctly it seems to be whatever was on the
stack (or just below the stack) below the error code that was thrown.
Maybe some errors put something interesting there, dunno.

/me looks deeper...  Nastiness :-)  So, a decrementer exception gives
the current decrementer value as reason code; an external exception
reads some BE-specific registers (on any system!); and all other
exceptions use whatever was in GPR4?

Anyway, the register dump shows:

>>     CR / XER           LR / CTR          SRR0 / SRR1        DAR / 
>> DSISR
>>         80000022   00000000014073e8   000000000189e99c 
>> 0000000000000000
>> 0000000020000000   0000000001400000   9000000000083000 00000000

so SRR0 is 0189e99c, which is where the exception happened.  Does
objdump show what's going on?  It seems to happen almost immediately
after the kernel starts, given the CTR value.  If the SRR0 address
doesn't help, the LR address should.

>> I have tried it with gcc-3.4.2, gcc-4.1.1 and gcc-4.2.4.

The binutils version is more interesting here.  2.18?


Segher
