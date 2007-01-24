Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 2A205DDF2B
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 10:15:45 +1100 (EST)
Date: Wed, 24 Jan 2007 16:16:14 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 14/18] Make flatdevtree_misc's cxt global.
Message-ID: <20070124231614.GC19266@mag.az.mvista.com>
References: <20070124210726.GN10527@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070124210726.GN10527@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 24, 2007 at 03:07:26PM -0600, Scott Wood wrote:
> This allows platform code to use flatdevtree functions directly.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---

Scott,

I have to to thru your patches in detail but I have a comment about this
patch...

I don't think this one is a good idea.  Platform code shouldn't be using
flatdevtree.c code directly because it will be replaced by libfdt code.
For functionality that isn't already accessible, you should define an
interface then access it thru the interface glue code (i.e.,
flatdevtree_misc.c).  This will separate the calls that bootwrapper code
uses from whatever the underlying implementation is.

Mark
