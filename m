Return-Path: <jonmasters@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.207])
	by ozlabs.org (Postfix) with ESMTP id 33F752BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Oct 2004 01:48:08 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 43so214661wri
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Oct 2004 08:48:07 -0700 (PDT)
Message-ID: <35fb2e5904102608487acce066@mail.gmail.com>
Date: Tue, 26 Oct 2004 16:48:06 +0100
From: Jon Masters <jonmasters@gmail.com>
To: Peter Ryser <peter.ryser@xilinx.com>
In-Reply-To: <417DE312.6070405@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <1098701468l.31592l.0l@ipnnarval> <417D2B5E.8050200@xilinx.com>
	<35fb2e59041025140776cfe174@mail.gmail.com>
	<417DE312.6070405@xilinx.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: uboot and ppc405
Reply-To: jonathan@jonmasters.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 25 Oct 2004 22:39:30 -0700, Peter Ryser <peter.ryser@xilinx.com> wrote:

jcm>> btw Peter, I've been moaning about the weird interrupt behaviour of
jcm>> the SysACE on e.g. the Memec board for some time (see archives for
jcm>> various other people's experiences too) - and I've spoken to several
jcm>> folks at Xilinx without getting very far. If there's a fundamental
jcm>> problem then it probably makes sense for us to help get it fixed.

> Hmm, I'm not aware of any interrupt problems with System ACE CF.

It issues an extra interrupt after each sector write on our hardware,
in what seems to be a reasonably reproducible but not entirely
predictable fashion. This is after the interrupt we expect to get on
sector completion - it causes the Monta driver to go belly up because
it has no handling to check for interrupt on QUEUE_EMPTY or similar
error conditions.

I have every confidence that it works on the ML300, just not on other
boards, including both the Memec board and our in house prototypes.
Since it's not a major issue right now to have good performance from
the SysACE (just a reliable driver), I've created the patch I posted
previously to use polled IO instead.

> There is now a MVL preview kit for the Memec board. You might want to
> try it out and see whether the problems you observe persist.

Is this the one which doesn't actually use the SystemACE for a filesystem?

> Looking at the postings back in April I can only say that I never saw
> any similar problems.

Others have done so. I'll check with the hardware guys and see if I
can't send you a simple hardware case that falls over at some point -
I'm slightly constrained to release hardware designs and so on until
after this thing is ready to ship.

> The implementation of System ACE CF functionality in U-Boot is written
> for polled operation. In that case Stephen Williams wrote the actual
> driver and we decided not to publish our own driver but reuse his.

So it probably doesn't use the Xilinx HAL, that can only be a good thing :-)

Jon.
