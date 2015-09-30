Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22c.google.com (mail-pa0-x22c.google.com
 [IPv6:2607:f8b0:400e:c03::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 096BD1A002B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 10:08:32 +1000 (AEST)
Received: by padhy16 with SMTP id hy16so20272831pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 17:08:30 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
Cc: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Manoj Kumar <manoj@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 29/32] cxlflash: Fix to double the delay each time
In-Reply-To: <11CB17AB-0383-41C8-8398-7B875E480A82@linux.vnet.ibm.com>
References: <1443222593-8828-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1443223157-10039-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <87wpvat33j.fsf@gamma.ozlabs.ibm.com>
 <11CB17AB-0383-41C8-8398-7B875E480A82@linux.vnet.ibm.com>
Date: Wed, 30 Sep 2015 10:08:21 +1000
Message-ID: <87bncku5u2.fsf@gamma.ozlabs.ibm.com>
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

>> On Sep 28, 2015, at 8:40 PM, Daniel Axtens <dja@axtens.net> wrote:
>> 
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA512
>> 
>> "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com> writes:
>> 
>>> From: Manoj Kumar <manoj@linux.vnet.ibm.com>
>>> 
>>> The operator used to double the delay is incorrect and
>>> does not result in delay doubling.
>>> 
>>> To fix, use a left shift instead of the XOR operator.
>>> 
>> I can see that the patch is correct, but this commit message is a bit
>> confusing. What delay? In what circumstances are you doubling it? Why?
>
> This is the response delay while resetting the master context. The reset
> is performed by writing a bit and then waiting for it to clear. While waiting
> for it to clear, the code relaxes the delta between MMIO reads.

OK. If you do a v5, please include this in the commit message.

Regards,
Daniel
