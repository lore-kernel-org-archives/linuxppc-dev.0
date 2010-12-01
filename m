Return-Path: <sboyd@codeaurora.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
	[199.106.114.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wolverine01.qualcomm.com",
	Issuer "VeriSign Class 3 Secure Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id CBBC5B70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Dec 2010 07:21:09 +1100 (EST)
Message-ID: <4CF6AE04.6030201@codeaurora.org>
Date: Wed, 01 Dec 2010 12:20:20 -0800
From: Stephen Boyd <sboyd@codeaurora.org>
MIME-Version: 1.0
To: Daniel Walker <dwalker@codeaurora.org>, Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] drivers: char: hvc: add arm JTAG DCC console support
References: <1291145141-18301-1-git-send-email-dwalker@codeaurora.org>	
	<4CF5DD63.40803@codeaurora.org>
	<1291229696.14404.39.camel@c-dwalke-linux.qualcomm.com>
In-Reply-To: <1291229696.14404.39.camel@c-dwalke-linux.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Mike Frysinger <vapier@gentoo.org>,
	Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>,
	linux-arm-msm@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/01/2010 10:54 AM, Daniel Walker wrote:
> Are you talking about __dcc_getstatus only? I don't think adding
> volatile is going to hurt anything, if not having it causes problems.
>

Just marking __dcc_getstatus volatile gives me

00000038 <hvc_dcc_get_chars>:
  38:   ee10fe11        mrc     14, 0, pc, cr0, cr1, {0}
  3c:   1afffffd        bne     38 <hvc_dcc_get_chars>
  40:   ee103e15        mrc     14, 0, r3, cr0, cr5, {0}
  44:   e3a00000        mov     r0, #0  ; 0x0
  48:   e6ef3073        uxtb    r3, r3
  4c:   ea000004        b       64 <hvc_dcc_get_chars+0x2c>
  50:   ee10ce11        mrc     14, 0, ip, cr0, cr1, {0}
  54:   e31c0101        tst     ip, #1073741824 ; 0x40000000
  58:   012fff1e        bxeq    lr
  5c:   e7c13000        strb    r3, [r1, r0]
  60:   e2800001        add     r0, r0, #1      ; 0x1
  64:   e1500002        cmp     r0, r2
  68:   bafffff8        blt     50 <hvc_dcc_get_chars+0x18>
  6c:   e12fff1e        bx      lr

Seems the compiler keeps the value of __dcc_getchar() in r3 for the
duration of the loop. So we need to mark that one volatile too. I don't
think __dcc_putchar() needs to be marked volatile but it probably
doesn't hurt.

>
> We could maybe drop the looping for TX, but RX has no C based looping
> even tho for v7 it's recommended that we loop (presumably for v6 it's
> not recommended).
>

Definitely for TX since it seems like a redundant loop, but I agree RX
code has changed. Instead of

If RX buffer full
Poll for RX buffer full
Read character from RX buffer

we would have

If RX buffer full
Read character from RX buffer

which doesn't seem all that different assuming the RX buffer doesn't go
from full to empty between the If and Poll steps. Hopefully Tony knows more.

> Like this?
>
> 	for (i = 0; i < count; ++i) {
>
> 		if (__dcc_getstatus() & DCC_STATUS_RX)
> 			buf[i] = __dcc_getchar();
> 		else
> 			break;
> 	}
>
> It's a micro clean up I guess ..

Yes, it's much clearer that way.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
