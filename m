Date: Thu, 25 Oct 2001 09:11:52 -0400
From: Kent Borg <kentborg@borg.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Dying of First sti()
Message-ID: <20011025091152.D11285@borg.org>
References: <20011022162118.A13160@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011022162118.A13160@borg.org>; from kentborg@borg.org on Mon, Oct 22, 2001 at 04:21:18PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Oct 22, 2001 at 04:21:18PM -0400, Kent Borg wrote:
> I make it in init/main.c to the point where sti() is about to be
> called.  But I never get back from the sti() call.

I found my problem.  We had put the wrong value in bi_intfreq (and
bi_busfreq).  We were off by a mere factor of a million.  It meant
that the PIT was rolling over nearly instantly.  Oops.  Works *much*
better with a sensible value in there.


-kb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
