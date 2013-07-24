Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 359872C00D4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 08:43:04 +1000 (EST)
Date: Wed, 24 Jul 2013 15:43:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 04/10] powerpc: Prepare to support kernel handling of
 IOMMU map/unmap
Message-Id: <20130724154301.2af75867c51870fc0c32819b@linux-foundation.org>
In-Reply-To: <51EDE903.6010608@ozlabs.ru>
References: <1373936045-22653-1-git-send-email-aik@ozlabs.ru>
 <1373936045-22653-5-git-send-email-aik@ozlabs.ru>
 <51EDE903.6010608@ozlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org,
 Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Mel Gorman <mgorman@suse.de>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 23 Jul 2013 12:22:59 +1000 Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> Ping, anyone, please?

ew, you top-posted.

> Ben needs ack from any of MM people before proceeding with this patch. Thanks!

For what?  The three lines of comment in page-flags.h?   ack :)

Manipulating page->_count directly is considered poor form.  Don't
blame us if we break your code ;)

Actually, the manipulation in realmode_get_page() duplicates the
existing get_page_unless_zero() and the one in realmode_put_page()
could perhaps be placed in mm.h with a suitable name and some
documentation.  That would improve your form and might protect the code
from getting broken later on.
