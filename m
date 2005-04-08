Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2A1E667B46
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Apr 2005 09:28:14 +1000 (EST)
Date: Fri, 8 Apr 2005 08:07:25 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050408110724.GG19449@logos.cnet>
References: <20050407120013.GF14822@logos.cnet>
	<BCEFJBPJCGFCNMMMIDBHGEGHCLAA.Joakim.Tjernlund@lumentis.se>
	<20050407193846.GE19449@logos.cnet>
	<19116173cb07648317c2a73a9c822c70@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19116173cb07648317c2a73a9c822c70@embeddededge.com>
Cc: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>,
	linuxppc-embedded@ozlabs.org
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


Hi Dan,

On Thu, Apr 07, 2005 at 10:09:58PM -0400, Dan Malek wrote:
> 
> On Apr 7, 2005, at 3:38 PM, Marcelo Tosatti wrote:
> 
> >Would be nice to have someone from 8xx team look into this?
> 
> I'll look into it and find some solution.  

What do you envision as another solution? 

We have two now: 

1) _tlbie() on update_mmu_cache() surrounded by CONFIG_8xx #ifdef 
Did you give up about it? 

2) jump directly from DataTLBMiss to fault handler. 
You seem to dislike it.

What else you think can be done? 

> I suspect it is an interaction with the previous TLB miss and the behavior
> of the dcbst TLB look up.  Perhaps, if we ensure the
> TLB entry is not valid at the time of the dcbst, it will work.

Note that the TLB entry is _not valid_ at the time of the dcbst:

BDI>rds 824
SPR  824 : 0x10011f05    268508933
BDI>rds 825
SPR  825 : 0x000001e0          480
BDI>rds 826
SPR  826 : 0x00001f00         7936 

bit 18 (valid bit) of SPR 826 is not set.

So even with the TLB invalid, dcbst misbehaves.

> This is why the tlbie() I added as a hack a long time
> ago made the "problem" disappear.  The other dcbxx
> instructions in the code work on already existing pages,
> while this one is a special case of a miss on a page
> that doesn't exist.
> 
> Thanks.
> 
> 	-- Dan
