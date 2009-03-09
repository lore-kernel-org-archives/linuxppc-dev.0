Return-Path: <lebon@lebon.org.ua>
Received: from b-mail.com.ua (b-mail.com.ua [195.68.202.242])
	by ozlabs.org (Postfix) with ESMTP id 4B75ADE0AE
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 08:17:04 +1100 (EST)
Message-ID: <49B58779.9040905@lebon.org.ua>
Date: Mon, 09 Mar 2009 23:17:45 +0200
From: Mikhail Zolotaryov <lebon@lebon.org.ua>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc 4xx: DDR0_14[REDUC] decoded incorrectly
References: <49B54210.5040709@lebon.org.ua>
	<20090309171243.GA26415@zod.rchland.ibm.com>
In-Reply-To: <20090309171243.GA26415@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>> However, "1" is decoded as 64 bit (8 byte), "0" - as 32 bit (4 byte) bus  
>> by the kernel code. My understanding is this is not correct - patch  
>> attached.
>
> You are missing the Signed-off-by tag that is needed.
>
I'm sorry.

Signed-off-by: Mikhail Zolotaryov <lebon@lebon.org.ua>

> Aside from that, I'm curious if you found this just through inspection, or
> if you actually had a problem because of it.  Your fix seems correct, yet
> I've had no problems with my boards at all.
>

I'm actually working on custom PowerPC 440EPX board development here and 
have found the problem: without applying changes described, Linux 
detects memory size incorrectly and is unable to start. The rest of 
memory size computation process seems to be correct.

I have checked Sequoia evaluation board with U-Boot 2009.1 and confirm 
that original kernel code reported memory size correctly. So, for my 
understanding, if computation algorithm was wrong but result was correct 
- the problem is source data i.e. initial DDR configuration parameters 
loaded by U-Boot (please don't give a damn that memory size is always 
reported correctly by U-Boot - it's hard-coded constant there). I have 
checked Sequoia board schematics (DES0211_11_SCH_11.pdf, page 5, unit 
U1D) and noted that BankSel#1 is not connected, while bootloader memory 
configuration is (board/amcc/sequoia/sdram.c):
        mtsdram(DDR0_10, 0x00000300);
i.e. both Chip Selects used.

If I change this line to:
        mtsdram(DDR0_10, 0x00000100);
memory is accessible, patched kernel detects memory size correctly and 
kernel seems to be working well.

Please check my considerations, possibly it may be necessary to request 
additional information from board manufacturer.
