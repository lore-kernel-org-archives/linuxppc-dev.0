Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4AE1467A5E
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 11:11:37 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB90BWUG007366
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Dec 2006 19:11:32 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kB90BWDP197198
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Dec 2006 19:11:32 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kB90BWZ5000865
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Dec 2006 19:11:32 -0500
Date: Fri, 8 Dec 2006 18:11:30 -0600
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH]: powerpc documentation: Clarify why twi appears in the
	i/o	macros.
Message-ID: <20061209001130.GA13128@austin.ibm.com>
References: <20061206182922.GA17931@austin.ibm.com>
	<45770E44.30000@ru.mvista.com>
	<20061206194516.GD17931@austin.ibm.com>
	<45772700.2080708@ru.mvista.com>
	<20061206222246.GG17931@austin.ibm.com>
	<17784.54471.964452.513068@cargo.ozlabs.ibm.com>
	<177E9875-1C08-4EFF-A066-E33C6C94DD91@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <177E9875-1C08-4EFF-A066-E33C6C94DD91@kernel.crashing.org>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 08, 2006 at 10:54:56PM +0100, Segher Boessenkool wrote:
> >>+ * A data-dependent branch followed by an isync ensures that no
> >
> >I think it's potentially confusing to talk about data-dependent
> >branches when what the code does is a twi instruction.  Even if you
> >argue that a twi is a data-dependent branch (and I disagree with that,
> >since a trap is not a branch),
> 
> If you argue it is *not* a branch, where in the architecture
> documentation can we find any language that gives us the
> guarantee we depend on here?

How about this wording: "A data-dependent branch, or trap word, 
followed by an isync ensures that ..."

> >that wouldn't be obvious to a casual
> >reader of the code.

I was trying to understand why the spidernet driver seemed to 
behave in the crazy ways that it does, and I decided to scrutinize 
this code. Even if one is relatively familiar with the overall
powerpc architecture (as I am), the effect of the twi/isync 
was far from obvious, and left me scratching my head.

> >In other words, I don't think the comment
> >clarifies the situation very much.

Later on, I tripped over some text written by Segher, that
made a lightbulb go off in my head ... and thus I was motiviated
to plagiarizingly cut-n-paste it into here.  So this block of 
text clarified things a lot for me, it "hit the spot".

Now, what I don't know is how accurate it really is ... I don't
know if there aren't any strange deviations on 403 or 601 or 
any of the modern embedded processors, or whatever. But the text
certainly makes me beleive I now know what's going on. As a
service to the next person who scratches thier head in wonderment, 
we should have at least something written up here.

--linas
