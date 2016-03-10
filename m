Return-Path: <pmladek@suse.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5DAEB1A02DE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 23:25:17 +1100 (AEDT)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B088D140317
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 23:25:15 +1100 (AEDT)
Date: Thu, 10 Mar 2016 13:25:08 +0100
From: Petr Mladek <pmladek@suse.com>
To: Torsten Duwe <duwe@lst.de>
Cc: jeyu@redhat.com, jkosina@suse.cz, jikos@kernel.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH 2/2] ppc64le live patch: get rid of mini stack frame
Message-ID: <20160310122508.GR10940@pathway.suse.cz>
References: <20160309172821.GC27913@lst.de>
 <20160309173017.GD27913@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160309173017.GD27913@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 2016-03-09 18:30:17, Torsten Duwe wrote:
> After the mini stack frame is no longer required for TOC storage, it can
> be eliminated iff the functionality of klp_return_helper, which required
> a stack frame for the extra return address previously, is carried out
> by the replacement function now. This requires _every_ live patch replacement
> function to execute the following (or similar) sequence of machine instructions
> just before every return to the original caller:

I have thought about it and it is a nono from my point of view.
It is too error prone, especially that there are functions that
call return on several locations.

Best Regards,
Petr
