Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 210721A03F8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 16:30:33 +1100 (AEDT)
Message-ID: <1446528621.17404.33.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 0/7] Remove 4k subpage tracking with hash 64K config
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Paul Mackerras
 <paulus@ozlabs.org>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Date: Tue, 03 Nov 2015 16:30:21 +1100
In-Reply-To: <87r3k7u0tf.fsf@linux.vnet.ibm.com>
References: <1445371953-9627-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20151029030029.GA31681@fergus.ozlabs.ibm.com>
 <87r3k7u0tf.fsf@linux.vnet.ibm.com>
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

On Tue, 2015-11-03 at 10:38 +0530, Aneesh Kumar K.V wrote:
> I also ran mmtest configs/config-global-dhp__pagealloc-performance
> config with changes including this series. (ie, the changes tested
> include two patch series, one which change the pte format and this
> series). I am attaching the results below. I removed the pagealloc
> performance numbers from that because it was giving me all 00 which I
> assume is due to systemtap script issue.
> 
> We don't see any performance impact with the series and some of the
> performance change is withing the variance of test run as indicated by
> the numbers below. We do find less page fault and in some case better
> autonuma numbers 

Did you try under pHyp (ie. hit all those H_READ ?).

The easy way to do that is comment out 64K support in htab init to
force 4k demotion allways.

That would give you an idea of the impact on things like old P4/P5

Cheers,
Ben.
