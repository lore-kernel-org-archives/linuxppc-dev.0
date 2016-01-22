Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E33E41A0019
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 19:35:44 +1100 (AEDT)
Message-ID: <1453451744.24910.4.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/mm: Allow user space to map rtas_rmo_buf
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: Dan Williams <dan.j.williams@intel.com>, Nathan Fontenot
 <nfont@linux.vnet.ibm.com>
Date: Fri, 22 Jan 2016 19:35:44 +1100
In-Reply-To: <56A1CC1C.3000009@linux.vnet.ibm.com>
References: <1453392931-20707-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
 <1453440564.21683.8.camel@ellerman.id.au>
 <56A1CC1C.3000009@linux.vnet.ibm.com>
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

On Fri, 2016-01-22 at 11:58 +0530, Vasant Hegde wrote:
> On 01/22/2016 10:59 AM, Michael Ellerman wrote:
> > On Thu, 2016-01-21 at 21:45 +0530, Vasant Hegde wrote:
> > 
> > > With commit 90a545e9 (restrict /dev/mem to idle io memory ranges) mapping
> > > rtas_rmo_buf from user space is failing. Hence we are not able to make
> > > RTAS syscall.
> > 
> > Having said that, why the <expletive deleted> is librtas mapping /dev/mem in
> > the first place? Unless there is a very good reason, and probably even if there
> > is, we should fix that to use a sane API.
> 
> We use rtas system call. We use /dev/mem interface to map the RTAS memory region
> (allocated by kernel and information is passed to user space via procfs) so that
> we can read/write to RTAS memory.
> 
> I do not have historical information. May be Nathan has more information on this.

Yeah, we need to dig into what it's actually doing and why. I had a quick look
but it wasn't obvious.

We should not need 1) a system call, 2) a proc interface, and 3) a mmap of
/dev/mem.

If the syscall's not sufficient and we really need to mmap, we should create a
device which can then be mmapped in a more standard way.

Having said that, Nathan's been moving more of the hotplug logic into the
kernel, so I'm also not clear on how much of the existing API we will need in
the future. So yep hopefully Nathan can chime in.

cheers
