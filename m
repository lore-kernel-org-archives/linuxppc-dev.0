Return-Path: <appro@fy.chalmers.se>
Received: from anubis.medic.chalmers.se (anubis.medic.chalmers.se
	[129.16.30.218]) by ozlabs.org (Postfix) with ESMTP id 4A80367CAD
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Jul 2005 07:50:07 +1000 (EST)
Message-ID: <42CB0084.4000307@fy.chalmers.se>
Date: Tue, 05 Jul 2005 23:49:56 +0200
From: Andy Polyakov <appro@fy.chalmers.se>
MIME-Version: 1.0
To: openssl-dev@openssl.org
References: <19EE6EC66973A5408FBE4CB7772F6F0A02C8770E@ltnmail.xyplex.com>	
	<4dd15d1805070508312427a0ba@mail.gmail.com>	
	<4dd15d1805070508451b76afae@mail.gmail.com>	
	<4dd15d1805070509361339d08e@mail.gmail.com>	
	<4dd15d1805070510015cdaac04@mail.gmail.com>	
	<4dd15d18050705132178b5fd92@mail.gmail.com>
	<4dd15d180507051425589dbf69@mail.gmail.com>
In-Reply-To: <4dd15d180507051425589dbf69@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PPC bn_div_words routine rewrite
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Okay, having actually did what Andy suggested, i.e. the one liner fix
> in the assembly code, bn_div_words returns the correct results.

Note that the final version, one committed to all relevant OpenSSL 
branches since couple of days ago and one which actually made to just 
released 0.9.8, is a bit different from originally suggested one-line 
fix, see for example http://cvs.openssl.org/chngview?cn=14199.

> At this point, my conclusion is, up to openssl-0.9.8-beta6,  the ppc32
> bn_div_words routine generated from crypto/bn/ppc.pl is still busted.

Yes. Though it should be noted that 0.9.8 was inadvertently avoiding the 
bug condition. Recall that original problem report was for 0.9.7.

> Why do you signal an overflow condition when it appears functions that
> call bn_div_words do not check for overflow conditions?

That's question to IBM. By the time they submitted the code, I've 
explicitly asked what would be appropriate way to generate *fatal* 
condition at that point, i.e. one which would result in a core dump, and 
it came out as division by 0 instruction. By that time I had no access 
to any PPC machine and had to just go with it. Now it actually came as 
surprise that division by 0 does not raise an exception, but silently 
returns implementation-specific value... A.
