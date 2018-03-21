Return-Path: <okaya@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405ZTr4Pl0zDrTt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 14:07:11 +1100 (AEDT)
To: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
Subject: RFC on writel and writel_relaxed
Message-ID: <3611eabe-2999-1482-b2b4-6d216bbe4762@codeaurora.org>
Date: Tue, 20 Mar 2018 22:07:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi PPC Maintainers,

We are seeking feedback on the status of relaxed write API implementation.
What is the motivation for not implementing the relaxed API? 

I see that network drivers are working around the issue by calling
__raw_write() API directly but this also breaks other architectures
like SPARC since the semantics of __raw_writel() seems to be system dependent.

This is putting drivers into a tight position and they cannot achieve true
multi-arch enablement and are forced into calling __raw APIs flavors
directly with #ifdef BIG_ENDIAN ugliness.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
