Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AC9F91A006F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 15:09:58 +1000 (AEST)
Date: Mon, 18 May 2015 15:09:57 +1000
From: Anton Blanchard <anton@samba.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 09/13] selftests, powerpc: Add test for DSCR value
 inheritence across fork
Message-ID: <20150518150957.4c228ac4@kryten>
In-Reply-To: <1428654612-23539-10-git-send-email-khandual@linux.vnet.ibm.com>
References: <1428654612-23539-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1428654612-23539-10-git-send-email-khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, shuahkh@osg.samsung.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anshuman,

Thanks for getting these testcases into the kernel.

> This patch adds a test to verify that the changed DSCR value inside
> any process would be inherited to it's child process across the fork
> system call.

One issue I do notice (a bug in my original test cases too), is that we
don't restore the DSCR on exit. I'm not sure we need to go to the
trouble of saving and restoring it, but we should at least get it back
to 0 when done.

Also a tiny nit, no need for a newline in perror():

open() failed
: Permission denied

With those changes you can add:

Signed-off-by: Anton Blanchard <anton@samba.org>

to the patches based on my testcases.

Anton
