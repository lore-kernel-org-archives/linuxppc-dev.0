Return-Path: <rcj@pochix.net>
Received: from mail-ie0-f170.google.com (mail-ie0-f170.google.com
 [209.85.223.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C67A12C0095
 for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2012 02:16:51 +1000 (EST)
Received: by ieak14 with SMTP id k14so603003iea.15
 for <linuxppc-dev@ozlabs.org>; Fri, 07 Sep 2012 09:16:49 -0700 (PDT)
MIME-Version: 1.0
Sender: rcj@pochix.net
In-Reply-To: <1343611946.21647.23.camel@pasglop>
References: <1342630158-16510-1-git-send-email-olaf@aepfle.de>
 <1343611946.21647.23.camel@pasglop>
Date: Fri, 7 Sep 2012 11:16:49 -0500
Message-ID: <CALAi6FcBMthd2+2RsGbVwH4opy2TVFQo4KdT=KEsT06ZUUjtyQ@mail.gmail.com>
Subject: Re: [PATCH] scsi/ibmvscsi: add module alias for ibmvscsic
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, olaf@aepfle.de, Brian J King <bjking1@us.ibm.com>,
 "James E.J. Bottomley" <JBottomley@parallels.com>, linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jul 29, 2012 at 8:32 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2012-07-18 at 18:49 +0200, olaf@aepfle.de wrote:
>> From: Olaf Hering <olaf@aepfle.de>
>>
>> The driver is named ibmvscsic, at runtime it its name is advertised as
>> ibmvscsi. For this reason mkinitrd wont pickup the driver properly.
>> Reported by IBM during SLES11 beta testing:
>>
>> https://bugzilla.novell.com/show_bug.cgi?id=459933
>> LTC50724
>
> So while this would work, I do wonder however whether we could instead
> fix it by simplifying the whole thing as follow since iSeries is now
> gone and so we don't need split backends anymore:
>
> scsi/ibmvscsi: Remove backend abstraction
>
> Now that the iSeries code is gone the backend abstraction
> in this driver is no longer necessary, which allows us to
> consolidate the driver in one file.
>
> The side effect is that the module name is now ibmvscsi.ko
> which matches the driver hotplug name and fixes auto-load
> issues.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.

I've give this a quick test and I prefer this cleanup, it solves the
initial problem nicely.

James, please consider pulling this patch.  Thanks.

Acked-by: Robert Jennings <rcj@linux.vnet.ibm.com>
