Return-Path: <key@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e31.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B308D2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2012 05:59:51 +1000 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <key@linux.vnet.ibm.com>;
 Wed, 15 Aug 2012 13:59:48 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id E31091FF003C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Aug 2012 13:59:40 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q7FJxJ0T171146
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Aug 2012 13:59:19 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q7FJxHJI005656
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Aug 2012 13:59:18 -0600
Date: Wed, 15 Aug 2012 14:59:37 -0500
From: Kent Yoder <key@linux.vnet.ibm.com>
To: Ashley Lai <adlai@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 0/3] tpm: Add new vTPM device driver for PPC64
Message-ID: <20120815195937.GA27618@linux.vnet.ibm.com>
References: <1344986638.4430.22.camel@footlong>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1344986638.4430.22.camel@footlong>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 tpmdd-devel@lists.sourceforge.net, adlai@us.ibm.com, rcj@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 14, 2012 at 06:23:58PM -0500, Ashley Lai wrote:
> Change log V3:
> - Replaced TPM_NO_EVENT_LOG macro with stubs
> - Removed tpm_noeventlog.c file 
> - Called of_node_put() before return in tpm_of.c
> 
> Change log V2:
> - Removed unnecessary tpm_bios_log_setup and tpm_bios_log_teardown
>   functions in tpm_eventlog.h (patch 3/3).
> - Added more descriptions on vTPM (patch 1/3).
> 
> These patches add support for IBM vTPM for PPC64. This new device driver
> works on firmware that supports vTPM (firmware release 740 or higher).
> 
> Tested on Power7+ system with firmware level ZM770_001.
> 
> Applied to Kent Yoder tree at:
> https://github.com/shpedoikal/linux/tree/v3.6-rc1-tpmdd-staging

  Thanks Ashley, I've added the patches to that tree.

Kent

> 
> Ashley Lai (3):
>   drivers/char/tpm: Add new device driver to support IBM vTPM
>   PPC64: Add support for instantiating SML from Open Firmware
>   drivers/char/tpm: Add securityfs support for event log
> 
>  arch/powerpc/kernel/prom_init.c |   62 ++++
>  drivers/char/tpm/Kconfig        |    8 +
>  drivers/char/tpm/Makefile       |    6 +
>  drivers/char/tpm/tpm.h          |   13 +-
>  drivers/char/tpm/tpm_eventlog.h |   15 +
>  drivers/char/tpm/tpm_ibmvtpm.c  |  749 +++++++++++++++++++++++++++++++++++++++
>  drivers/char/tpm/tpm_ibmvtpm.h  |   83 +++++
>  drivers/char/tpm/tpm_of.c       |   73 ++++
>  8 files changed, 997 insertions(+), 12 deletions(-)
>  create mode 100644 drivers/char/tpm/tpm_ibmvtpm.c
>  create mode 100644 drivers/char/tpm/tpm_ibmvtpm.h
>  create mode 100644 drivers/char/tpm/tpm_of.c
> 
> 
