Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qk6sT5k7kzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 21:14:37 +1000 (AEST)
Message-ID: <1460373271.17837.3.camel@ellerman.id.au>
Subject: Re: cxl: fix setting of _PAGE_USER bit when handling page faults
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Donnellan
 <andrew.donnellan@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com
Date: Mon, 11 Apr 2016 21:14:31 +1000
In-Reply-To: <878u0kahqn.fsf@linux.vnet.ibm.com>
References: <3qWf364wYxz9sDG@ozlabs.org> <8737rau3b7.fsf@linux.vnet.ibm.com>
 <570B23CD.3090203@au1.ibm.com> <1460348865.3444.0.camel@ellerman.id.au>
 <878u0kahqn.fsf@linux.vnet.ibm.com>
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

On Mon, 2016-04-11 at 10:01 +0530, Aneesh Kumar K.V wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> > On Mon, 2016-04-11 at 14:10 +1000, Andrew Donnellan wrote:
> > > On 29/03/16 00:42, Aneesh Kumar K.V wrote:
> > > > I noticed this when doing radix support and have a variant posted at
> > > > 
> > > > https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-March/141036.html
> > > 
> > > I'm happy for this to be fixed in your radix series.
> > 
> > I'm not :)
> > 
> > This needs a stand-alone fix that we can backport.
> 
> It is done as an independent patch 
> 
> http://mid.gmane.org/1460182444-2468-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com

Sure, but that's still not a *fix*.

A fix is a single commit, preferably with a subject that literally contains the
word "fix" or "bug", which fixes just the bug and nothing else. It should also
have a Fixes: line, if possible, and a Cc stable if appropriate.

It should also describe clearly what the bug is, why it's serious or just
annoying or whatever.

In this case it *looks* like we have a giant hole in the mm handling for CAPI
contexts, which would let userspace create mappings of kernel memory with
_PAGE_USER set. I think I agree with Ian that in fact that's not true, but it's
not clear from the diff that is the case. So I'd really like someone to write a
good commit message demonstrating that we understand what the bug is and why
it's not a big deal, despite the patch looking scary at first glance.

</grumpy> :)

cheers
