Return-Path: <kenchen@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.33.17])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ABAF8DDE24
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 07:43:30 +1100 (EST)
Received: from zps18.corp.google.com (zps18.corp.google.com [172.25.146.18])
	by smtp-out.google.com with ESMTP id lA8KhKqa012928
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Nov 2007 20:43:21 GMT
Received: from rv-out-0910.google.com (rvbk15.prod.google.com [10.140.87.15])
	by zps18.corp.google.com with ESMTP id lA8KgQf3009309
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Nov 2007 12:43:20 -0800
Received: by rv-out-0910.google.com with SMTP id k15so242712rvb
	for <linuxppc-dev@ozlabs.org>; Thu, 08 Nov 2007 12:43:20 -0800 (PST)
Message-ID: <b040c32a0711081243gd51acb0m3049ced25411524f@mail.gmail.com>
Date: Thu, 8 Nov 2007 12:43:20 -0800
From: "Ken Chen" <kenchen@google.com>
To: "Adam Litke" <agl@us.ibm.com>
Subject: Re: [PATCH] hugetlb: follow_hugetlb_page for write access
In-Reply-To: <20071107195142.13505.49398.stgit@kernel>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071107195142.13505.49398.stgit@kernel>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Nov 7, 2007 11:51 AM, Adam Litke <agl@us.ibm.com> wrote:
> When calling get_user_pages(), a write flag is passed in by the caller to
> indicate if write access is required on the faulted-in pages.  Currently,
> follow_hugetlb_page() ignores this flag and always faults pages for
> read-only access.  This can cause data corruption because a device driver
> that calls get_user_pages() with write set will not expect COW faults to
> occur on the returned pages.
>
> This patch passes the write flag down to follow_hugetlb_page() and makes
> sure hugetlb_fault() is called with the right write_access parameter.
>
> Signed-off-by: Adam Litke <agl@us.ibm.com>

Adam, this looks good.

Reviewed-by: Ken Chen <kenchen@google.com>
