Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D56DA679F5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 04:52:54 +1000 (EST)
Date: Sat, 7 May 2005 18:47:39 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050507214739.GF16996@logos.cnet>
References: <20050506154539.GA6452@logos.cnet>
	<52dc3ae70f883699b1e48b7d742afcaf@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52dc3ae70f883699b1e48b7d742afcaf@embeddededge.com>
Cc: Joakim Tjernlund <joakim.tjernlund@lumentis.se>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: How to fix 8xx dcbst bug?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, May 07, 2005 at 09:10:17PM -0400, Dan Malek wrote:
> 
> On May 6, 2005, at 11:45 AM, Marcelo Tosatti wrote:
> 
> >
> >Hi Dan,
> >
> >So, restarting this conversation...
> 
> One of the things I don't want to lose sight of during
> all of this is the real performance problem in 2.6.
> Your test results show there is something that needs
> attention, regardless of using pinned entries.  We
> need to continue some of this investigation, it
> affects all processors.

True.

Follows some useful data: 

"itlb-content-before" and "itlb-content-after" are dumps of TLB cache
content before and after "sys_read()", for both v2.4 and v2.6.

The "diff" output shows which TLB's have been faulted in:

[marcelo@logos itlb]$ diff -u 24-itlb-content-before.txt 24-itlb-content-after.txt  
| grep SPR | grep 816 | grep "+"
+SPR  816 : 0x0ffe800f    268337167
+SPR  816 : 0x0ffeb00f    268349455
+SPR  816 : 0xc009e01f  -1073094625
+SPR  816 : 0xc009d01f  -1073098721
+SPR  816 : 0xc000301f  -1073729505
+SPR  816 : 0xc009c01f  -1073102817

[marcelo@logos itlb]$ diff -u 24-itlb-content-before.txt 24-itlb-content-after.txt  
| grep SPR | grep 818 | grep "+"  | wc -l
6

Now v2.6:

[marcelo@logos itlb]$ diff -u 26-itlb-before.txt 26-itlb-after.txt  
| grep 816 | grep SPR | grep "+"
+SPR  816 : 0x0feda16f    267231599
+SPR  816 : 0xc004b17f  -1073434241
+SPR  816 : 0xc004a17f  -1073438337
+SPR  816 : 0x0ff7e16f    267903343
+SPR  816 : 0x1001016f    268501359
+SPR  816 : 0xc000217f  -1073733249
+SPR  816 : 0xc001617f  -1073651329
+SPR  816 : 0xc002e17f  -1073553025
+SPR  816 : 0xc010e17f  -1072635521
+SPR  816 : 0xc002d17f  -1073557121
+SPR  816 : 0xc010d17f  -1072639617
+SPR  816 : 0xc000c17f  -1073692289
+SPR  816 : 0xc000317f  -1073729153

[marcelo@logos itlb]$ diff -u 26-itlb-before.txt 26-itlb-after.txt  
| grep 816 | grep SPR | grep "+" | wc -l
13

So, for sys_read() v2.6 i-cache translation footprint is about 100% 
more than v2.4.  

I suspect that actual cache footprint is higher, too.
