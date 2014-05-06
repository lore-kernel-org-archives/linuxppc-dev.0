Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 823C51402EA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 10:07:40 +1000 (EST)
Message-ID: <1399334847.20388.72.camel@pasglop>
Subject: Re: [PATCH V4] POWERPC: BOOK3S: KVM: Use the saved dar value and
 generic make_dsisr
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Tue, 06 May 2014 10:07:27 +1000
In-Reply-To: <5367A39D.9080709@suse.de>
References: <1399224075-18041-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <536773C2.1070502@suse.de> <87tx949u9d.fsf@linux.vnet.ibm.com>
 <5367A39D.9080709@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, olofj@google.com, kvm-ppc@vger.kernel.org,
 paulus@samba.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-05-05 at 16:43 +0200, Alexander Graf wrote:
> > Paul mentioned that BOOK3S always had DAR value set on alignment
> > interrupt. And the patch is to enable/collect correct DAR value when
> > running with Little Endian PR guest. Now to limit the impact and to
> > enable Little Endian PR guest, I ended up doing the conditional code
> > only for book3s 64 for which we know for sure that we set DAR value.
> 
> Yes, and I'm asking whether we know that this statement holds true for 
> PA6T and G5 chips which I wouldn't consider IBM POWER. Since the G5 is 
> at least developed by IBM, I'd assume its semantics here are similar to 
> POWER4, but for PA6T I wouldn't be so sure.

I am not aware of any PowerPC processor that does not set DAR on
alignment interrupts. Paul, are you ?

Cheers,
Ben.
