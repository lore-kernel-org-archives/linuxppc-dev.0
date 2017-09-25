Return-Path: <cyrilbur@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y1Lfy0NmRzDsM9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 09:59:53 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id j16so5727862pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Sep 2017 16:59:53 -0700 (PDT)
Message-ID: <1506383986.2918.4.camel@gmail.com>
Subject: Re: [PATCH v2 2/3] powerpc/64: enhance memcmp() with VMX
 instruction for long bytes comparision
From: Cyril Bur <cyrilbur@gmail.com>
To: Simon Guo <wei.guo.simon@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, David Laight <David.Laight@ACULAB.COM>,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>
Date: Tue, 26 Sep 2017 09:59:46 +1000
In-Reply-To: <20170923211843.GA10899@simonLocalRHEL7.x64>
References: <1505950480-14830-1-git-send-email-wei.guo.simon@gmail.com>
 <1505950480-14830-3-git-send-email-wei.guo.simon@gmail.com>
 <1506089208.1155.32.camel@gmail.com>
 <20170923211843.GA10899@simonLocalRHEL7.x64>
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

On Sun, 2017-09-24 at 05:18 +0800, Simon Guo wrote:
> Hi Cyril,
> On Sat, Sep 23, 2017 at 12:06:48AM +1000, Cyril Bur wrote:
> > On Thu, 2017-09-21 at 07:34 +0800, wei.guo.simon@gmail.com wrote:
> > > From: Simon Guo <wei.guo.simon@gmail.com>
> > > 
> > > This patch add VMX primitives to do memcmp() in case the compare size
> > > exceeds 4K bytes.
> > > 
> > 
> > Hi Simon,
> > 
> > Sorry I didn't see this sooner, I've actually been working on a kernel
> > version of glibc commit dec4a7105e (powerpc: Improve memcmp performance
> > for POWER8) unfortunately I've been distracted and it still isn't done.
> 
> Thanks for sync with me. Let's consolidate our effort together :)
> 
> I have a quick check on glibc commit dec4a7105e. 
> Looks the aligned case comparison with VSX is launched without rN size
> limitation, which means it will have a VSX reg load penalty even when the 
> length is 9 bytes.
> 

This was written for userspace which doesn't have to explicitly enable
VMX in order to use it - we need to be smarter in the kernel.

> It did some optimization when src/dest addrs don't have the same offset 
> on 8 bytes alignment boundary. I need to read more closely.
> 
> > I wonder if we can consolidate our efforts here. One thing I did come
> > across in my testing is that for memcmp() that will fail early (I
> > haven't narrowed down the the optimal number yet) the cost of enabling
> > VMX actually turns out to be a performance regression, as such I've
> > added a small check of the first 64 bytes to the start before enabling
> > VMX to ensure the penalty is worth taking.
> 
> Will there still be a penalty if the 65th byte differs?  
> 

I haven't benchmarked it exactly, my rationale for 64 bytes was that it
is the stride of the vectorised copy loop so, if we know we'll fail
before even completing one iteration of the vectorized loop there isn't
any point using the vector regs.

> > 
> > Also, you should consider doing 4K and greater, KSM (Kernel Samepage
> > Merging) uses PAGE_SIZE which can be as small as 4K.
> 
> Currently the VMX will only be applied when size exceeds 4K. Are you
> suggesting a bigger threshold than 4K?
> 

Equal to or greater than 4K, KSM will benefit.

> We can sync more offline for v3.
> 
> Thanks,
> - Simon
