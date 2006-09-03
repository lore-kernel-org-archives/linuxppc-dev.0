Return-Path: <torvalds@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7D44C67BC9
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Sep 2006 05:29:31 +1000 (EST)
Date: Sun, 3 Sep 2006 12:29:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Please pull powerpc.git 'merge' branch
In-Reply-To: <44FB2BAF.1080509@ru.mvista.com>
Message-ID: <Pine.LNX.4.64.0609031227220.27779@g5.osdl.org>
References: <17654.26321.851991.285528@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0609031213310.27779@g5.osdl.org>
	<44FB2BAF.1080509@ru.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Sun, 3 Sep 2006, Sergei Shtylyov wrote:
>
> Linus Torvalds wrote:
> 
> > I wrote a sparse extension that warns if an initializer tries to initialize
> > the same entry multiple times.
> 
>    Ugh, I expected the C compiler to catch this... :-/

Yeah, me too. The reason I wrote the sparse logic to catch it was that I 
got another patch where I noticed what was going on, and the author said 
he had compile-tested it without any warnings. So gcc obviously does _not_ 
warn about the obvious error.

>    Cut and paste error, should be .read_reg8...

Yeah, the fix is obvious, but somebody who has more knowledge about this 
particular piece of code and how it would affect things should test that 
the bug wasn't hiding somethign else on a piece of hardware that is 
relevant to that initializer (which I don't know what it would be).

		Linus
