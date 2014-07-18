Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A73141A0058
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 14:18:57 +1000 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 17 Jul 2014 22:18:55 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id EC74019D8026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 22:18:42 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08026.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6I4He779044470
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 06:17:40 +0200
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6I4IpMJ010160
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 22:18:52 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, kvm-ppc@vger.kernel.org,
 Alexander Graf <agraf@suse.de>
Subject: [PATCH v4 0/2] Use the POWER8 Micro Partition Prefetch Engine in KVM
 HV
Date: Fri, 18 Jul 2014 14:18:41 +1000
Message-Id: <1405657123-20087-1-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1405567197-23333-1-git-send-email-stewart@linux.vnet.ibm.com>
References: <1405567197-23333-1-git-send-email-stewart@linux.vnet.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

changes since v3:
- use kvmppc namespace
- MPP_BUFFER_ORDER of 3 not 4, as we only need 32k and it's already 32k aligned
- split out kvmppc_vcore_create in separate patch
- give a variable a better name: s/tmp/mpp_addr/
- logmpp becomes static inline function

Stewart Smith (2):
  Split out struct kvmppc_vcore creation to separate function
  Use the POWER8 Micro Partition Prefetch Engine in KVM HV on POWER8

 arch/powerpc/include/asm/cache.h      |    7 +++
 arch/powerpc/include/asm/kvm_host.h   |    2 +
 arch/powerpc/include/asm/ppc-opcode.h |   17 +++++++
 arch/powerpc/include/asm/reg.h        |    1 +
 arch/powerpc/kvm/book3s_hv.c          |   88 ++++++++++++++++++++++++++++-----
 5 files changed, 104 insertions(+), 11 deletions(-)

-- 
1.7.10.4
