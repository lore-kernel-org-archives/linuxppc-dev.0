Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id A6F2E679E7
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 23 May 2005 16:33:45 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j4N6cXmP017816
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 23 May 2005 09:38:35 +0300 (EEST)
Message-ID: <429177E8.5070701@intracom.gr>
Date: Mon, 23 May 2005 09:27:52 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <20050520141244.GD24923@logos.cnet>
	<e503cf4ab6d2d389b29474561048f2f2@embeddededge.com>
	<20050520175152.GB26221@logos.cnet>
	<5d184282e7d324fb009b8dcf6e6f967d@embeddededge.com>
	<20050521222713.GA28813@logos.cnet>
In-Reply-To: <20050521222713.GA28813@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFT] 8xx cpm_hostalloc patch was: allow coherent DMA API to
 work before main page allocator is set up
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Marcelo Tosatti wrote:
> Can someone with 8xx using the cpm_uart driver please test 
> the attached patch? It should avoid corruption of the pinned
> 8Mbyte CONFIG_PIN_TLB entry, as noted by Dan. 
> 

You shouldn't have these discussions on the weekend :)

I'm the culprit of the code in question.

This is the second take of the code. The hack with the 'if' was
not actually in the first edition, since I had the hostalloc
function working properly before initialization by using the
remainder of the bootpage, as a backup memory area, for when
the mm is not yet ready.

Somewhere along the way, it fell through the cracks.

IMHO that's the proper way to fix it.

There were some objection on that however.

Regards

Pantelis
