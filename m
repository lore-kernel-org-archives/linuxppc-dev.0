Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFrpB4RgSzDrFw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 19:19:30 +1100 (AEDT)
Received: by mail-io0-x241.google.com with SMTP id b186so15208496iof.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 01:19:30 -0700 (PDT)
Date: Mon, 16 Oct 2017 16:19:24 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>,
 Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v3 3/3] powerpc:selftest update memcmp_64 selftest for
 VMX implementation
Message-ID: <20171016081924.GA2533@simonLocalRHEL7.x64>
References: <1507869000-24336-1-git-send-email-wei.guo.simon@gmail.com>
 <1507869000-24336-4-git-send-email-wei.guo.simon@gmail.com>
 <1508124778.10123.3.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1508124778.10123.3.camel@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Cyril,

Thanks for the review.

On Mon, Oct 16, 2017 at 02:32:58PM +1100, Cyril Bur wrote:
> On Fri, 2017-10-13 at 12:30 +0800, wei.guo.simon@gmail.com wrote:
> > From: Simon Guo <wei.guo.simon@gmail.com>
> > 
> > This patch adjust selftest memcmp_64 so that memcmp selftest can be
> > compiled successfully.
> > 
> 
> Do they not compile at the moment?
> 
Since I renamed enter/exit_vmx_copy() to enter/exit_vmx_ops() in patch 
2nd, this patch is necessary to make selftest compiled based on patch 2nd.

> > It also adds testcases for:
> > - memcmp over 4K bytes size.
> > - s1/s2 with different/random offset on 16 bytes boundary.
> > - enter/exit_vmx_ops pairness.
> > 
> 
> This is a great idea, just a thought though - perhaps it might make
> more sense to have each condition be tested for in a separate binary
> rather than a single binary that tests everything.
> 
I am not sure whether it is better to seperate those test cases
on the same memcmp func. Currently the time to execute this single 
test bin is within 35 secs, and keeping them in one exec will make 
people test more comprehensively. So Personally I prefer to keep 
them in one at present.  

Thanks,
- Simon
