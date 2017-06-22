Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com [207.54.116.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wttP40MTNzDqj8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 06:25:11 +1000 (AEST)
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
References: <20170622164817.25515-1-logang@deltatee.com>
 <20170622164817.25515-4-logang@deltatee.com>
 <20170622211431.14270378@alans-desktop>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-ntb@googlegroups.com, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Bates <sbates@raithlin.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e856de0b-e9a3-8228-7a73-4daa38cb4479@deltatee.com>
Date: Thu, 22 Jun 2017 14:24:58 -0600
MIME-Version: 1.0
In-Reply-To: <20170622211431.14270378@alans-desktop>
Content-Type: text/plain; charset=windows-1252; format=flowed
Subject: Re: [PATCH 3/7] asm-generic/io.h: make ioread64 and iowrite64
 universally available
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6/22/2017 2:14 PM, Alan Cox wrote:
> If a platform doesn't support 64bit I/O operations from the CPU then you
> either need to use some kind of platform/architecture specific interface
> if present or accept you don't have one.

Yes, I understand that.

The thing is that every user that's currently using it right now is 
patching in their own version that splits it on non-64bit systems.

> It's not safe to split it. Possibly for some use cases you could add an
> ioread64_maysplit()

I'm open to doing something like that.

> What btw is the actual ARM compiler warning ? Is the compiler also trying
> to tell you it's a bad idea ?

It's just the compiler noting that you are mixing volatile and 
non-volatile pointers. Strangely some io{read|write}XX use volatile but 
most do not. But it's nothing crazy.

Logan
