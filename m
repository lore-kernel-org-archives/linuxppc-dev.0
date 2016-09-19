Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3scqgq4blWzDsZ8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 12:33:27 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id my20so3248791pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Sep 2016 19:33:27 -0700 (PDT)
Date: Mon, 19 Sep 2016 10:33:38 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Shuah Khan <shuah@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Chris Smart <chris@distroguy.com>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Michael Neuling <mikey@neuling.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Jack Miller <jack@codezen.org>, Rashmica Gupta <rashmicy@gmail.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v14 13/15] selftests/powerpc: Add ptrace tests for TM SPR
 registers
Message-ID: <20160919023338.GA3797@simonLocalRHEL7.x64>
References: <1473665605-11890-1-git-send-email-wei.guo.simon@gmail.com>
 <1473665605-11890-14-git-send-email-wei.guo.simon@gmail.com>
 <1473829452.2554.19.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473829452.2554.19.camel@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 14, 2016 at 03:04:12PM +1000, Cyril Bur wrote:
> On Mon, 2016-09-12 at 15:33 +0800, wei.guo.simon@gmail.com wrote:
> > From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> > 
> > This patch adds ptrace interface test for TM SPR registers. This
> > also adds ptrace interface based helper functions related to TM
> > SPR registers access.
> > 
> 
> I'm seeing this one fail a lot, it does occasionally succeed but fails
> a lot on my test setup.
> 
> I use qemu on a power8 for most of my testing:
> qemu-system-ppc64 --enable-kvm -machine pseries,accel=kvm,usb=off -m
> 4096 -realtime mlock=off -smp 4,sockets=1,cores=2,threads=2 -nographic
> -vga none
Hi Cyril,

Sorry for the late response. I am just back from a vacation.
Strangely the case always succeed in my machine. I will try to 
reproduce it with your configuration.

> > +	if ((regs->tm_texasr != TM_SCHED) && (regs->tm_texasr !=
> > TM_KVM_SCHED))
> > +		return TEST_FAIL;
> 
> The above condition fails, should this test try again if this condition
> is true, rather than fail?
If you have the value of "regs->tm_texasr" in hand, please let
me know.

Thanks for the elaborated comment in other mails and I will 
work on that.

BR,
- Simon
