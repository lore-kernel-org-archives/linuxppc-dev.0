Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0BFF92C00D5
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 18:26:48 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 02:26:45 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id BCB60C90026
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 02:26:39 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23032.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1P7QgBJ51904638
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 07:26:42 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1P7Qgje027632
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 02:26:42 -0500
Date: Tue, 25 Feb 2014 15:26:26 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/9] EEH improvement
Message-ID: <20140225072626.GA30401@shangw.(null)>
References: <1393306670-17435-1-git-send-email-shangw@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393306670-17435-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 25, 2014 at 01:37:41PM +0800, Gavin Shan wrote:
>The series of patches intends to improve reliability of EEH on PowerNV
>platform. First all, we have had multiple duplicate states (flags) for
>PHB and PE, so we remove those duplicate states to simplify the code.
>Besides, we had corrupted PHB diag-data for case of frozen PE. In order
>to solve the problem, we introduce eeh_ops->event() and notifications
>are sent from EEH core to (PowerNV) platform on creating or destroying
>PE instance so that we can allocate or free PHB diag-data backend. Then
>we cache the PHB diag-data on the first call to eeh_ops->get_state()
>and dump it afterwards, which helps to get correct PHB diag-data.
>
>With the patchset applied, we never dump PHB diag-data for INF errors.
>Instead, we just maintain statistics in /proc/powerpc/eeh_inf_err. Also,
>we changed the PHB diag-data dump format for a bit to have multiple
>fields per line and omits the line with all zero'd fields as Ben suggested.
>
>
>v1 -> v2:
>	* Amending commit logs
>	* Support eeh_ops->event() and maintain PHB diag-data on basis
>	  of PE instance
>	* When dumping PHB diag-data, to replace "-" with "00000000" and
>	  omit the line if the fields of it are all zeros.
>

Please ignore this and I'm going to send out v3 where we just
grab and dump the PHB diag-data (without cache any more) as
Ben suggested :-)

Thanks,
Gavin

>---
>
>arch/powerpc/include/asm/eeh.h               |    7 ++-
>arch/powerpc/kernel/eeh.c                    |   10 +---
>arch/powerpc/kernel/eeh_driver.c             |   10 ++--
>arch/powerpc/kernel/eeh_pe.c                 |   39 ++++++++++++-
>arch/powerpc/platforms/powernv/eeh-ioda.c    |  193 ++++++++++++++++++++++++++++++++++++-------------------------
>arch/powerpc/platforms/powernv/eeh-powernv.c |   74 +++++++++++++++++++-----
>arch/powerpc/platforms/powernv/pci.c         |  228 +++++++++++++++++++++++++++++++++++++++++-------------------------
>arch/powerpc/platforms/powernv/pci.h         |   11 ++--
>arch/powerpc/platforms/pseries/eeh_pseries.c |    3 +-
>9 files changed, 358 insertions(+), 217 deletions(-)
>
>Thanks,
>Gavin
>
