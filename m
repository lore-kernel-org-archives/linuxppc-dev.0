Return-Path: <bsingharora@gmail.com>
Received: from mail-io0-x230.google.com (mail-io0-x230.google.com
 [IPv6:2607:f8b0:4001:c06::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x9w7W0YcxzDr3L
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 17:35:34 +1000 (AEST)
Received: by mail-io0-x230.google.com with SMTP id h134so38877978iof.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 00:35:34 -0700 (PDT)
Message-ID: <1500276875.8256.3.camel@gmail.com>
Subject: Re: [PATCH v3 02/10] mtd: powernv_flash: Lock around concurrent
 access to OPAL
From: Balbir Singh <bsingharora@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-mtd@lists.infradead.org
Cc: stewart@linux.vnet.ibm.com, alistair@popple.id.au, dwmw2@infradead.org,
 rlippert@google.com
Date: Mon, 17 Jul 2017 17:34:35 +1000
In-Reply-To: <20170712042304.19745-3-cyrilbur@gmail.com>
References: <20170712042304.19745-1-cyrilbur@gmail.com>
 <20170712042304.19745-3-cyrilbur@gmail.com>
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

On Wed, 2017-07-12 at 14:22 +1000, Cyril Bur wrote:
> OPAL can only manage one flash access at a time and will return an
> OPAL_BUSY error for each concurrent access to the flash. The simplest
> way to prevent this from happening is with a mutex.
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---

Should the mutex_lock() be mutex_lock_interruptible()? Are we OK waiting on
the mutex while other operations with the lock are busy?

Balbir Singh.
