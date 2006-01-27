Return-Path: <dave@hiauly1.hia.nrc.ca>
Received: from hiauly1.hia.nrc.ca (hiauly1.hia.nrc.ca [132.246.100.193])
	by ozlabs.org (Postfix) with ESMTP id 57C7468AA8
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jan 2006 12:03:19 +1100 (EST)
Message-Id: <200601270028.k0R0STBB021468@hiauly1.hia.nrc.ca>
Subject: Re: [parisc-linux] Re: [PATCH 3/6] C-language equivalents of
To: grundler@parisc-linux.org (Grant Grundler)
Date: Thu, 26 Jan 2006 19:28:29 -0500 (EST)
From: "John David Anglin" <dave@hiauly1.hia.nrc.ca>
In-Reply-To: <20060126230443.GC13632@colo.lackof.org> from "Grant Grundler" at
	Jan 26, 2006 04:04:43 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
	linux-ia64@vger.kernel.org, spyro@f2s.com, ak@suse.de,
	dhowells@redhat.com, linuxppc-dev@ozlabs.org, gerg@uclinux.org,
	sparclinux@vger.kernel.org, uclinux-v850@lsi.nec.co.jp,
	ysato@users.sourceforge.jp, takata@linux-m32r.org,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	grundler@parisc-linux.org, torvalds@osdl.org,
	ink@jurassic.park.msu.ru, mita@miraclelinux.com,
	chris@zankel.net, dev-etrax@axis.com, ultralinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxsh-dev@lists.sourceforge.net,
	linux390@de.ibm.com, parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Yeah, about the same for parisc.
> 
> > Clearly the smallest of the lot with the smallest register pressure,
> > being the best candidate out of the lot, whether we inline it or not.
> 
> Agreed. But I expect parisc will have to continue using it's asm
> sequence and ignore the generic version. AFAIK, the compiler isn't that
> good with instruction nullification and I have other issues I'd
> rather work on.

I looked at the assembler code generated on parisc with 4.1.0 (prerelease).
The toernig code is definitely inferior.  The mita sequence is four
instructions longer than the arm sequence, but it didn't have any branches.
The arm sequence has four branches.  Thus, it's not clear to me which
would perform better in the real world.  There were no nullified instructions
generated for any of the sequences.  However, neither is as good as the
handcraft asm sequence currently being used.

Dave
-- 
J. David Anglin                                  dave.anglin@nrc-cnrc.gc.ca
National Research Council of Canada              (613) 990-0752 (FAX: 952-6602)
