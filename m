Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E6E542C00D7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 07:54:19 +1000 (EST)
Message-ID: <1367618044.4389.117.camel@pasglop>
Subject: Re: [PATCH -V7 09/10] powerpc: Optimize hugepage invalidate
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Sat, 04 May 2013 07:54:04 +1000
In-Reply-To: <87fvy351gc.fsf@linux.vnet.ibm.com>
References: <1367178711-8232-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1367178711-8232-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130503052846.GU13041@truffula.fritz.box>
 <87fvy351gc.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-mm@kvack.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2013-05-04 at 00:35 +0530, Aneesh Kumar K.V wrote:
> 
> if the firmware doesn't support lockless TLBIE, we need to do locking
> at the guest side. pSeries_lpar_flush_hash_range does that.

We don't "need" to ... it's an optimization because by experience the FW
locking was horrible (and the HW locking is too).

Beware however that the hash routines can take a lock too on
"native" (instead of pHyp)...

Ben.
