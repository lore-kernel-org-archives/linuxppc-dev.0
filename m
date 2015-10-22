Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9164C1A051F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 13:02:30 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 22 Oct 2015 12:02:28 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0A3522CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 13:02:24 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9M22HRU14221472
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 13:02:25 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9M21ohx015342
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 13:01:51 +1100
Message-ID: <56284395.1060100@au1.ibm.com>
Date: Thu, 22 Oct 2015 13:01:57 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>, Tomas Henzl <thenzl@redhat.com>,
 David Laight <David.Laight@ACULAB.COM>
CC: Michael Neuling <mikey@neuling.org>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 37/37] cxlflash: Fix to avoid bypassing context cleanup
References: <1445458134-63197-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1445458592-63806-1-git-send-email-mrochs@linux.vnet.ibm.com>
In-Reply-To: <1445458592-63806-1-git-send-email-mrochs@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22/10/15 07:16, Matthew R. Ochs wrote:
> Contexts may be skipped over for cleanup in situations where contention
> for the adapter's table-list mutex is experienced in the presence of a
> signal during the execution of the release handler.
>
> This can lead to two known issues:
>
>   - A hang condition on remove as that path tries to wait for users to
>     cleanup - something that will never complete should this scenario play
>     out as the user has already cleaned up from their perspective.
>
>   - An Oops in the unmap_mapping_range() call that is made as part of
>     the user waiting mechanism that is invoked on remove when contexts
>     are found to still exist.
>
> The root cause of this issue can be found in get_context() and how the
> table-list mutex is acquired. As this code path is shared by several
> different access points within the driver, a decision was made during
> the development cycle to acquire this mutex in this location using the
> interruptible version of the mutex locking service. In almost all of
> the use-cases and environmental scenarios this holds up, even when the
> mutex is contended. However, for critical system threads (such as the
> release handler), failing to acquire the mutex and bailing with the
> intention of the user being able to try again later is unacceptable.
>
> In such a scenario, the context _must_ be derived as it is on an
> irreversible path to being freed. Without being able to derive the
> context, the code mistakenly assumes that it has already been freed
> and proceeds to free up the underlying CXL context resources. From
> this point on, any usage of [the now stale] CXL context resources
> will result in undefined behavior. This is root cause of the Oops
> mentioned as the second known issue as the mapping passed to the
> unmap_mapping_range() service is owned by the CXL context.
>
> To fix this problem, acquisition of the table-list mutex within
> get_context() is simply changed to use the uninterruptible version
> of the mutex locking service. This is safe as the timing windows for
> holding this mutex are short and also protected against blocking.
>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
