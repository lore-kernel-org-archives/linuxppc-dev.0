Return-Path: <torvalds@linux-foundation.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.24])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 84792DDDEE
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 18:20:01 +1100 (EST)
Date: Sun, 28 Jan 2007 23:13:09 -0800 (PST)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
In-Reply-To: <1170054495.6521.1.camel@Homer.simpson.net>
Message-ID: <Pine.LNX.4.64.0701282310120.3611@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
	<20070127174230.GN6017@stusta.de> <20070128133344.214070@gmx.net>
	<1170051963.6454.7.camel@Homer.simpson.net>
	<20070128224834.37482553.akpm@osdl.org>
	<1170054495.6521.1.camel@Homer.simpson.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
	linux-ide@vger.kernel.org, petero2@telia.com,
	linux-kernel@vger.kernel.org, livio@eecg.toronto.edu,
	Adrian Bunk <bunk@stusta.de>, B.Zolnierkiewicz@elka.pw.edu.pl,
	linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org,
	gd@spherenet.de, cijoml@volny.cz, ttb@tentacle.dhs.org,
	rml@novell.com, Uwe Bugla <uwe.bugla@gmx.de>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Mon, 29 Jan 2007, Mike Galbraith wrote:
> 
> Unfortunately, I'm git impaired.  I am rummaging as we speak though.

Ok, I'm personally heading to bed, but it rally should be as simple as

 - get the git tree in the first place
 - do

	git bisect good v2.6.19
	git bisect bad v2.6.20-rc2
	.. it will pick a point for you to try ..
	.. compile, boot, test ..

	"git bisect {good|bad}" depending on results

 - until (found)

(Of course, you should check that -rc2 really is bad to make sure. I think 
that's what Uwe reported, though. And I don't think we've done anything 
after -rc2 that could impact this, so I don't doubt it).

		Linus
