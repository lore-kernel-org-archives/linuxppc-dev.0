Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1AD421A0163
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 10:22:24 +1000 (AEST)
Message-ID: <1436919743.10956.2.camel@ellerman.id.au>
Subject: Re: [RFC,1/2] powerpc/numa: fix cpu_to_node() usage during boot
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>, David
 Rientjes <rientjes@google.com>,  linuxppc-dev@lists.ozlabs.org
Date: Wed, 15 Jul 2015 10:22:23 +1000
In-Reply-To: <20150708231623.GB44862@linux.vnet.ibm.com>
References: <20150702230202.GA2807@linux.vnet.ibm.com>
 <20150708040056.948A1140770@ozlabs.org>
 <20150708231623.GB44862@linux.vnet.ibm.com>
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

On Wed, 2015-07-08 at 16:16 -0700, Nishanth Aravamudan wrote:
> On 08.07.2015 [14:00:56 +1000], Michael Ellerman wrote:
> > On Thu, 2015-02-07 at 23:02:02 UTC, Nishanth Aravamudan wrote:
> > > 
> > > we currently emit at boot:
> > > 
> > > [    0.000000] pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7 
> > > 
> > > After this commit, we correctly emit:
> > > 
> > > [    0.000000] pcpu-alloc: [0] 0 1 2 3 [1] 4 5 6 7 
> > 
> > 
> > So it looks fairly sane, and I guess it's a bug fix.
> > 
> > But I'm a bit reluctant to put it in straight away without some time in next.
> 
> I'm fine with that -- it could use some more extensive testing,
> admittedly (I only have been able to verify the pcpu areas are being
> correctly allocated on the right node so far).
> 
> I still need to test with hotplug and things like that. Hence the RFC.
> 
> > It looks like the symptom is that the per-cpu areas are all allocated on node
> > 0, is that all that goes wrong?
> 
> Yes, that's the symptom. I cc'd a few folks to see if they could help
> indicate the performance implications of such a setup -- sorry, I should
> have been more explicit about that.

OK cool. I'm happy to put it in next if you send a non-RFC version.

cheers
