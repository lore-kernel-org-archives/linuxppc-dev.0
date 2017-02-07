Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHWxw4hNtzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 15:46:12 +1100 (AEDT)
Message-ID: <1486442760.4850.121.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 5/5] powerpc/mm/hash: Increase VA range to 256TB
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 07 Feb 2017 15:46:00 +1100
In-Reply-To: <87lgtir5wa.fsf@skywalker.in.ibm.com>
References: <1486439333-22162-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1486439333-22162-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1486440373.4850.114.camel@kernel.crashing.org>
 <87lgtir5wa.fsf@skywalker.in.ibm.com>
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

On Tue, 2017-02-07 at 09:47 +0530, Aneesh Kumar K.V wrote:
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > That's 48 bits. I would keep the limit at 47 without some explicit
> > opt-in by applications. That's what users get on x86 and we know
> > some GPUs have limits there.
> 
> The idea is to have linux personality values that will limit the
> effective address to different memory range. By default max effective
> address will be limited to 64TB. Applications can then extend this to
> 128TB or 512TB. So we will have two personality values PER_LINUX_128TB
> and PER_LINUX_512TB ?

No. I think we can go up to 47-bits without any personality
requirement. For above, a single personality indicating that the
application has no limit.

Check what Intel is doing for 5-level trees

Cheers,
Ben.
