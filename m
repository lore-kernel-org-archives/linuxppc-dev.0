Return-Path: <xiyou.wangcong@gmail.com>
Received: from mail-iy0-f170.google.com (mail-iy0-f170.google.com
	[209.85.210.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 40F11B6FF1
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Mar 2011 18:52:42 +1100 (EST)
Received: by iyb12 with SMTP id 12so452774iyb.15
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Mar 2011 00:52:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110314181315.GA16075@in.ibm.com>
References: <20100825002258.GD28360@kryten> <m139u37cii.fsf@fess.ebiederm.org>
	<4D771EE6.5050404@linux.vnet.ibm.com>
	<20110309122046.GC16951@cr0.redhat.com>
	<20110309234657.264d3080@kryten>
	<20110309142108.GD16951@cr0.redhat.com>
	<20110314181315.GA16075@in.ibm.com>
Date: Tue, 15 Mar 2011 15:52:38 +0800
Message-ID: <AANLkTi=aDzCaa7_=5XTrnJCzmZPrDy3omXwDarEF8XmH@mail.gmail.com>
Subject: Re: [PATCH 1/2] kdump: Allow shrinking of kdump region to be
	overridden
From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>
To: mahesh@linux.vnet.ibm.com
Content-Type: text/plain; charset=UTF-8
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

On Tue, Mar 15, 2011 at 2:13 AM, Mahesh J Salgaonkar
<mahesh@linux.vnet.ibm.com> wrote:
>
> During free we do free all of them including RMO region. But since the rtas
> region is always on top of RMO, crashkernel memory overlaps rtas region and
> we endup freeing that even, which is causing the crash.
>

Okay, but with this patch applied, we will just ignore rtas region, right?
Thus, when I echo 0 to free all the 128M crashkernel memory, the final
result will be 32M left, which means crash_size will still show 32M.
This looks odd.

How about skipping the 32M as a whole? I mean once the region being freed
has overlap with this rtas region, skip the whole rtas region, and let
crash_size
show 0?

Thanks.
