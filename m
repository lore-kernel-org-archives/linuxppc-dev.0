Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 81C5BDDE10
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 02:32:06 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id lAJFW2s4065836
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 15:32:02 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.6) with
	ESMTP id lAJFW1at2060332
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 16:32:01 +0100
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id lAJFW1p2027162
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 16:32:01 +0100
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Adam Litke <agl@us.ibm.com>
Subject: Re: [PATCH] hugetlb: follow_hugetlb_page for write access
Date: Mon, 19 Nov 2007 16:25:00 +0100
References: <20071107195142.13505.49398.stgit@kernel>
In-Reply-To: <20071107195142.13505.49398.stgit@kernel>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200711191625.00882.hnguyen@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Ken Chen <kenchen@google.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 07 November 2007 20:51, Adam Litke wrote:
> 
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
Apologize for this late response.
Tested on 2.6.23 with ehca and mthca. It works like a charm for me.
Thanks!
Nam
