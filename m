Return-Path: <xiyou.wangcong@gmail.com>
Received: from mail-vx0-f170.google.com (mail-vx0-f170.google.com
	[209.85.220.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8EF35B7103
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2011 23:21:03 +1100 (EST)
Received: by vxb39 with SMTP id 39so543926vxb.15
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Mar 2011 04:20:59 -0800 (PST)
Date: Wed, 9 Mar 2011 20:20:46 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] kdump: Allow shrinking of kdump region to be
	overridden
Message-ID: <20110309122046.GC16951@cr0.redhat.com>
References: <20100825002258.GD28360@kryten> <m139u37cii.fsf@fess.ebiederm.org>
	<4D771EE6.5050404@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D771EE6.5050404@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, "Eric W. Biederman" <ebiederm@xmission.com>,
	akpm@linux-foundation.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 09, 2011 at 12:02:06PM +0530, Mahesh Jagannath Salgaonkar wrote:
>On 08/25/2010 06:07 AM, Eric W. Biederman wrote:
>> Anton Blanchard <anton@samba.org> writes:
>> 
>>> On ppc64 the crashkernel region almost always overlaps an area of firmware.
>>> This works fine except when using the sysfs interface to reduce the kdump
>>> region. If we free the firmware area we are guaranteed to crash.
>> 
>> That is ppc64 bug.  firmware should not be in the reserved region.  Any
>> random kernel like thing can be put in to that region at any valid
>> address and the fact that shrinking the region frees your firmware means
>> that using that region could also stomp your firmware (which I assume
>> would be a bad thing).
>The issue only happens while shrinking the region using sysfs interface.
>We already have checks in kexec for not to stomp over on the firmware
>overlap area while loading capture kernel. Currently we do a top-down
>allocation for the firmware region which means it sits at the top of the
>RMO, right in the middle of the crashdump region. We can not move the
>crashkernel region beyond firmware region because kernel needs its some
>of memory in RMO region.

The crashkernel region is specified via kernel cmdline, so why
not just drop a failure when it overlaps with RMO region?
Am I missing something?

Thanks.
