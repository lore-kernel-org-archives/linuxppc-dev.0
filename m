Return-Path: <linasvepstas@gmail.com>
Received: from mail-pd0-x22f.google.com (mail-pd0-x22f.google.com
 [IPv6:2607:f8b0:400e:c02::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4B32D2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jun 2013 03:47:37 +1000 (EST)
Received: by mail-pd0-f175.google.com with SMTP id 4so1167818pdd.34
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 10:47:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1372385489.18612.52.camel@pasglop>
References: <1372384784-20788-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1372385489.18612.52.camel@pasglop>
From: Linas Vepstas <linasvepstas@gmail.com>
Date: Fri, 28 Jun 2013 12:47:14 -0500
Message-ID: <CAHrUA34U+suou7K_RZs7K6xjZDXc8fVX5wNp9Fv3V8cG=dH7RA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/eeh: Update MAINTAINERS
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 27 June 2013 21:11, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Fri, 2013-06-28 at 09:59 +0800, Gavin Shan wrote:
>> Update MAINTAINERS to reflect recent changes.
>>
>> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
>> ---
>>  MAINTAINERS |    4 ++++
>>  1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5be702c..b447392 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6146,10 +6146,14 @@ F:    drivers/firmware/pcdp.*
>>
>>  PCI ERROR RECOVERY
>>  M:
>> +M:   Gavin Shan <shangw@linux.vnet.ibm.com>
>
> Remove Linas, he isn't involved anymore as far as I can tell
> (are you ?)

Not involved any more; I don't have access to equipment, don't have
time, expertise is fading.

>>  L:   linux-pci@vger.kernel.org
>> +L:   linuxppc-dev@lists.ozlabs.org
>>  S:   Supported
>>  F:   Documentation/PCI/pci-error-recovery.txt
>>  F:   Documentation/powerpc/eeh-pci-error-recovery.txt
>> +F:   arch/powerpc/kernel/eeh*.c
>> +F:   drivers/pci/pcie/aer/
>
> Not sure about the AER code. You are not maintaining *that* at least :-)
> Maybe we should split EEH from the rest ?

Based on recent discussions (a month ago?) regarding AER, its clear
that at least some of the AER code is mis-designed, and that some of
the patches being submitted against it were making things worse.   I
suggest keeping an eye on that ... the problem is that both AER and
EEH share a common framework in the PCI subsystem. As bugs in AER get
discovered, there's a chance that someone will submit a patch to the
common framework, or possibly start modifying assorted drivers, which
will then break EEH ... so I don't think it is wise/safe to ignore
AER.

(The point is that AER and EEH really should work exactly the same;
they differ merely by how they talk to the root port).

-- Linas
