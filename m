Return-Path: <cyrilbur@gmail.com>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x9wb41FvczDr3M
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 17:56:00 +1000 (AEST)
Received: by mail-io0-x241.google.com with SMTP id h134so6926286iof.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 00:56:00 -0700 (PDT)
Message-ID: <1500278150.29477.1.camel@gmail.com>
Subject: Re: [PATCH v3 02/10] mtd: powernv_flash: Lock around concurrent
 access to OPAL
From: Cyril Bur <cyrilbur@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-mtd@lists.infradead.org
Cc: stewart@linux.vnet.ibm.com, alistair@popple.id.au, dwmw2@infradead.org,
 rlippert@google.com
Date: Mon, 17 Jul 2017 17:55:50 +1000
In-Reply-To: <1500276875.8256.3.camel@gmail.com>
References: <20170712042304.19745-1-cyrilbur@gmail.com>
 <20170712042304.19745-3-cyrilbur@gmail.com>
 <1500276875.8256.3.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-07-17 at 17:34 +1000, Balbir Singh wrote:
> On Wed, 2017-07-12 at 14:22 +1000, Cyril Bur wrote:
> > OPAL can only manage one flash access at a time and will return an
> > OPAL_BUSY error for each concurrent access to the flash. The simplest
> > way to prevent this from happening is with a mutex.
> > 
> > Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> > ---
> 
> Should the mutex_lock() be mutex_lock_interruptible()? Are we OK waiting on
> the mutex while other operations with the lock are busy?
> 

This is a good question. My best interpretation is that
_interruptible() should be used when you'll only be coming from a user
context. Which is mostly true for this driver, however, MTD does
provide kernel interfaces, so I was hesitant, there isn't a great deal
of use of _interruptible() in drivers/mtd. 

Thoughts?

Cyril

> Balbir Singh.
> 
