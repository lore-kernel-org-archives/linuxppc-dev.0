Return-Path: <rmcguire@uwbt.com>
Received: from mail19d.g19.rapidsite.net (mail19d.g19.rapidsite.net
	[204.202.242.120]) by ozlabs.org (Postfix) with SMTP id 2A5AC67C00
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Dec 2006 10:12:56 +1100 (EST)
Received: from mx101.stngva01.us.mxservers.net (198.173.112.38)
	by mail19d.g19.rapidsite.net (RS ver 1.0.95vs) with SMTP id
	4-0355018374 for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Dec 2006 18:06:15 -0500 (EST)
From: "Russell McGuire" <rmcguire@uwbt.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: MPC8360E Startup - CFG_INIT_RAM
Date: Mon, 11 Dec 2006 15:05:42 -0800
Message-ID: <000801c71d78$e28cae60$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <mailman.1727.1165862180.2346.linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Anybody,

I am porting U-boot to a new custom MPC8360E based board.
I have downloaded the GIT U-boot tree, and see that DENX has made an example
for the MPC8360E-MDS board, and it is an excellent start. <If anyone is
interested I have the new 83xx header files to support Rev 2.0 CPU's, only
about 10 extra lines>

My question lies with what value to place in the CFG_INIT_RAM address. 

I see that the example board has this mapped to dcache? I think... If so how
does one calculate what address dcache sits at?

Or would I be able to use the internal IMMR space multi-user QE ram?
My question is without dissecting the assembly at startup, does the IMMR get
remapped before or after the CFG_INIT_RAM is used.

The board has no external memory other than DDR, so I am going to have to
use something in the CPU.

Due to the massive amount of flash on our board <128M>, I cannot leave the
.text space at 0xFE00000. So I would prefer the IMMR be located at
0xF0000000 and flash be at 0xE0000000, this would leave room for future
expansion <maybe up to 256M>, if this is even related to early startup.

-Russ
