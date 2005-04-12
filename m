Return-Path: <linville@bilbo.tuxdriver.com>
Received: from ra.tuxdriver.com (ra.tuxdriver.com [24.172.12.4])
	by ozlabs.org (Postfix) with ESMTP id D5C5467B43
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Apr 2005 23:51:27 +1000 (EST)
Date: Tue, 12 Apr 2005 09:51:16 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Daniel Ann <ktdann@gmail.com>
Message-ID: <20050412135114.GB27920@tuxdriver.com>
References: <9b7ca6570504120138738b554f@mail.gmail.com>
	<20050412122405.GA27920@tuxdriver.com>
	<9b7ca657050412060556af952e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9b7ca657050412060556af952e@mail.gmail.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Trying to understand alloc_skb()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Apr 12, 2005 at 10:05:14PM +0900, Daniel Ann wrote:
> On Apr 12, 2005 9:24 PM, John W. Linville <linville@tuxdriver.com> wrote:
> > You may want to consider dev_alloc_skb...
> 
> Ahh that's right. I remember reading a little comment on top dev_alloc_skb().
> Thank you so much. At least that inspired me :)
> 
> Thing is, I got this error during a call to notifier_call_chain. So..

My guess would be that your best bet is to move your call to
notifier_call_chain off to a workqueue.  notifier_call_chain (and/or
one or more of the functions it is calling) is likely written to
expect to be in process context.

John
-- 
John W. Linville
linville@tuxdriver.com
