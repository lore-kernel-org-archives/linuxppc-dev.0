Return-Path: <gnomes@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk
 (7.3.c.8.2.a.e.f.f.f.8.1.0.3.2.0.9.6.0.7.2.3.f.b.0.b.8.0.1.0.0.2.ip6.arpa
 [IPv6:2001:8b0:bf32:7069:230:18ff:fea2:8c37])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D3ADC1A004A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 04:40:21 +1000 (EST)
Date: Tue, 23 Sep 2014 19:39:55 +0100
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: bit fields && data tearing
Message-ID: <20140923193955.2fb9cb14@alan.etchedpixels.co.uk>
In-Reply-To: <5421B9A6.5020408@hurleysoftware.com>
References: <20140712181328.GA8738@redhat.com>
 <54079B70.4050200@hurleysoftware.com>
 <1409785893.30640.118.camel@pasglop>
 <063D6719AE5E284EB5DD2968C1650D6D17487172@AcuExch.aculab.com>
 <1409824374.4246.62.camel@pasglop> <5408E458.3@zytor.com>
 <54090AF4.7060406@hurleysoftware.com> <54091B30.7080100@zytor.com>
 <5409D76D.2070203@hurleysoftware.com> <5409D9C0.7030403@zytor.com>
 <20140908185240.21f52ca0@alan.etchedpixels.co.uk>
 <540DEE6C.2060904@zytor.com> <540E3207.7090007@hurleysoftware.com>
 <20140911110411.2de01944@alan.etchedpixels.co.uk>
 <5411FFB6.2080702@hurleysoftware.com>
 <20140915002427.6ce18965@alan.etchedpixels.co.uk>
 <5421B9A6.5020408@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jakub Jelinek <jakub@redhat.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Tony Luck <tony.luck@intel.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 linux-alpha@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Laight <David.Laight@ACULAB.COM>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Miroslav Franc <mfranc@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > Yes - because if you think about it that tells you that nobody is hitting
> > it with the old code and it probably doesn't matter.
> 
> I don't understand this reply.

It's a matter of priorities. There are hundreds of potential security
holes turned up by scanners, 2,500+ filed bugs in kernel bugzilla alone.

Which matters more - fixing the bugs people hit or the ones that they
don't and which have a very high cost impact on other users ?

> Likewise, I'm pointing that byte-sized circular buffers will also be 
> corrupted under certain circumstances (when the head comes near the tail).

Yes. I believe the classic wording is "this problem has not been observed
in the field"
 
> 2. I'm not sure where you arrived at the conclusion that set_bit() et.al. is
> fast on x86. Besides the heavy-duty instructions (lgdt, mov cr0, etc), the
> bus-locked bit instructions are among the most expensive instructions in the
> kernel.

> I've attached a smoke test I use for lightweight validation of pty slave reads.
> If you run this smoke test under perf, almost every high-value hit is a
> bus-locked bit instruction. Check out canon_copy_from_read_buf() which performs
> the actual copy of data from the line discipline input buffer to the __user
> buffer; the clear_bit() is the performance hit. Check out cpu_idle_loop()...

And then go and instrument whether its the bit instructions or the cache
misses ?


If there is a significant performance improvement by spacing the fields
carefully, and you don't have other ordering problems as a result
(remembering that the compiler has a lot of re-ordering options provided
the re-ordering cannot be observed)

If that's the case then fine - submit a patch with numbers and the fields
spaced and quote the performance data.

Alan
