Return-Path: <thenzl@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BFADC1A0FB3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2015 00:42:06 +1100 (AEDT)
Subject: Re: [PATCH v6 21/37] cxlflash: Correct behavior in device reset
 handler following EEH
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>
References: <1445458134-63197-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1445458464-40183-1-git-send-email-mrochs@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Tomas Henzl <thenzl@redhat.com>
Message-ID: <562A3929.2070608@redhat.com>
Date: Fri, 23 Oct 2015 15:42:01 +0200
MIME-Version: 1.0
In-Reply-To: <1445458464-40183-1-git-send-email-mrochs@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21.10.2015 22:14, Matthew R. Ochs wrote:
> When the device reset handler is entered while a reset operation
> is taking place, the handler exits without actually sending a
> reset (TMF) to the targeted device. This behavior is incorrect
> as the device is not reset. Further complicating matters is the
> fact that a success is returned even when the TMF was not sent.
>
> To fix, the state is rechecked after coming out of the reset
> state. When the state is normal, a TMF will be sent out.
>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
> Reviewed-by: Brian King <brking@linux.vnet.ibm.com>

Reviewed-by: Tomas Henzl <thenzl@redhat.com>

Tomas
