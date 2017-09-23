Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y0pyL19XNzDr4N
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Sep 2017 13:11:21 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id i23so3062613pfi.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Sep 2017 20:11:21 -0700 (PDT)
Date: Sun, 24 Sep 2017 05:18:43 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, David Laight <David.Laight@ACULAB.COM>,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/3] powerpc/64: enhance memcmp() with VMX instruction
 for long bytes comparision
Message-ID: <20170923211843.GA10899@simonLocalRHEL7.x64>
References: <1505950480-14830-1-git-send-email-wei.guo.simon@gmail.com>
 <1505950480-14830-3-git-send-email-wei.guo.simon@gmail.com>
 <1506089208.1155.32.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1506089208.1155.32.camel@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Cyril,
On Sat, Sep 23, 2017 at 12:06:48AM +1000, Cyril Bur wrote:
> On Thu, 2017-09-21 at 07:34 +0800, wei.guo.simon@gmail.com wrote:
> > From: Simon Guo <wei.guo.simon@gmail.com>
> > 
> > This patch add VMX primitives to do memcmp() in case the compare size
> > exceeds 4K bytes.
> > 
> 
> Hi Simon,
> 
> Sorry I didn't see this sooner, I've actually been working on a kernel
> version of glibc commit dec4a7105e (powerpc: Improve memcmp performance
> for POWER8) unfortunately I've been distracted and it still isn't done.
Thanks for sync with me. Let's consolidate our effort together :)

I have a quick check on glibc commit dec4a7105e. 
Looks the aligned case comparison with VSX is launched without rN size
limitation, which means it will have a VSX reg load penalty even when the 
length is 9 bytes.

It did some optimization when src/dest addrs don't have the same offset 
on 8 bytes alignment boundary. I need to read more closely.

> I wonder if we can consolidate our efforts here. One thing I did come
> across in my testing is that for memcmp() that will fail early (I
> haven't narrowed down the the optimal number yet) the cost of enabling
> VMX actually turns out to be a performance regression, as such I've
> added a small check of the first 64 bytes to the start before enabling
> VMX to ensure the penalty is worth taking.
Will there still be a penalty if the 65th byte differs?  

> 
> Also, you should consider doing 4K and greater, KSM (Kernel Samepage
> Merging) uses PAGE_SIZE which can be as small as 4K.
Currently the VMX will only be applied when size exceeds 4K. Are you
suggesting a bigger threshold than 4K?

We can sync more offline for v3.

Thanks,
- Simon
