Return-Path: <thenzl@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AE18A1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 23:14:49 +1000 (AEST)
Subject: Re: [PATCH v5 08/34] cxlflash: Fix to avoid CXL services during EEH
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>
References: <1443714773-9176-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1443714926-15545-1-git-send-email-mrochs@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
From: Tomas Henzl <thenzl@redhat.com>
Message-ID: <560E8344.9040608@redhat.com>
Date: Fri, 2 Oct 2015 15:14:44 +0200
MIME-Version: 1.0
In-Reply-To: <1443714926-15545-1-git-send-email-mrochs@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 1.10.2015 17:55, Matthew R. Ochs wrote:
> During an EEH freeze event, certain CXL services should not be
> called until after the hardware reset has taken place. Doing so
> can result in unnecessary failures and possibly cause other ill
> effects by triggering hardware accesses. This translates to a
> requirement to quiesce all threads that may potentially use CXL
> runtime service during this window. In particular, multiple ioctls
> make use of the CXL services when acting on contexts on behalf of
> the user. Thus, it is essential to 'drain' running ioctls _before_
> proceeding with handling the EEH freeze event.
>
> Create the ability to drain ioctls by wrapping the ioctl handler
> call in a read semaphore and then implementing a small routine that
> obtains the write semaphore, effectively creating a wait point for
> all currently executing ioctls.
>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
> Reviewed-by: Brian King <brking@linux.vnet.ibm.com>
> Reviewed-by: Daniel Axtens <dja@axtens.net>

Reviewed-by: Tomas Henzl <thenzl@redhat.com>

Tomas
