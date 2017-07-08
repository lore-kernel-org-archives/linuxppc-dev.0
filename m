Return-Path: <computersforpeace@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x4DPq5YcvzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Jul 2017 11:28:15 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id z6so6541276pfk.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Jul 2017 18:28:15 -0700 (PDT)
Date: Fri, 7 Jul 2017 18:28:11 -0700
From: Brian Norris <computersforpeace@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org,
 stewart@linux.vnet.ibm.com, dwmw2@infradead.org
Subject: Re: [PATCH 5/5] mtd: powernv_flash: Use
 opal_async_wait_response_interruptible()
Message-ID: <20170708012811.GF55942@google.com>
References: <20170629065413.19845-1-cyrilbur@gmail.com>
 <20170629065413.19845-6-cyrilbur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170629065413.19845-6-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 29, 2017 at 04:54:13PM +1000, Cyril Bur wrote:
> The OPAL calls performed in this driver shouldn't be using
> opal_async_wait_response() as this performs a wait_event() which, on
> long running OPAL calls could result in hung task warnings. wait_event()
> also prevents timely signal delivery which is also undesirable.
> 
> This patch also attempts to quieten down the use of dev_err() when
> errors haven't actually occurred and also to return better information up
> the stack rather than always -EIO.
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---
>  drivers/mtd/devices/powernv_flash.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)

Seems OK:

Acked-by: Brian Norris <computersforpeace@gmail.com>
