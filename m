Return-Path: <dedekind1@gmail.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by ozlabs.org (Postfix) with ESMTP id 9F8482C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2013 22:29:05 +1000 (EST)
Message-ID: <1368189108.26780.156.camel@sauron.fi.intel.com>
Subject: Re: [upstream] mtd/ifc: fix ifc driver memory release issue
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Brian Norris <computersforpeace@gmail.com>
Date: Fri, 10 May 2013 15:31:48 +0300
In-Reply-To: <CAN8TOE-fpTYj5Z5VW=MbH6epK9Ymc+=uQkh7V6=k=76_DjouPA@mail.gmail.com>
References: <1364387100-23013-1-git-send-email-tie-fei.zang@freescale.com>
 <CAN8TOE-fpTYj5Z5VW=MbH6epK9Ymc+=uQkh7V6=k=76_DjouPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Li Hao <b44421@freescale.com>, linux-mtd@lists.infradead.org,
 scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org, dwmw2@infradead.org,
 Cao Yonghua <b43619@freescale.com>
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-03-28 at 21:28 -0700, Brian Norris wrote:
> On Wed, Mar 27, 2013 at 5:25 AM, Roy Zang <tie-fei.zang@freescale.com> wrote:
> > memory is allocated by devm_kzalloc, so release it using
> > devm_kfree() instead kfree();
> 
> You are correct that it should not be freed with kfree(). But the
> correct solution is that it does not need to be freed (explicitly) at
> all. That's the whole point of the managed allocators (i.e.,
> devm_kzalloc()). Try this patch instead. Totally untested here.

Pushed to l2-mtd.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
