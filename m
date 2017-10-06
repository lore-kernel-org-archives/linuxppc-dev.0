Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y83RV6NsdzDqhb
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 08:58:14 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH0/8] Support for ibm, dynamic-memory-v2 device tree property
In-Reply-To: <150705593139.7318.5934648279979743833.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <150705593139.7318.5934648279979743833.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
Date: Sat, 07 Oct 2017 08:58:12 +1100
Message-ID: <8760bsc51n.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:
> This patch set provides a set of updates to de-couple the LMB information
> provided in the ibm,dynamic-memory device tree property from the device
> tree property format. The goal is to provide a data set of LMB information
> so that consumners of this data do not need to understand and provide
> multiple parsing routines for the supported device tree property formats.

Couple of build problems in this series.

The non-pseries build dies with:

  arch/powerpc/kernel/prom.c:541:4: error: implicit declaration of function 'early_init_dt_scan_drmem_lmbs' [-Werror=implicit-function-declaration]

And pseries dies with:

  arch/powerpc/platforms/pseries/hotplug-memory.c:860:21: error: 'lmbs_available' may be used uninitialized in this function [-Werror=maybe-uninitialized]

cheers
