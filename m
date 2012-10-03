Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 896B92C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2012 08:20:04 +1000 (EST)
Date: Wed, 3 Oct 2012 15:20:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexandre Bounine <alexandre.bounine@idt.com>
Subject: Re: [PATCH 1/5] rapidio: fix blocking wait for discovery ready
Message-Id: <20121003152001.665c9373.akpm@linux-foundation.org>
In-Reply-To: <1349291923-22860-2-git-send-email-alexandre.bounine@idt.com>
References: <1349291923-22860-1-git-send-email-alexandre.bounine@idt.com>
 <1349291923-22860-2-git-send-email-alexandre.bounine@idt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed,  3 Oct 2012 15:18:39 -0400
Alexandre Bounine <alexandre.bounine@idt.com> wrote:

> Fix blocking wait loop in the RapidIO discovery routine to avoid warning
> dumps about stalled CPU on x86 platforms.
> 
> ...
>
> +		to_end = jiffies + CONFIG_RAPIDIO_DISC_TIMEOUT * HZ;
> +		while (time_before(jiffies, to_end)) {
> +			if (rio_enum_complete(mport))
> +				goto enum_done;
> +			schedule_timeout_uninterruptible(msecs_to_jiffies(10));

I think a simple msleep(10) would suffice here?
