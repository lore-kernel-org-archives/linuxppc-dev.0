Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 14BE2B6F83
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Mar 2011 15:33:47 +1100 (EST)
Subject: Re: [PATCH 1/2] kdump: Allow shrinking of kdump region to be
	overridden
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <im6fj2$576$1@dough.gmane.org>
References: <20100825002258.GD28360@kryten> <m139u37cii.fsf@fess.ebiederm.org>
	<4D771EE6.5050404@linux.vnet.ibm.com>
	<20110309122046.GC16951@cr0.redhat.com>
	<20110309234657.264d3080@kryten>
	<20110309142108.GD16951@cr0.redhat.com>
	<20110314181315.GA16075@in.ibm.com>
	<AANLkTi=aDzCaa7_=5XTrnJCzmZPrDy3omXwDarEF8XmH@mail.gmail.com>
	<20110315165219.GA22509@in.ibm.com>  <im6fj2$576$1@dough.gmane.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 24 Mar 2011 15:33:30 +1100
Message-ID: <1300941210.2402.414.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@au1.ibm.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	WANG Cong <xiyou.wangcong@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-03-21 at 03:10 +0000, WANG Cong wrote:
> On Tue, 15 Mar 2011 22:22:19 +0530, Mahesh J Salgaonkar wrote:

> >> Okay, but with this patch applied, we will just ignore rtas region,
> >> right?
> > Correct.
> >> Thus, when I echo 0 to free all the 128M crashkernel memory, the final
> >> result will be 32M left, which means crash_size will still show 32M.
> >> This looks odd.
> >> 
> >> How about skipping the 32M as a whole? I mean once the region being
> >> freed has overlap with this rtas region, skip the whole rtas region,
> >> and let crash_size
> >> show 0?
> > The existing code from crash_shrink_memory() function reduces the crash
> > size to 0 when echo'ed 0. I did test this patchset and verified that
> > /sys/kernel/kexec_crash_size show 0 value.
> 
> Oh, ok.
> 
> Acked-by: WANG Cong <xiyou.wangcong@gmail.com>

So Eric, what's the right approach to get that merged ? This is a bug
gating an important delivery for us, and the patch doesn't appear
terribly invasive ? :-)

I can send it to Linus myself if you prefer and give me your Ack.

Cheers,
Ben.
