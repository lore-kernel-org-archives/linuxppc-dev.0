Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id CC97B679E8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 May 2005 08:03:36 +1000 (EST)
Date: Mon, 23 May 2005 15:03:22 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: ming lei <mlei30@yahoo.com>
Message-ID: <20050523150322.A17066@cox.net>
References: <20050523205558.28957.qmail@web61022.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050523205558.28957.qmail@web61022.mail.yahoo.com>;
	from mlei30@yahoo.com on Mon, May 23, 2005 at 01:55:58PM -0700
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MMUCR on ppc440 GP/GX
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, May 23, 2005 at 01:55:58PM -0700, ming lei wrote:
> Hi,
> 
> I have problem on running system with linuxppc
> 2.4.19(ppc440GP/GX) regarding MMU Control
> Register(MMUCR).
> 
> I checked the code in arch/ppc/ there is no code
> setting or unsetting bit 12(DULXE) or bit 13(IULXE),
> but somehow these two bits got changed during boot
> process.
> 
> Question 1:
> Does CPU or other hardware change these two bits? If
> linux code doesnt set these two bits initiallt, what's
> the default value?  Or I miss something in the code
> that may change these two bits?
> 
> Question 2:
> For current 2.4.19 PPC440 implementation, there is no
> special handling for this kind of DataStorage
> exception, is it possible for the user code to stuck
> in this exception forever if these two bits got set in
> MMUCR and the user code calls icbi instruction?
> 
> I did a simple test on head_440.S so whenever the
> DataStorage exception happens, in DataStorage assmbly
> code, I clear these two bits in MMUCR, but somehow
> these two bits got set mysteriourly in next exception
> with error_code 0x200000(got from ESR DLK bits).
> What's happening here?

Your kernel revision is very ancient. The problem here is that
you are trying to use _very_ early PPC440 core code I released.
It's filled with critical bugs that were fixed over time. The MMUCR
issue was fixed almost 3 years ago, in fact.

Your best solution is to run a more recent kernel.  If that's
not possible, then I suggest you backport all the PPC440
related code from a more recent kernel into your old kernel
base.

-Matt
