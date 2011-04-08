Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 973F9B6F7C
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Apr 2011 02:57:07 +1000 (EST)
Received: by gwb17 with SMTP id 17so2279716gwb.15
	for <linuxppc-dev@ozlabs.org>; Fri, 08 Apr 2011 09:57:05 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20110408153246.GA13834@ovro.caltech.edu>
References: <D4BE3D54-805B-4D4F-B8BC-EC1A860C8E84@kernel.crashing.org>
	<20110408153246.GA13834@ovro.caltech.edu>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 8 Apr 2011 09:56:45 -0700
Message-ID: <BANLkTikJzhY9=p9NkCovHgQA0YtfYBMuSw@mail.gmail.com>
Subject: Re: platform_driver/of_platform_driver compile warning in fsldma.c
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 8, 2011 at 8:32 AM, Ira W. Snyder <iws@ovro.caltech.edu> wrote:
> On Fri, Apr 08, 2011 at 04:12:13AM -0500, Kumar Gala wrote:
>> Grant,
>>
>> I'm being lazy, can you give any quick insight on the following compile warning:
>>
>> drivers/dma/fsldma.c:1457:2: warning: initialization from incompatible pointer type
>> drivers/dma/fsldma.c: In function 'fsldma_init':
>> drivers/dma/fsldma.c:1468:2: warning: passing argument 1 of 'platform_driver_register' from incompatible pointer type
>> include/linux/platform_device.h:124:12: note: expected 'struct platform_driver *' but argument is of type 'struct of_platform_driver *'
>> drivers/dma/fsldma.c: In function 'fsldma_exit':
>> drivers/dma/fsldma.c:1473:2: warning: passing argument 1 of 'platform_driver_unregister' from incompatible pointer type
>> include/linux/platform_device.h:125:13: note: expected 'struct platform_driver *' but argument is of type 'struct of_platform_driver *'
>>
>
> The "struct of_platform_driver" needs to be changed to a
> "struct platform_driver". Just remove the "of_" prefix, the structure
> initialization is correct. I sent a patch for this yesterday to LKML. The
> title is: fsldma: fix build warning caused by of_platform_device changes

Yes, thanks Ira.  I'm picking up that patch today and I'll send it off to Linus.

g.
