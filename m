Return-Path: <dja@axtens.net>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D85931A0EBD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 09:53:13 +1000 (AEST)
Received: by pacex6 with SMTP id ex6so54765122pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 16:53:11 -0700 (PDT)
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
Subject: Re: [PATCH v4 25/32] cxlflash: Fix to prevent EEH recovery failure
In-Reply-To: <F4D4C09B-DEF2-485E-9453-671DF867AE37@linux.vnet.ibm.com>
References: <1443222593-8828-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1443223134-9886-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <87612uuich.fsf@gamma.ozlabs.ibm.com>
 <F4D4C09B-DEF2-485E-9453-671DF867AE37@linux.vnet.ibm.com>
Date: Thu, 01 Oct 2015 09:53:06 +1000
Message-ID: <87mvw3sbvh.fsf@gamma.ozlabs.ibm.com>
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

"Matthew R. Ochs" <mrochs@linux.vnet.ibm.com> writes:

>>> The process_sense() routine can perform a read capacity which
>>> can take some time to complete. If an EEH occurs while waiting
>>> on the read capacity, the EEH handler is unable to obtain the
>>> context's mutex in order to put the context in an error state.
>>> The EEH handler will sit and wait until the context is free,
>>> but this wait can last longer than the EEH handler tolerates,
>>> leading to a failed recovery.
>> 
>> I'm not quite clear on what you mean by the EEH handler timing
>> out. AFAIK there's nothing in eehd and the EEH core that times out if a
>> driver doesn't respond - indeed, it's pretty easy to hang eehd with a
>> misbehaving driver.
>> 
>> Are you referring to your own internal timeouts?
>> cxlflash_wait_for_pci_err_recovery and anything else that uses
>> CXLFLASH_PCI_ERROR_RECOVERY_TIMEOUT?
>
> Reading through this again I can see how this is misleading. This is
> actually similar and related to the deadlock scenario described in
> "Fix to avoid potential deadlock on EEH". Without this fix, you'd end
> up in a similar situation but deadlocked on the context mutex instead
> of the ioctl semaphore.

That makes _much_ more sense. If you could please revise the commit
message to explain that, you can include this in the next version:
Reviewed-by: Daniel Axtens <dja@axtens.net>

Regards,
Daniel
