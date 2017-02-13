Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vM6H53BFczDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 11:43:29 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vipin K Parashar <vipin@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Stewart Smith  <stewart@linux.vnet.ibm.com>
Subject: Re: [PATCH] powernv/opal: Handle OPAL_WRONG_STATE error from OPAL
 fails
In-Reply-To: <3539f32e-4caf-df07-7e8e-f1730da692dc@linux.vnet.ibm.com>
References: <1482243419-23041-1-git-send-email-vipin@linux.vnet.ibm.com>
 <87sho58ifo.fsf@concordia.ellerman.id.au>
 <3539f32e-4caf-df07-7e8e-f1730da692dc@linux.vnet.ibm.com>
Date: Mon, 13 Feb 2017 11:43:26 +1100
Message-ID: <87a89qsyxd.fsf@concordia.ellerman.id.au>
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

Vipin K Parashar <vipin@linux.vnet.ibm.com> writes:

> OPAL returns OPAL_WRONG_STATE for XSCOM operations
>
> done to read any core FIR which is sleeping, offline.

OK.

Do we know why Linux is causing that to happen?

It's also returned from many of the XIVE routines if we're in the wrong
xive mode, all of which would indicate a fairly bad Linux bug.

Also the skiboot patch which added WRONG_STATE for XSCOM ops did so
explicitly so we could differentiate from other errors:

    commit 9c2d82394fd2303847cac4a665dee62556ca528a
    Author:     Russell Currey <ruscur@russell.cc>
    AuthorDate: Mon Mar 21 12:00:00 2016 +1100

    xscom: Return OPAL_WRONG_STATE on XSCOM ops if CPU is asleep
    
    xscom_read and xscom_write return OPAL_SUCCESS if they worked, and
    OPAL_HARDWARE if they didn't.  This doesn't provide information about why
    the operation failed, such as if the CPU happens to be asleep.
    
    This is specifically useful in error scanning, so if every CPU is being
    scanned for errors, sleeping CPUs likely aren't the cause of failures.
    
    So, return OPAL_WRONG_STATE in xscom_read and xscom_write if the CPU is
    sleeping.
    
    Signed-off-by: Russell Currey <ruscur@russell.cc>
    Reviewed-by: Alistair Popple <alistair@popple.id.au>
    Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>



So I'm still not convinced that quietly swallowing this error and
mapping it to -EIO along with several of the other error codes is the
right thing to do.

cheers
