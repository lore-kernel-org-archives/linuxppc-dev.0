Return-Path: <lebon@lebon.org.ua>
Received: from b-mail.com.ua (b-mail.com.ua [195.68.202.242])
	by ozlabs.org (Postfix) with ESMTP id A5D58DE050
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 07:56:20 +1100 (EST)
Message-ID: <49B6D427.5050600@lebon.org.ua>
Date: Tue, 10 Mar 2009 22:57:11 +0200
From: Mikhail Zolotaryov <lebon@lebon.org.ua>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] PowerPC 440EPx/GRx fix memory size calculation
References: <20090310195013.GA27835@ru.mvista.com>
In-Reply-To: <20090310195013.GA27835@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Valentine Barshak wrote:
> According to the AMCC 440EPX/GRX user manual,
> the Chip Select width is always fixed at 1 bit no matter
> what is actually read from register DDR_10.

Well, from my point of view original kernel code is correct in this part.

Adding one bit into memory address means multiplying memory size by 2 
i.e. cs=2. The question is: is Chip Select bit used in memory address. 
ChipSelect input of memory chip enables or disabled it, so if we have 
only one BankSel installed/connected (DDR0_10[22:23] is 01 or 10) 
there's no need to use Chip Select bit in an address. On the contrary, 
if both BankSel lines are connected (DDR0_10[22:23] is 11), to let 
memory controller know which memory rank to use, Chip Select bit is 
added into memory address. (and yes, if DDR0_10[22:23] is 00 - no ranks 
installed, memory size is 0, cs=0)

Original kernel code use exactly the same logic as I described above. 
Please suggest if it's wrong.
