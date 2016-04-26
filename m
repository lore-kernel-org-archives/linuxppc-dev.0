Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvdxH5qjxzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 09:05:55 +1000 (AEST)
Message-ID: <1461711943.3135.72.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm: Use jump label to speed up radix_enabled check
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Balbir Singh <bsingharora@gmail.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Wed, 27 Apr 2016 09:05:43 +1000
In-Reply-To: <571FE8C1.4030903@gmail.com>
References: <1461687855-23017-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1461704701.3135.68.camel@kernel.crashing.org> <571FE8C1.4030903@gmail.com>
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

On Wed, 2016-04-27 at 08:16 +1000, Balbir Singh wrote:
> 
> On 27/04/16 07:05, Benjamin Herrenschmidt wrote:
> > 
> > On Tue, 2016-04-26 at 21:54 +0530, Aneesh Kumar K.V wrote:
> > > 
> > > This add generic mmu_feature_enabled() function that get patched
> > > to take right code path based on the feature bit enabled. The
> > > main
> > > difference between the existing mmu_has_feature() function is the
> > > hot patching using jump label framework.
> > > 
> > > The implementation wraps around mmu_has_feature so that we can
> > > use
> > > this in early bootup code before we do the hotpatching.
> > I'd rather we make mmu_has_feature() use jump labels and is the
> > "main"
> > API to be used by most code. If we have a need for a lower-level
> > version for use by early boot code, call it __mmu_has_feature().
> > 
> > This is more in-line with existing kernel practices and avoids
> > having
> > two APIs that somewhat look the same where it's not clear which one
> > should be used.
> > 
> Makes sense, but I suspect its a larger impact with loads of testing
> required across platforms. Should this be done incrementally?

What kind of impact do you expect ?

Ben.
