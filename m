Date: Tue, 23 Mar 2004 17:01:17 +0100
From: Marc Leeman <marc.leeman@barco.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI Memory mapping
Message-ID: <20040323160117.GN1446@smtp.barco.com>
Reply-To: Marc Leeman <marc.leeman@barco.com>
References: <20040316114030.GB7133@smtp.barco.com> <1079455175.4184.25.camel@localhost.localdomain> <20040322074833.GY7133@smtp.barco.com> <20040323111736.GJ1446@smtp.barco.com>
Mime-Version: 1.0
In-Reply-To: <20040323111736.GJ1446@smtp.barco.com>
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Any ideas what might go wrong since consistent mappings 'should' not
> have problems with caching...

OK, more tests.

I tried to make certain that cache was disabled for these pages by
including CONFIG_NOT_COHERENT_CACHE (which defaults back to

  consistent_alloc
instead of
  __get_free_pages

But we did not notice a difference. Adding a user space buffer of 2 Megs
that just got filled with a counter makes the DMA transfers OK (this
should have purged the cache I think).

But so does adding a delay of 1 second between 2 transfers.

Between two transfers, I even filled the kernel buffer inbetween with
0xCA in kernel space and in user space (by copying a user buffer into
the kernel buffer again).

The strange thing is that the second buffer is always corrupted with
seemingly 'old' data, at an offset of 4 words (32 bit) and this for only
24 words, the rest of the buffer is fine.

The common factor seems to be 'timing', but unfortunately, this does not
yet pinpoint the problem to either the DSP or the PPC side. Any
experienced insight or well educated guesses?

--
  Marc Leeman                          Hardware R&D Engineer
  Barco Controlrooms Division Noordlaan 5, B-8520 Kuurne (BE)
  Tel. +32 56 368 428        http://www.barcocontrolrooms.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
