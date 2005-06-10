Return-Path: <torvalds@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 85C1C67B1C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Jun 2005 04:52:36 +1000 (EST)
Date: Fri, 10 Jun 2005 11:54:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050610112907.7b566c91.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0506101149370.2286@ppc970.osdl.org>
References: <20050607012009.GB16387@gate.ebshome.net>
	<27777aec8e616a79f994dca2935e26a7@freescale.com>
	<Pine.LNX.4.58.0506100932240.2286@ppc970.osdl.org>
	<20050610112907.7b566c91.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: add 405EP cpu_spec entry
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



On Fri, 10 Jun 2005, Andrew Morton wrote:
> 
> >  I think Andrew continually thinks it is dropped, because the patch ends up 
> >  applying again, even though it got applied. So he keeps on re-sending it 
> >  over and over again ;)
> 
> Fault-tolerance!

Indeed.

However, I'm sure there's a better way. For example, something like "try
if the patch applied reversed" might be a good idea to at least mark it
for questioning.

Something like

	patch -spfR  --dry-run --fuzz=0 < patch
	if [ $? -eq 0 ]; then
		echo Hmm.. patch might be applied already
		exit 1
	fi

might be a starting point...

		Linus
