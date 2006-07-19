Return-Path: <linas@austin.ibm.com>
Received: from over.co.us.ibm.com (over.co.us.ibm.com [32.97.110.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 47F1567B87
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 05:24:41 +1000 (EST)
Received: from e3.ny.us.ibm.com (e3.pok.ibm.com [9.56.232.143])
	by bldfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6JIw93m014376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 14:58:09 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6JIw1XW001200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 14:58:02 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6JIw16M271906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 14:58:01 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6JIw1l9008738
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 14:58:01 -0400
Date: Wed, 19 Jul 2006 13:57:59 -0500
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: AltiVec in the kernel
Message-ID: <20060719185758.GN5905@austin.ibm.com>
References: <E40C6B7A-F2E8-4DB8-97D3-2CFF88C1D90A@kernel.crashing.org>
	<005701c6aa7c$632a48e0$99dfdfdf@bakuhatsu.net>
	<17597.8378.972640.464219@cargo.ozlabs.ibm.com>
	<20060719181047.GL5905@austin.ibm.com>
	<17598.30626.663773.229019@cargo.ozlabs.ibm.com>
	<1153334301.2546.40.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1153334301.2546.40.camel@johannes.berg>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: 'linuxppc-dev list' <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 19, 2006 at 08:38:21PM +0200, Johannes Berg wrote:
> On Thu, 2006-07-20 at 04:19 +1000, Paul Mackerras wrote:
> > Linas Vepstas writes:
> > 
> > > But perhaps, in principle, couldn't one run four independent streams 
> > > in parallel?  Thus, for example, on an SSL-enabled web server, one 
> > > could service multiple encryption/decryption threads at once. 
> > 
> > Generally that would work.  If one had 4 separate streams to compute a
> > SHA1 of, one could do all 4 at once with altivec.  It would have to be
> > 4 separate streams though, not 4 parts of a single stream.
> 
> I'd think it'd be pretty hard to get a real benefit from this because
> the data is going to come from 4 totally different places, hence you
> can't just load a single vector register and get data for all 4
> streams...

Dohh. Right. I actually thought that while writing the email, and then
it eveporated from my head before I hit the send button.  One would 
have to copy the incoming data into vectors, and the mem access latency
would probably overwhelm the performance gain (per "hot cache" as Paul
discussed).

--linas
