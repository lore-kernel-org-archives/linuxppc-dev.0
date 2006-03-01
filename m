Return-Path: <mark.fasheh@Oracle.com>
Received: from rgminet02.oracle.com (rgminet02.oracle.com [148.87.113.119])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B840D67A04
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Mar 2006 05:51:58 +1100 (EST)
Received: from rgminet01.oracle.com (rgminet01.oracle.com [148.87.113.118])
	by rgminet02.oracle.com (Switch-3.1.6/Switch-3.1.7) with ESMTP id
	k21HxVd7028719
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Mar 2006 10:59:32 -0700
Date: Wed, 1 Mar 2006 09:59:22 -0800
From: Mark Fasheh <mark.fasheh@Oracle.com>
To: John Rose <johnrose@austin.ibm.com>
Subject: Re: [PATCH] move eeh_add_device_tree_late()
Message-ID: <20060301175922.GX20175@ca-server1.us.oracle.com>
References: <20060301001909.GU20175@ca-server1.us.oracle.com>
	<20060301010249.GV20175@ca-server1.us.oracle.com>
	<1141230954.19095.19.camel@sinatra.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1141230954.19095.19.camel@sinatra.austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, lkml <linux-kernel@vger.kernel.org>
Reply-To: Mark Fasheh <mark.fasheh@Oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 01, 2006 at 10:35:55AM -0600, John Rose wrote:
> Good catch, Mark.
Heh, thanks.

> Commit 827c1a6c1a5dcb2902fecfb648f9af6a532934eb introduced a new
> function that calls eeh_add_device_late() implicitly.  This patch
> reorders the two functions in question to fix the compile error.  This
> might be preferable to exposing eeh_add_device_late() in eeh.h.
Hmm, you still left the EXPORT_SYMBOL(eeh_add_device_late) and you didn't
make eeh_add_device_late() static. Shouldn't you do that if you don't want
to make it accessible outside of eeh.c?
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
