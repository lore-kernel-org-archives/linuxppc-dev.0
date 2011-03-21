Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by ozlabs.org (Postfix) with ESMTP id BF8D6B6F75
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Mar 2011 14:35:13 +1100 (EST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glppd-linuxppc64-dev@m.gmane.org>)
	id 1Q1Vf2-0002EB-T1
	for linuxppc-dev@ozlabs.org; Mon, 21 Mar 2011 04:20:04 +0100
Received: from 219.144.238.61 ([219.144.238.61])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Mar 2011 04:20:04 +0100
Received: from xiyou.wangcong by 219.144.238.61 with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Mar 2011 04:20:04 +0100
To: linuxppc-dev@ozlabs.org
From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH 1/2] kdump: Allow shrinking of kdump region to be
	overridden
Date: Mon, 21 Mar 2011 03:10:26 +0000 (UTC)
Message-ID: <im6fj2$576$1@dough.gmane.org>
References: <20100825002258.GD28360@kryten> <m139u37cii.fsf@fess.ebiederm.org>
	<4D771EE6.5050404@linux.vnet.ibm.com>
	<20110309122046.GC16951@cr0.redhat.com>
	<20110309234657.264d3080@kryten>
	<20110309142108.GD16951@cr0.redhat.com>
	<20110314181315.GA16075@in.ibm.com>
	<AANLkTi=aDzCaa7_=5XTrnJCzmZPrDy3omXwDarEF8XmH@mail.gmail.com>
	<20110315165219.GA22509@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 15 Mar 2011 22:22:19 +0530, Mahesh J Salgaonkar wrote:

> On Tue, Mar 15, 2011 at 03:52:38PM +0800, Américo Wang wrote:
>> On Tue, Mar 15, 2011 at 2:13 AM, Mahesh J Salgaonkar
>> <mahesh@linux.vnet.ibm.com> wrote:
>> >
>> > During free we do free all of them including RMO region. But since
>> > the rtas region is always on top of RMO, crashkernel memory overlaps
>> > rtas region and we endup freeing that even, which is causing the
>> > crash.
>> >
>> >
>> Okay, but with this patch applied, we will just ignore rtas region,
>> right?
> Correct.
>> Thus, when I echo 0 to free all the 128M crashkernel memory, the final
>> result will be 32M left, which means crash_size will still show 32M.
>> This looks odd.
>> 
>> How about skipping the 32M as a whole? I mean once the region being
>> freed has overlap with this rtas region, skip the whole rtas region,
>> and let crash_size
>> show 0?
> The existing code from crash_shrink_memory() function reduces the crash
> size to 0 when echo'ed 0. I did test this patchset and verified that
> /sys/kernel/kexec_crash_size show 0 value.

Oh, ok.

Acked-by: WANG Cong <xiyou.wangcong@gmail.com>

Thanks.
