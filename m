Return-Path: <stefan.nickl@kontron.com>
Received: from kom-mail1.kontron-modular.com (unknown [62.159.155.196])
	by ozlabs.org (Postfix) with ESMTP id 695E22BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Nov 2004 21:14:00 +1100 (EST)
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <1098984003.11434.12.camel@lucy.pep-kaufbeuren.de>
References: <1098984003.11434.12.camel@lucy.pep-kaufbeuren.de>
Content-Type: text/plain
Date: Thu, 18 Nov 2004 11:13:48 +0100
Message-Id: <1100772828.22636.15.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Subject: Re: All-ones problem with FCC1 on MPC8541
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2004-10-28 at 19:20 +0200, Stefan Nickl wrote:
> The packet sizes I receive look reasonable, but the buffers are
> filled only with 0xff. The same goes for sending, the contents
> of the buffers are OK (dhcp discover...), but when capturing
> the output on the other side with ethereal, the packet is again
> all 0xff.

To whom it may concern: We finally solved it!

>From what I can tell, it's a bug in both linuxppc-2.4 AND the manual.

It's all about the values of RIPTR and TIPTR in the FCC parameter RAM,
to work on the MPC8541/MPC8555 they must not assume the values that the
current public kernel sets them to, and what is suggested by the manual.

First the manual bug: "For best performance, it should be located in the
following address ranges: 0x3000-0x4000 or 0xB000-0xC000."

However, the "Internal Dual-Port Data RAM Memory Map" shows both of
these ranges as "Reserved" in the MPC8555 manual (different from the
MPC8560 manual). This is also not mentioned in the latest errata.


Next the linux bug: This is from cpm.h in the public kernel:

#ifdef CONFIG_8272
#define CPM_DATAONLY_SIZE       ((uint)(8 * 1024) - CPM_DATAONLY_BASE)
#define CPM_FCC_SPECIAL_BASE    ((uint)0x00009000)
#else
#define CPM_DATAONLY_SIZE       ((uint)(16 * 1024) - CPM_DATAONLY_BASE)
#define CPM_FCC_SPECIAL_BASE    ((uint)0x0000b000)
#endif

and this is from cpm.h in the metrowerks 8555 kernel:

#if (defined(CONFIG_8272) || defined(CONFIG_8555))
#define CPM_DATAONLY_SIZE       ((uint)(8 * 1024) - CPM_DATAONLY_BASE)
#define CPM_FCC_SPECIAL_BASE    ((uint)0x00009000)
#else
#define CPM_DATAONLY_SIZE       ((uint)(16 * 1024) - CPM_DATAONLY_BASE)
#define CPM_FCC_SPECIAL_BASE    ((uint)0x0000b000)
#endif

Note that little difference? :)

When the internal buffers are placed in the non-reserved region,
it just works.

Greetings,

-- 
Stefan Nickl
Kontron Modular Computers
