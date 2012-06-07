Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4F0A7B6FB4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2012 03:51:17 +1000 (EST)
Message-ID: <4FD0EA08.7040903@freescale.com>
Date: Thu, 7 Jun 2012 12:51:04 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Optimise the 64bit optimised __clear_user
References: <20120604175858.38dac554@kryten> <20120605120222.6722a3e3@kryten>
 <178E3BC0-C6E2-4E33-BA66-8144F192A151@kernel.crashing.org>
 <20120607030423.GA30053@drongo>
In-Reply-To: <20120607030423.GA30053@drongo>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: mikey@neuling.org, michael@ellerman.id.au,
 Anton Blanchard <anton@samba.org>, olof@lixom.net,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/06/2012 10:04 PM, Paul Mackerras wrote:
> On Wed, Jun 06, 2012 at 06:40:54PM +0200, Segher Boessenkool wrote:
>>> +err1;	dcbz	r0,r3
>>
>> There is no such instruction, you probably meant "dcbz 0,r3"?
> 
> There certainly is such an instruction, though it doesn't do exactly
> what a naive reader might expect.  Using 0 rather than r0 or %r0
> improves readability but makes no difference to the assembler or the
> cpu.

The assembler can't tell that you used r0 rather than 0, because that's
handled by the preprocessor, but it seems like a bug (or at least lax
error checking) that it accepts %r0 there, and that objdump decodes it
as "dcbz r0,r3" rather than "dcbz 0,r3".

It's also odd that objdump produces output containing "r3" (not %r3)
when the assembler won't directly accept it.

-Scott
