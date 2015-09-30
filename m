Return-Path: <dja@axtens.net>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EA53F1A0A01
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 09:51:33 +1000 (AEST)
Received: by pacex6 with SMTP id ex6so54729404pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 16:51:31 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
Cc: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 27/32] cxlflash: Fix to prevent stale AFU RRQ
In-Reply-To: <FAA7C7C9-EFA4-4135-B39D-E0255980A5E8@linux.vnet.ibm.com>
References: <1443222593-8828-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1443223144-9962-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <8737xyuhun.fsf@gamma.ozlabs.ibm.com>
 <FAA7C7C9-EFA4-4135-B39D-E0255980A5E8@linux.vnet.ibm.com>
Date: Thu, 01 Oct 2015 09:51:22 +1000
Message-ID: <87pp0zsbyd.fsf@gamma.ozlabs.ibm.com>
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


>>> Following an adapter reset, the AFU RRQ that resides in host memory
>>> holds stale data. This can lead to a condition where the RRQ interrupt
>>> handler tries to process stale entries and/or endlessly loops due to an
>>> out of sync generation bit.
>>> 
>>> To fix, the AFU RRQ in host memory needs to be cleared after each reset.
>> 
>> This looks good. Do you need anything to bail out of cxlflash_rrq_irq if
>> the data goes stale or to all Fs while that function is running?
>
> We're not performing an MMIO here, so I'm not sure how the all Fs check
> would apply. We're also protected fairly well by the generation bit. I suppose
> we could look at adding some type of 'max iterations' count to protect against
> a runaway handler but that would be in a future patch.

Ah, right you are. I had confused all Fs with UEs.

Reviewed-by: Daniel Axtens <dja@axtens.net>

Regards,
Daniel
