Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0392AB705F
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2011 03:52:28 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp09.au.ibm.com (8.14.4/8.13.1) with ESMTP id p2FGqPBB001342
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2011 03:52:25 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p2FGqPq62056382
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2011 03:52:25 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p2FGqOma015816
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2011 03:52:25 +1100
Date: Tue, 15 Mar 2011 22:22:19 +0530
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: =?iso-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH 1/2] kdump: Allow shrinking of kdump region to be
	overridden
Message-ID: <20110315165219.GA22509@in.ibm.com>
References: <20100825002258.GD28360@kryten> <m139u37cii.fsf@fess.ebiederm.org>
	<4D771EE6.5050404@linux.vnet.ibm.com>
	<20110309122046.GC16951@cr0.redhat.com>
	<20110309234657.264d3080@kryten>
	<20110309142108.GD16951@cr0.redhat.com>
	<20110314181315.GA16075@in.ibm.com>
	<AANLkTi=aDzCaa7_=5XTrnJCzmZPrDy3omXwDarEF8XmH@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTi=aDzCaa7_=5XTrnJCzmZPrDy3omXwDarEF8XmH@mail.gmail.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>,
	akpm@linux-foundation.org, "Eric W. Biederman" <ebiederm@xmission.com>
Reply-To: mahesh@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 15, 2011 at 03:52:38PM +0800, Américo Wang wrote:
> On Tue, Mar 15, 2011 at 2:13 AM, Mahesh J Salgaonkar
> <mahesh@linux.vnet.ibm.com> wrote:
> >
> > During free we do free all of them including RMO region. But since the rtas
> > region is always on top of RMO, crashkernel memory overlaps rtas region and
> > we endup freeing that even, which is causing the crash.
> >
> 
> Okay, but with this patch applied, we will just ignore rtas region, right?
Correct.
> Thus, when I echo 0 to free all the 128M crashkernel memory, the final
> result will be 32M left, which means crash_size will still show 32M.
> This looks odd.
> 
> How about skipping the 32M as a whole? I mean once the region being freed
> has overlap with this rtas region, skip the whole rtas region, and let
> crash_size
> show 0?
The existing code from crash_shrink_memory() function reduces the crash
size to 0 when echo'ed 0. I did test this patchset and verified that
/sys/kernel/kexec_crash_size show 0 value.

Thanks,
-Mahesh.
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

-- 
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
