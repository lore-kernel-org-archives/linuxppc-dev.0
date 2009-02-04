Return-Path: <nickpiggin@yahoo.com.au>
Received: from smtp109.mail.mud.yahoo.com (smtp109.mail.mud.yahoo.com
	[209.191.85.219]) by ozlabs.org (Postfix) with SMTP id 47DE9DDED1
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2009 16:38:47 +1100 (EST)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: FW: [PATCH] powerpc/mm: Export HPAGE_SHIFT
Date: Wed, 4 Feb 2009 16:31:38 +1100
References: <20090203164930.GA10101@mtls03>
	<1233712248.16867.131.camel@pasglop>
	<20090203211329.d6190a08.akpm@linux-foundation.org>
In-Reply-To: <20090203211329.d6190a08.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200902041631.39784.nickpiggin@yahoo.com.au>
Cc: linuxppc-dev@ozlabs.org, Roland Dreier <rdreier@cisco.com>,
	linux-kernel@vger.kernel.org, Eli Cohen <eli@mellanox.co.il>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 04 February 2009 16:13:29 Andrew Morton wrote:
> On Wed, 04 Feb 2009 12:50:48 +1100 Benjamin Herrenschmidt 
> > Do the generic hugetlbfs code provides such an API ? If not, we may need
> > to add one.
>
> I think it's something like
>
> 	huge_page_size(page_hstate(page))

That would work if you have a page, yes. If you want to query which hugepage
sizes are available, then you probably want for_each_hstate() (which is only
within mm/hugetlb.c at the moment, but I have no objections to exporting it
and symbols it requires).
