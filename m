Message-ID: <3AC1825E.E61C485A@mvista.com>
Date: Wed, 28 Mar 2001 01:19:10 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Jones Madhuri <madhuri_jones@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: What does instruction LA mean?
References: <20010328053251.30486.qmail@web13605.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jones Madhuri wrote:

> I am novice in Power PC assembly code and I am trying
> compile in following code (written by someone else)
> into head_8xx.S.

Novice or otherwise, you shouldn't be placing any code in
head_8xx.S.  It's a guarantee you won't get Linux to boot.


> mfspr r3, IC_CST
> LA r4, IC_CST_LEN
>
> However the hardhat assembler doesn't understand the
> mnemonic LA,

Because there is no such instruction.  It looks like a
macro that will result in the two instruction pair:
	lis	r4, IC_CST_LEN@h
	ori	r4, r4, IC_CST_LEN@l

You shouldn't be messing around with those cache
management registers......


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
