Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DA1B6DDE22
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 18:01:51 +1000 (EST)
Date: Thu, 27 Sep 2007 17:01:39 +0900 (JST)
Message-Id: <20070927.170139.-1300534448.kouish@swc.toshiba.co.jp>
To: arnd@arndb.de
Subject: Re: [PATCH 1/7] PowerPC64: Not to insert EA=0 entry at
From: kou.ishizaki@toshiba.co.jp
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

initializing SLB
In-Reply-To: <200709261415.35404.arnd@arndb.de>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
X-Mailer: Mew version 4.2 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> On Wednesday 26 September 2007, Ishizaki Kou wrote:
> > This is a workaround NOT to insert EA=0 entry at initializing SLB.
> > Without this patch, you can see /sbin/init hanging at a machine
> > which has less or equal than 256MB memory.

> Can you elaborate? I don't understand why /sbin/init will hang
> because of an incorrect SLB entry, or how that entry gets
> initialized from get_paca()->kstack.

For latter question, following scenario will occur:
mm/slb.c:slb_flush_and_rebolt() function rebolts SLB entry 1 and 2
by VMALLOC segment and kernel stack segment respectively, but
if we have get_paca()->kstack is set to zero, following condition
will be false,
------------------------------------------------------------------------
105: if ((ksp_esid_data & ESID_MASK) == PAGE_OFFSET) {
------------------------------------------------------------------------
so following line will create shadowed bolted SLB entry 2 with EA=0
------------------------------------------------------------------------
111: slb_shadow_update(get_paca()->kstack, lflags, 2);
------------------------------------------------------------------------
and following lines will create real bolted SLB entry 2.
------------------------------------------------------------------------
125: "r"(mk_vsid_data(ksp_esid_data, lflags),
126: "r"(ksp_esid_data)
------------------------------------------------------------------------

Celleb does not set get_paca()->kstack properly (I don't know which
function should set it up), so we need to workaround.

If we have more than 256MB, SLB entry 2 will be overridden with second
segment of the main storage, so the problem will be washed out.

For former question, bolted SLB entries should not be erased even
if /sbin/init is exec()'ed. Our /sbin/init starts at 0x01000000,
at Segment=0. So SLB entry 2 matches. And the processor fetches
instructions from the kernel, not /sbin/init.

Do above expressions make sense?

> Are you still trying to find a better fix for 2.6.24, or do
> you intend to have this patch go in for now?

I believe setting get_paca()->kstack properly will solve this problem.
Do you have any idea? 

> Also, I did not get a patch 4/7 and 5/7. Did you send them to
> some other mailing list, or did they get lost on the way?

I don't have them too. It seems that they are lost. I resent them.

Best regards,
Kou Ishizaki
