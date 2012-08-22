Return-Path: <ananth@in.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e6.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 530772C007D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2012 18:32:34 +1000 (EST)
Received: from /spool/local
 by e6.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Wed, 22 Aug 2012 04:32:30 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 7315D6E803C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2012 04:32:28 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q7M8WSxs113798
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2012 04:32:28 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q7M8WRNL023042
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2012 04:32:28 -0400
Date: Wed, 22 Aug 2012 14:02:25 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v3 2/2] powerpc: Uprobes port to powerpc
Message-ID: <20120822083224.GC29216@in.ibm.com>
References: <20120726051902.GA29466@in.ibm.com>
 <20120726052029.GB29466@in.ibm.com> <20120815165931.GA10059@redhat.com>
 <1345066913.11751.4.camel@pasglop> <20120816050030.GA12060@in.ibm.com>
 <20120816152112.GA8874@redhat.com> <20120817051307.GA4782@in.ibm.com>
 <20120817150031.GA5029@redhat.com> <20120821112433.GB3519@in.ibm.com>
 <20120821130930.GA10382@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120821130930.GA10382@redhat.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, peterz@infradead.org,
 lkml <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>,
 linuxppc-dev@lists.ozlabs.org
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 21, 2012 at 03:09:30PM +0200, Oleg Nesterov wrote:

...

> > This is true for Intel like architectures that have *one* swbp
> > instruction. On Powerpc, gdb for instance, can insert a trap variant at
> > the address. Therefore, is_swbp_insn() by definition should return true
> > for all trap variants.
> 
> Not in this case, I think.
> 
> OK, I was going to do this later, but this discussion makes me think
> I should try to send the patch sooner.
> 
> set_swbp()->is_swbp_at_addr() is simply unneeded and in fact should
> be considered as unnecessary pessimization.
> 
> set_orig_insn()->is_swbp_at_addr() makes more sense, but it can't fix
> all races with userpace. Still it should die.
> 
> > OK. I will separate out the is_swbp_insn() change into a separate patch.
> 
> Great thanks. And if we remove is_swbp_insn() from set_swbp() and
> set_orig_insn() then the semantics of is_swbp_insn() will much more
> clear, and in this case I powerpc probably really needs to change it.

Oleg,

I have posted a new version for review [1] without the is_swbp_insn()
change. I will await your changes around is_swbp_at_addr() and make
changes to the powerpc code if necessary.

Regards,
Ananth

[1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2012-August/100524.html
