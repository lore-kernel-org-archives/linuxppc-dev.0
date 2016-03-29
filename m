Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZPzj3LTxzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 09:08:17 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Tue, 29 Mar 2016 16:08:15 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 901BFC500B2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 15:56:22 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u2TM8DqP36307070
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 15:08:13 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2TM8Cr4026567
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 16:08:13 -0600
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] cxl: fix setting of _PAGE_USER bit when handling page
 faults
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <1458273681-18588-1-git-send-email-andrew.donnellan@au1.ibm.com>
Date: Tue, 29 Mar 2016 17:08:10 -0500
Cc: linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com
Message-Id: <3BCAACA7-3DB2-4F6B-BE5C-96925C2ED4F8@linux.vnet.ibm.com>
References: <1458273681-18588-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Mar 17, 2016, at 11:01 PM, Andrew Donnellan =
<andrew.donnellan@au1.ibm.com> wrote:
>=20
> When handling page faults, cxl_handle_page_fault() checks whether the =
page
> should be accessible by userspace and have its _PAGE_USER access bit =
set.
> _PAGE_USER should be set if the context's kernel flag isn't set, or if =
the
> page falls outside of kernel memory.
>=20
> However, the check currently uses the wrong operator, causing it to =
always
> evalute to true. As such, we always set the _PAGE_USER bit, even when =
it
> should be restricted to the kernel.
>=20
> Fix the check so that the _PAGE_USER bit is set only as intended.
>=20
> Fixes: f204e0b8cedd ("cxl: Driver code for powernv PCIe based cards =
for
> userspace access")
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Per Ian's suggestion, I went ahead and tried this with cxlflash.

Tested-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
