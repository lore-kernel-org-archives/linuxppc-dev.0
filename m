Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C28A81A0352
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 08:59:51 +1000 (AEST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Mon, 21 Sep 2015 16:59:49 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 4C10C1FF0042
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:50:55 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8LMxkls6357426
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 15:59:46 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8LMxjj1011563
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:59:45 -0600
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v2 29/30] cxlflash: Fix to avoid state change collision
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <55FFFBB1.9050802@redhat.com>
Date: Mon, 21 Sep 2015 17:59:45 -0500
Cc: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Message-Id: <7933AA11-CF46-40DA-A7FA-C309C4CBE3C8@linux.vnet.ibm.com>
References: <1442438635-49044-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1442439158-50453-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <55FFFBB1.9050802@redhat.com>
To: Tomas Henzl <thenzl@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Sep 21, 2015, at 7:44 AM, Tomas Henzl <thenzl@redhat.com> wrote:
> On 16.9.2015 23:32, Matthew R. Ochs wrote:
>> The adapter state machine is susceptible to missing and/or
>> corrupting state updates at runtime. This can lead to a variety
>> of unintended issues and is due to the lack of a serialization
>> mechanism to protect the adapter state.
>> 
>> Use an adapter-wide mutex to serialize state changes.
> 
> I've just briefly looked into your code, but it seems to me that
> an atomic variable would serve your needs also and might be 
> more effective resulting in a faster code execution?

Will keep this in mind. 

> If you keep the mutex way you don't need two mutexes
> in cxlflash_afu_sync - you should remove the mutex &sync_active

Agreed. Will remove as part of this patch in v3.
