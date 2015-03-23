Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 046841A2AE3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 09:19:37 +1100 (AEDT)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 23 Mar 2015 16:19:35 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id C75201FF002A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 16:10:44 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2NMJMmr35323912
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 15:19:22 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2NMIEt4018709
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 16:18:15 -0600
Date: Mon, 23 Mar 2015 15:17:20 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [2/9] powerpc/hv24x7: Remove unnecessary parameter
Message-ID: <20150323221720.GB6013@us.ibm.com>
References: <1424210434-28070-3-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150317001352.69BC914010F@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150317001352.69BC914010F@ozlabs.org>
Cc: peterz@infradead.org, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman [mpe@ellerman.id.au] wrote:
| On Tue, 2015-17-02 at 22:00:27 UTC, Sukadev Bhattiprolu wrote:
| > Use pr_notice_ratelimited() to log error messages and remove
| > the 'success_expected' parameter.
| 
| I don't understand how this is equivalent?

They are two unrelated changes that I should have separated.
| 
| The current code uses success_expected to indicate that once it's done the
| request once and found that it works, it then expects the request to continue
| working, and if it doesn't then that is an error.

The current code is using success_expected to _not_ log an error if
that initial request fails. i.e we silently return -EIO here.

I think the 'success_expected' parameter is not really necessary.
We can simply log the message even for that initial request.

And we can log it a lower priority than KERN_ERR since the message
is mostly for developers rather than users who would use event names
(which encode/abstract the domain and offset values).

| 
| Using pr_ratelimited() will do the opposite, ie. the first failure will print a
| message, but that may not really indicate an error, it may just be a badly
| configured request.
| 
| Or at least that's how I understand it, please convince me I'm wrong :)
| 
| cheers
| _______________________________________________
| Linuxppc-dev mailing list
| Linuxppc-dev@lists.ozlabs.org
| https://lists.ozlabs.org/listinfo/linuxppc-dev
