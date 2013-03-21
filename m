Return-Path: <ananth@in.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1E7BF2C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 18:17:24 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Thu, 21 Mar 2013 03:17:21 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id E87E16E803F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 03:17:16 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2L7HI8v267766
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 03:17:18 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2L7HI2m003380
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 04:17:18 -0300
Date: Thu, 21 Mar 2013 12:47:07 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] powerpc/uprobes: teach uprobes to ignore gdb breakpoints
Message-ID: <20130321071707.GB5271@in.ibm.com>
References: <20130320104033.GA19844@in.ibm.com>
 <20130320122639.GA29541@redhat.com> <20130320124301.GA30887@redhat.com>
 <20130320154245.GB8246@in.ibm.com> <20130320160728.GB20352@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130320160728.GB20352@redhat.com>
Cc: ppcdev <linuxppc-dev@lists.ozlabs.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>, stable@vger.kernel.org
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 20, 2013 at 05:07:28PM +0100, Oleg Nesterov wrote:
> On 03/20, Ananth N Mavinakayanahalli wrote:
> >
> > On Wed, Mar 20, 2013 at 01:43:01PM +0100, Oleg Nesterov wrote:
> > > On 03/20, Oleg Nesterov wrote:
> > > >
> > > > But we did not install UPROBE_SWBP_INSN. Is it fine? I hope yes, just to
> > > > verify. If not, we need 2 definitions. is_uprobe_insn() should still check
> > > > insns == UPROBE_SWBP_INSN, and is_swbp_insn() should check is_trap().
> > > >
> > > > And I am just curious, could you explain how X and UPROBE_SWBP_INSN
> > > > differ?
> > >
> > > IOW, if I wasn't clear... Lets forget about gdb/etc for the moment.
> > > Suppose we apply the patch below. Will uprobes on powerpc work?
> > >
> > > If yes, then your patch should be fine. If not, we probably need more
> > > changes.
> >
> > Yes, it will work fine.
> 
> Even if this new insn is conditional?

Yes.
