Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9E7EB1A0C76
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 09:28:38 +1100 (AEDT)
Message-ID: <1421274513.11409.1.camel@ellerman.id.au>
Subject: Re: [PATCH v3 1/3] powerpc/nvram: move generic code for nvram and
 pstore
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Thu, 15 Jan 2015 09:28:33 +1100
In-Reply-To: <54B6AFE8.4000104@linux.vnet.ibm.com>
References: <20141224115729.25731.20371.stgit@localhost.localdomain>
 <20141224115825.25731.65673.stgit@localhost.localdomain>
 <1421209860.10748.10.camel@ellerman.id.au>
 <54B6AFE8.4000104@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-01-14 at 23:35 +0530, Hari Bathini wrote:
> On 01/14/2015 10:01 AM, Michael Ellerman wrote:
> 
> > On Wed, 2014-12-24 at 17:28 +0530, Hari Bathini wrote:
> > > With minor checks, we can move most of the code for nvram
> > > under pseries to a common place to be re-used by other
> > > powerpc platforms like powernv. This patch moves such
> > > common code to arch/powerpc/kernel/nvram_64.c file.
> > As I said in my reply to the previous version:
> > 
> >     ... you need to keep in mind that it is very common for us to build kernels
> >     with both POWERNV=y and PSERIES=y.
> >     
> >     So you need to make sure you're only using CONFIG_PPC_PSERIES to protect things
> >     that are optional on pseries. Not things that we *shouldn't* be doing on
> >     powernv.
> 
> we could as well do away with the PPC_PSERIES flag in a couple of
> places in
> arch/powerpc/kernel/nvram_64.c, but doing that will unnecessarily add
> few extra variables for !PPC_PSERIES case. 

Yep. I'm happy for them to be there, I just want you to explain in the
changelog that you've thought about the PSERIES=y POWERNV=y case and why the
code makes sense for that configuration.

> > Please explain in your commit message how you have dealt with that.
> 
> Sure. Will update the changelog

Thanks.
 
> > Also, you broke the build for every config that doesn't have
> > CONFIG_PPC_PSERIES, all 95 of them. This is pasemi_defconfig for example:
> 
> My bad! clobbering_unread_rtas_event should have been static inline
> while defining under !PPC_PSERIES

Correct.

Please make sure you test build at least some of the other configurations in
future. I realise it's too time consuming to build all of them, but ideally for
every config symbol you use in your patch you need to build a kernel config
where that symbol =y and =n (and =m if it's tristate).

cheers
