Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rvWMy0LWpzDqQK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 19:10:22 +1000 (AEST)
In-Reply-To: <1468567236-5060-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com,
 clombard@linux.vnet.ibm.com, fbarrat@linux.vnet.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: dan.carpenter@oracle.com
Subject: Re: cxl: fix potential NULL dereference in free_adapter()
Message-Id: <3rvWMx6Pv2z9t17@ozlabs.org>
Date: Wed, 20 Jul 2016 19:10:21 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-15-07 at 07:20:36 UTC, Andrew Donnellan wrote:
> If kzalloc() fails when allocating adapter->guest in
> cxl_guest_init_adapter(), we call free_adapter() before erroring out.
> free_adapter() in turn attempts to dereference adapter->guest, which in
> this case is NULL.
> 
> In free_adapter(), skip the adapter->guest cleanup if adapter->guest is
> NULL.
> 
> Fixes: 14baf4d9c739 ("cxl: Add guest-specific code")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8fbaa51d43ef2c6a72849ec340

cheers
