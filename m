Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 79FEB67A6F
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Apr 2005 01:58:47 +1000 (EST)
In-Reply-To: <20050404191718.GA30281@logos.cnet>
References: <20050404191718.GA30281@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ba633c3356ff1ec71f53d4a0998132ff@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 5 Apr 2005 11:58:17 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Paul Mackerras <paulus@samba.org>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: 8xx v2.6 TLB problems and suggested workaround
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Apr 4, 2005, at 3:17 PM, Marcelo Tosatti wrote:

> Problem is that the "dcbst" instruction will, _sometimes_ (the 
> failure/success rate is about 1/4
> with my test application) fault as a _write_ operation on the data.

Oh, geeze .... It's all coming back to me now ....

The 8xx cache operations don't always operate as defined in the PEM.
There are likely to be some archive discussions within the Freescale
knowledge data base that describe the different behaviors I've seen
with the chip variants and revisions.  I can't find any of those e-mail
discussions, so I'll try to recall from memory.

The PEM cache instructions are all implemented in a microcode that
uses the 8xx unique cache control SPRs.  Depending upon the state
of the cache and MMU, it seems in some cases the EA translation is
subject to a "normal" protection match instead of a load operation 
match.

The behavior of these operations isn't consistent across all of the 8xx
processor revisions, especially with early silicon if people are still
using those.  During conversations with Freescale engineers, it seems
the only guaranteed operation was to use the 8xx unique SPRs, but
I think I only did that in 8xx specific functions.

We have way too much code in the TLB exception handlers already,
so let's just try a tlbia of the EA in the update_mmu_cache, with an 
#ifdef
for the 8xx.  It seems if the dcbst causes a TLB miss during execution,
it does the right thing.  We may want to make the dcbxxx instructions 
some
kind of macro, so on 8xx we can include such operations in otherwise
"standard" software.

Thanks for the great work!


	-- Dan
