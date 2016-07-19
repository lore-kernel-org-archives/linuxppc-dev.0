Return-Path: <mark.rutland@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rtxgs10zwzDqMf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 20:52:08 +1000 (AEST)
Date: Tue, 19 Jul 2016 11:52:00 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, bhe@redhat.com,
 arnd@arndb.de, linuxppc-dev@lists.ozlabs.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 ebiederm@xmission.com, bauerman@linux.vnet.ibm.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 3/3] kexec: extend kexec_file_load system call
Message-ID: <20160719105049.GD27022@leverpostej>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160712014201.11456-4-takahiro.akashi@linaro.org>
 <20160715130955.GC23514@redhat.com>
 <20160715131950.GB19840@leverpostej>
 <20160718023024.GB6310@dhcp-128-65.nay.redhat.com>
 <20160718100704.GB10069@leverpostej>
 <20160719005556.GE3326@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160719005556.GE3326@dhcp-128-65.nay.redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 19, 2016 at 08:55:56AM +0800, Dave Young wrote:
> On 07/18/16 at 11:07am, Mark Rutland wrote:
> > On Mon, Jul 18, 2016 at 10:30:24AM +0800, Dave Young wrote:
> > > I do not think it is worth to add another syscall for extra fds.
> > > We have open(2) as an example for different numbers of arguments
> > > already.
> > 
> > Did we change the syscall interface for that?
> > 
> > I was under the impression that there was always one underlying syscall,
> > and the C library did the right thing to pass the expected information
> > to the underlying syscall.
> 
> I'm not sure kexec_load and kexec_file_load were included in glibc, we use
> syscall directly in kexec-tools.
> 
> kexec_load man pages says there are no wrappers for both kexec_load and
> kexec_file_load in glibc.

For the above, I was talking about how open() was handled.

If there are no userspace wrappers, then the two cases aren't comparable
in the first place...

> > That's rather different to changing the underlying syscall.
> > 
> > Regardless of how this is wrapped in userspace, I do not think modifying
> > the existing prototype is a good idea, and I think this kind of
> > extension needs to be a new syscall.
> 
> Hmm, as I replied to Vivek, there is one case about the flags, previously
> the new flag will be regarded as invalid, but not we extend it it will be
> valid, this maybe the only potential bad case.

It's true that adding suport for new flags will change the behaviour of
what used to be error cases. We generally expect real users to not be
making pointless calls for which they rely on an error being returned in
all cases.

Regardless, this extended syscall changes some underlying assumptions
made with the development of kexec_file_load, and I think treating this
as an extension is not a great idea. From a user's perspective there is
little difference between passing an additional flag or using a
different syscall number, so I don't think that we gain much by altering
the existing prototype relative to allocating a new syscall number.

Thus, I think that if this is necessary it should be treated as a new
syscall.

Thanks,
Mark.
