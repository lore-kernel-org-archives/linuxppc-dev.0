Return-Path: <bsingharora@gmail.com>
Received: from mail-io0-x229.google.com (mail-io0-x229.google.com
 [IPv6:2607:f8b0:4001:c06::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x9xpv2z28zDrCx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 18:51:19 +1000 (AEST)
Received: by mail-io0-x229.google.com with SMTP id h134so39684058iof.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 01:51:19 -0700 (PDT)
Message-ID: <1500281422.8256.5.camel@gmail.com>
Subject: Re: [PATCH v3 03/10] mtd: powernv_flash: Don't treat OPAL_SUCCESS
 as an error
From: Balbir Singh <bsingharora@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-mtd@lists.infradead.org
Cc: stewart@linux.vnet.ibm.com, alistair@popple.id.au, dwmw2@infradead.org,
 rlippert@google.com
Date: Mon, 17 Jul 2017 18:50:22 +1000
In-Reply-To: <20170712042304.19745-4-cyrilbur@gmail.com>
References: <20170712042304.19745-1-cyrilbur@gmail.com>
 <20170712042304.19745-4-cyrilbur@gmail.com>
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
> While this driver expects to interact asynchronously, OPAL is well
> within its rights to return OPAL_SUCCESS to indicate that the operation
> completed without the need for a callback. We shouldn't treat
> OPAL_SUCCESS as an error rather we should wrap up and return promptly to
> the caller.
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---
> I'll note here that currently no OPAL exists that will return
> OPAL_SUCCESS so there isn't the possibility of a bug today.

It would help if you mentioned OPAL_SUCCESS to the async call. So effectively
what we expected to be an asynchronous call with callback, but OPAL returned
immediately with success.

Balbir Singh.
