Return-Path: <santosh@fossix.org>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCHz65fptzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 15:33:22 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id b79so3273411pfk.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 21:33:22 -0700 (PDT)
Date: Thu, 12 Oct 2017 10:03:17 +0530
From: Santosh Sivaraj <santosh@fossix.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <fweisbec@gmail.com>, paul@samba.org
Subject: Re: [PATCH v5] powerpc/vdso64: Add support for
 CLOCK_{REALTIME/MONOTONIC}_COARSE
Message-ID: <20171012043317.xtfhwpf4dmnvu3bj@santosiv.in.ibm.com>
References: <20171011083502.11648-1-santosh@fossix.org>
 <20171011170216.GR4406@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171011170216.GR4406@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Segher Boessenkool <segher@kernel.crashing.org> wrote (on 2017-10-11 17:02:16 +0000):

Hi Segher,
> Hi,
> 
> On Wed, Oct 11, 2017 at 02:05:02PM +0530, Santosh Sivaraj wrote:
> > +70:	ld      r8,CFG_TB_UPDATE_COUNT(r3)
> > +	andi.   r0,r8,1                 /* pending update ? loop */
> > +	bne-    70b
> > +	xor     r0,r8,r8                /* create dependency */
> 
> r0 already is 0 here, and already depends on r8.  Or is this trying
> to do something else?

The function from which this piece was borrowed from had a similar
implementation, didn't figure out why the extra dependency, kept it the way it
was. See __do_get_tspec function in the same file
(arch/powerpc/kernel/vdso64/gettimeofday.S).

> 
> > +	add     r3,r3,r0
> 
> 
> Segher

-- 
