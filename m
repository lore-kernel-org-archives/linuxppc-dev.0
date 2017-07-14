Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x83yl3BT0zDqg2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 17:21:35 +1000 (AEST)
Message-ID: <1500016883.2865.82.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/4] powerpc/mm/radix: Don't iterate all sets when
 flushing the PWC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com
Date: Fri, 14 Jul 2017 17:21:23 +1000
In-Reply-To: <87shhzpkiq.fsf@skywalker.in.ibm.com>
References: <20170714015258.7933-1-benh@kernel.crashing.org>
 <87379zr2wt.fsf@skywalker.in.ibm.com>
 <1500013316.2865.72.camel@kernel.crashing.org>
 <87shhzpkiq.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-07-14 at 12:33 +0530, Aneesh Kumar K.V wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > On Fri, 2017-07-14 at 11:11 +0530, Aneesh Kumar K.V wrote:
> > > With the current code, we use tlbiel_pwc() for doing a pwc flush.
> > > and that does what is done this patch. May be we can update this patch
> > > such that we drop tlbiel_pwc and switch all those instance to
> > > tlbiel_pid(pid, RIC_FLUSH_PWC) ?
> > > 
> > > You already do this in a later patch.
> > 
> > Right, I do it in a later latch and I prefer to keep it this way, to
> > avoid doing too many changes in a single patch.
> 
> The commit message do indicate that we don't do flushing correctly for
> PWC flush with the current code. That is not correct. May be update the
> commit message then ?

Yeah ok.

Ben.
