Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nHhy09ZrzF29B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 16:05:37 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id v63-v6so3226643pfk.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 23:05:37 -0700 (PDT)
Date: Fri, 18 May 2018 14:05:26 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Cyril Bur <cyrilbur@gmail.com>
Subject: Re: [PATCH v4 3/4] powerpc/64: add 32 bytes prechecking before using
 VMX optimization on memcmp()
Message-ID: <20180518060526.GA2498@simonLocalRHEL7.x64>
References: <1526459661-17323-1-git-send-email-wei.guo.simon@gmail.com>
 <1526459661-17323-4-git-send-email-wei.guo.simon@gmail.com>
 <87o9hemktb.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87o9hemktb.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,
On Fri, May 18, 2018 at 12:13:52AM +1000, Michael Ellerman wrote:
> wei.guo.simon@gmail.com writes:
> > From: Simon Guo <wei.guo.simon@gmail.com>
> >
> > This patch is based on the previous VMX patch on memcmp().
> >
> > To optimize ppc64 memcmp() with VMX instruction, we need to think about
> > the VMX penalty brought with: If kernel uses VMX instruction, it needs
> > to save/restore current thread's VMX registers. There are 32 x 128 bits
> > VMX registers in PPC, which means 32 x 16 = 512 bytes for load and store.
> >
> > The major concern regarding the memcmp() performance in kernel is KSM,
> > who will use memcmp() frequently to merge identical pages. So it will
> > make sense to take some measures/enhancement on KSM to see whether any
> > improvement can be done here.  Cyril Bur indicates that the memcmp() for
> > KSM has a higher possibility to fail (unmatch) early in previous bytes
> > in following mail.
> > 	https://patchwork.ozlabs.org/patch/817322/#1773629
> > And I am taking a follow-up on this with this patch.
> >
> > Per some testing, it shows KSM memcmp() will fail early at previous 32
> > bytes.  More specifically:
> >     - 76% cases will fail/unmatch before 16 bytes;
> >     - 83% cases will fail/unmatch before 32 bytes;
> >     - 84% cases will fail/unmatch before 64 bytes;
> > So 32 bytes looks a better choice than other bytes for pre-checking.
> >
> > This patch adds a 32 bytes pre-checking firstly before jumping into VMX
> > operations, to avoid the unnecessary VMX penalty. And the testing shows
> > ~20% improvement on memcmp() average execution time with this patch.
> >
> > The detail data and analysis is at:
> > https://github.com/justdoitqd/publicFiles/blob/master/memcmp/README.md
> >
> > Any suggestion is welcome.
> 
> Thanks for digging into that, really great work.
> 
> I'm inclined to make this not depend on KSM though. It seems like a good
> optimisation to do in general.
> 
> So can we just call it the 'pre-check' or something, and always do it?
> 
Sound reasonable to me.
I will expand the change to .Ldiffoffset_vmx_cmp case and test accordingly.

Thanks,
- Simon
