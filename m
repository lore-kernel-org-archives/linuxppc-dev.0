Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZPnV61gJzDsWh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 13:59:58 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id z84so1641323pfi.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 20:59:58 -0700 (PDT)
Date: Thu, 15 Sep 2016 13:59:48 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Carlos Eduardo Seo <cseo@linux.vnet.ibm.com>
Cc: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, mikey@neuling.org, wei.guo.simon@gmail.com,
 anton@samba.org
Subject: Re: [PATCH 0/2] Enable MSR_TM lazily
Message-ID: <20160915135948.3da473dd@roar.ozlabs.ibm.com>
In-Reply-To: <cdf17bd0-d421-7cb6-527d-ab9e916edafa@linux.vnet.ibm.com>
References: <20160914080216.13833-1-cyrilbur@gmail.com>
 <20160914212824.4936a9a2@roar.ozlabs.ibm.com>
 <cdf17bd0-d421-7cb6-527d-ab9e916edafa@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 14 Sep 2016 11:10:22 -0300
Carlos Eduardo Seo <cseo@linux.vnet.ibm.com> wrote:

> On 9/14/16 8:28 AM, Nicholas Piggin wrote:
> >
> > How common it is for glibc to be built with elision?
> >  
> 
> Not that common. We have it built with TLE support in Ubuntu (starting 
> in 15.04), SLES 12 (since SP2) and AT 9.0-0.
> 
> However, it is only enabled by default in Ubuntu. For SLES and AT 9.0, 
> the user has to set an env var to enable it (it's a hack).
> 
> There is some work upstream to add a tunables framework to glibc. That 
> will allow us to properly provide a way to users enable/disable TLE as 
> they wish. That patch is almost in, and as soon as it's committed, we'll 
> start working on the tunable for TLE.

Okay, but for TLE-enabled case, we still want to skip the tabort
before syscall on recent kernels, so we could add that now with a 
relatively small patch couldn't we?

Thanks,
Nick
