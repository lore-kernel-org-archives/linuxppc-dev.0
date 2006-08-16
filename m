Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 81A73679E2
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 20:59:30 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 16 Aug 2006 12:59:25 +0200
To: Paul Mackerras <paulus@samba.org>
Subject: Re: PowerPC paxtest results w/ gcc-4.1
Message-ID: <20060816105925.GB21865@iram.es>
References: <17630.27174.711916.643790@cargo.ozlabs.ibm.com>
	<000301c6bf97$e9151e00$99dfdfdf@bakuhatsu.net>
	<17633.18057.778991.483461@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17633.18057.778991.483461@cargo.ozlabs.ibm.com>
Cc: 'Albert Cahalan' <acahalan@gmail.com>, debian-powerpc@lists.debian.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 15, 2006 at 01:59:05PM +1000, Paul Mackerras wrote:
> Matt Sealey writes:
> 
> > Book I compatible PowerPC's have had a "no-executable" bit in
> > the page protection flags since the dark ages.. see page 7-38
> > and 7-39 of the 'Programming Environments Manual for 32-Bit
> > Microprocessors'.. this document predates even the G3.
> 
> What are you referring to?  I have a copy of the PEM from pre-G3 days,
> and a copy that I downloaded just now, and neither of them have an N
> bit in the PTE (and yes I just looked carefully through pages 7-38 and
> 7-39).
> 
> There is an N bit in the segment register format, and that's what
> Albert is using.
> 
> > As far as the documentation goes, you can make the page
> > readable and writable to the LSU, but the N bit causes the
> > instruction fetch to cause a machine check. That's pretty
> > "not-executable" to me at least :)
> 
> A machine check is nasty, because it may not be recoverable...

I agree, but I don't know why you believe it would cause 
a machine check (0x200): from my docs, it is an ISI (0x400). 

BTW, there is one way to make pages non executable: mark
them as guarded, but it will have a significant cost in
terms of performance. 

I never understood why PTE entries waste 4 bits (WIMG)
for effectively very few valid combinations.

	Regards,
	Gabriel
