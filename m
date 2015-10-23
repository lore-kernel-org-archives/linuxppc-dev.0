Return-Path: <thenzl@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CBF341A018F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2015 01:00:08 +1100 (AEDT)
Subject: Re: [PATCH v6 30/37] cxlflash: Fix to avoid corrupting adapter fops
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>
References: <1445458134-63197-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1445458537-60298-1-git-send-email-mrochs@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Tomas Henzl <thenzl@redhat.com>
Message-ID: <562A3D63.7020707@redhat.com>
Date: Fri, 23 Oct 2015 16:00:03 +0200
MIME-Version: 1.0
In-Reply-To: <1445458537-60298-1-git-send-email-mrochs@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21.10.2015 22:15, Matthew R. Ochs wrote:
> The fops owned by the adapter can be corrupted in certain scenarios,
> opening a window where certain fops are temporarily NULLed before being
> reset to their proper value. This can potentially lead software to make
> incorrect decisions, leaving the user with the inability to function as
> intended.
>
> An example of this behavior can be observed when there are a number of
> users with a high rate of turn around (attach to LUN, perform an I/O,
> detach from LUN, repeat). Every so often a user is given a valid
> context and adapter file descriptor, but the file associated with the
> descriptor lacks the correct read permission bit (FMODE_CAN_READ) and
> thus the read system call bails before calling the valid read fop.
>
> Background:
>
> The fops is stored in the adapter structure to provide the ability to
> lookup the adapter structure from within the fop handler. CXL services
> use the file's private_data and at present, the CXL context does not
> have a private section. In an effort to limit areas of the cxlflash
> driver with code specific the superpipe function, a design choice was
> made to keep the details of the fops situated away from the legacy
> portions of the driver. This drove the behavior that the adapter fops
> is set at the beginning of the disk attach ioctl handler when there
> are no users present.
>
> The corruption that this fix remedies is due to the fact that the fops
> is initially defaulted to values found within a static structure. When
> the fops is handed down to the CXL services later in the attach path,
> certain services are patched. The fops structure remains correct until
> the user count drops to 0 and the fops is reset, triggering the process
> to repeat again. The user counts are tightly coupled with the creation
> and deletion of the user context. If multiple users perform a disk
> attach at the same time, when the user count is currently 0, some users
> can be in the middle of obtaining a file descriptor and have not yet
> reached the context creation code that [in addition to creating the
> context] increments the user count. Subsequent users coming in to
> perform the attach see that the user count is still 0, and reinitialize
> the fops, temporarily removing the patched fops. The users that are in
> the middle obtaining their file descriptor may then receive an invalid
> descriptor.
>
> The fix simply removes the user count altogether and moves the fops
> initialization to probe time such that it is only performed one time
> for the life of the adapter. In the future, if the CXL services adopt
> a private member for their context, that could be used to store the
> adapter structure reference and cxlflash could revert to a model that
> does not require an embedded fops.
>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
> Reviewed-by: Brian King <brking@linux.vnet.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Reviewed-by: Daniel Axtens <dja@axtens.net>

Reviewed-by: Tomas Henzl <thenzl@redhat.com>

Tomas
