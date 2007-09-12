Return-Path: <torvalds@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CCD73DDDD5
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 12:17:48 +1000 (EST)
Date: Tue, 11 Sep 2007 19:17:42 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: add new required termio functions
In-Reply-To: <8018.1189562679@neuling.org>
Message-ID: <alpine.LFD.0.999.0709111915350.16478@woody.linux-foundation.org>
References: <8018.1189562679@neuling.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	Alan Cox <alan@redhat.com>, akpm@linux-foundation.org,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Wed, 12 Sep 2007, Michael Neuling wrote:
>
> The "tty: termios locking functions break with new termios type" patch
> (f629307c857c030d5a3dd777fee37c8bb395e171) breaks the powerpc compile.

Really?

It shouldn't. The use of kernel_termios_to_user_termios_1() is conditional 
on the architecture having a define for TCGETS2, and I think they match 
up. I see:

	[torvalds@woody linux]$ git grep -l kernel_termios_to_user_termios_1 include | wc -l
	10
	[torvalds@woody linux]$ git grep -l TCGETS2 include | wc -l
	10

and in neither case is ppc in that list of architecures.

So maybe you just read the patch without actually testing whether it 
actually broke powerpc?

Or is something subtler going on?

			Linus
