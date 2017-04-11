Return-Path: <minchan.kim@gmail.com>
Received: from mail-pg0-x22d.google.com (mail-pg0-x22d.google.com
 [IPv6:2607:f8b0:400e:c05::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2C5m2RqhzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 13:22:04 +1000 (AEST)
Received: by mail-pg0-x22d.google.com with SMTP id 21so115484420pgg.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 20:22:04 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Tue, 11 Apr 2017 12:21:47 +0900
From: Minchan Kim <minchan@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: clear_page, copy_page address align question?
Message-ID: <20170411032147.GA2283@bgram>
References: <20170411030823.GB6545@bbox>
 <1491880344.4166.224.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491880344.4166.224.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 11, 2017 at 01:12:24PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2017-04-11 at 12:08 +0900, Minchan Kim wrote:
> > Hello,
> > 
> > When I tested zram in ppc64, I got random corruption.
> > With investigation, it seems clear_page corrupted the memory.
> > I passed 64K kmalloced(kmalloc(PAGE_SIZE)) address to clear_page
> > and turned on slub debug so address is not aligned with PAGE_SIZE.
> > Is it a valid usecase that non-PAGE_SIZE aligned address is
> > used for clear_page in ppc64?
> > 
> > As well, copy_page have same rule, too?
> > 
> > Anyway, when I changed clear_page to memset, it seems the problem
> > is gone.
> 
> Yes, both clear_page and copy_page assume a PAGE_SHIFT alignment and
> are highly optimize according to this.
> 
> I wouldn't be surprised of other architectures implementations are the
> same.
> 
> I don't think it's ever legit to call these functions for something
> that isn't a naturally aligned page.


If it's the common for every architecture, it would have better to
have description about that in somewhere or WARN_ON. :(

Thanks for the confirm!
