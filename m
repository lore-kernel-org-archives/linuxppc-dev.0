Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVGN91xHQzDqlb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 15:13:45 +1100 (AEDT)
In-Reply-To: <1470102616-18346-1-git-send-email-stewart@linux.vnet.ibm.com>
To: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: neelegup@linux.vnet.ibm.com, Stewart Smith <stewart@linux.vnet.ibm.com>,
 stable@vger.kernel.org
Subject: Re: rtc-opal: Fix handling of firmware error codes, prevent busy loops
Message-Id: <3zVGN90phWz9s83@ozlabs.org>
Date: Mon, 29 Jan 2018 15:13:44 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-08-02 at 01:50:16 UTC, Stewart Smith wrote:
> According to the OPAL docs:
> https://github.com/open-power/skiboot/blob/skiboot-5.2.5/doc/opal-api/opal-rtc-read-3.txt
> https://github.com/open-power/skiboot/blob/skiboot-5.2.5/doc/opal-api/opal-rtc-write-4.txt
> OPAL_HARDWARE may be returned from OPAL_RTC_READ or OPAL_RTC_WRITE and this
> indicates either a transient or permanent error.
> 
> Prior to this patch, Linux was not dealing with OPAL_HARDWARE being a
> permanent error particularly well, in that you could end up in a busy
> loop.
> 
> This was not too hard to trigger on an AMI BMC based OpenPOWER machine
> doing a continuous "ipmitool mc reset cold" to the BMC, the result of
> that being that we'd get stuck in an infinite loop in opal_get_rtc_time.
> 
> We now retry a few times before returning the error higher up the stack.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5b8b58063029f02da573120ef4dc90

cheers
