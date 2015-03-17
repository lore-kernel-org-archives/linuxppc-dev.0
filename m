Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CCA2A1A0299
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 11:13:52 +1100 (AEDT)
In-Reply-To: <1424210434-28070-3-git-send-email-sukadev@linux.vnet.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [2/9] powerpc/hv24x7: Remove unnecessary parameter
Message-Id: <20150317001352.69BC914010F@ozlabs.org>
Date: Tue, 17 Mar 2015 11:13:52 +1100 (AEDT)
Cc: peterz@infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-17-02 at 22:00:27 UTC, Sukadev Bhattiprolu wrote:
> Use pr_notice_ratelimited() to log error messages and remove
> the 'success_expected' parameter.

I don't understand how this is equivalent?

The current code uses success_expected to indicate that once it's done the
request once and found that it works, it then expects the request to continue
working, and if it doesn't then that is an error.

Using pr_ratelimited() will do the opposite, ie. the first failure will print a
message, but that may not really indicate an error, it may just be a badly
configured request.

Or at least that's how I understand it, please convince me I'm wrong :)

cheers
