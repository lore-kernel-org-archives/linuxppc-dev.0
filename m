Message-ID: <40A4D459.2020603@intracom.gr>
Date: Fri, 14 May 2004 17:14:49 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Dan Malek <dan@embeddededge.com>, Wolfgang Denk <wd@denx.de>,
	sanjeevr@myw.ltindia.com
Subject: Re: [PATCH] Driver for FECs on motorola DUET (87x/88x)
References: <JPEALJAFNGDDLOPNDIEEKEHFCIAA.joakim.tjernlund@lumentis.se>
In-Reply-To: <JPEALJAFNGDDLOPNDIEEKEHFCIAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

>>Hi there,
>>
>>After our little talk in IRC I've ported the driver to 2.6
>>and have gotten as far as the loading of init (which promptly crashes).
>>
>>I think I am very near to making it work...
>>
>>I have a BDI2000 and I'm not afraid to use it, but I don't know
>>what to look for?
>>
>>Any mm hackers over there have any idea?
>>
>
>To start with, I think you should fix the Machine Check
>exception in head_8xx.S to get proper error reporting.
>I think it should be:
>	. = 0x200
>MachineCheck:
> 	EXCEPTION_PROLOG
> 	mfspr	r4,DAR
> 	stw	r4,_DAR(r11)
> 	mfspr	r5,DSISR
> 	stw	r5,_DSISR(r11)
> 	addi	r3,r1,STACK_FRAME_OVERHEAD
> 	EXC_XFER_EE(0x200, MachineCheckException)
>
>Does init crash or just hang?
>If it hangs, it may be a TLB problem.
>
>
>
>
It crashes and the backtrace seems sane.

Regards

Pantelis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
