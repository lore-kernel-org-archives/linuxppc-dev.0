Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svFz43S1czDvh3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 01:06:40 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id 190so2840431pfv.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2016 07:06:40 -0700 (PDT)
Date: Wed, 12 Oct 2016 22:06:34 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Shuah Khan <shuah@kernel.org>,
 Cyril Bur <cyrilbur@gmail.com>, Chris Smart <chris@distroguy.com>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Michael Neuling <mikey@neuling.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Jack Miller <jack@codezen.org>, Rashmica Gupta <rashmicy@gmail.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v15 03/15] selftests/powerpc: Add ptrace tests for EBB
Message-ID: <20161012140633.GA11846@simonLocalRHEL7.x64>
References: <1475202784-5653-1-git-send-email-wei.guo.simon@gmail.com>
 <1475202784-5653-4-git-send-email-wei.guo.simon@gmail.com>
 <8760p5duen.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8760p5duen.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 07, 2016 at 08:44:48AM +1100, Michael Ellerman wrote:
> wei.guo.simon@gmail.com writes:
> 
> > From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> >
> > This patch adds ptrace interface test for EBB/PMU specific
> > registers. This also adds some generic ptrace interface
> > based helper functions to be used by other patches later
> > on in the series.
> 
> This is consistently failing for me on a P8 Tuleta (pvr 004b 0201):
> 
> # ./ptrace-ebb 
> test: ptrace_ebb_pmu
> tags: git_version:v4.8-rc5-176-g89cf1de0ae90
> EBBRR: 100059f8
> EBBHR: 100053cc; expected: 100053cc
> BESCR: 8000000100000000
> SIAR:  100012d0
> SDAR:  3fff7e4cc000
> SIER:  3000000; expected: 2000000
> MMCR2: 0; expected: 0
> MMCR0: 180000080; expected: 180000080
> failure: ptrace_ebb_pmu
> 
> cheers
Michael,

Yes.. SIER has different value in baremetal and virtual machine
due to different MSR[HV] value.  I will correct it. Originally I only
tested in virtual BE/LE machines.

Currently all tests cases (with fix) passed on one baremetal P8 machine 
with LE OS installed.  And I will try to find another baremetal with BE 
OS installed to test.

Thanks for indicating it.

BR,
Simon
