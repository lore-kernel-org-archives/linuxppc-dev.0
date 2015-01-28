Return-Path: <stripathi@apm.com>
Received: from mail-yk0-f178.google.com (exprod5og120.obsmtp.com [64.18.0.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A8F781A08CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 00:22:23 +1100 (AEDT)
Received: by mail-yk0-f178.google.com with SMTP id q200so8840580ykb.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 05:22:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2323575.nqxsEzcHbG@wuerfel>
References: <1422379260-10139-1-git-send-email-stripathi@apm.com>
 <CAOHikRB4tSkJsMccqHRS8XYULaP+dS7KujeSLh+ZpTxDDOF5xQ@mail.gmail.com>
 <CAOHikRAOVMQiOy_VrXmJU1e+8KBwOFSfX1uSKvfdbVG=Br2ocg@mail.gmail.com>
 <2323575.nqxsEzcHbG@wuerfel>
Date: Wed, 28 Jan 2015 18:52:20 +0530
Message-ID: <CAOHikRDb8aVbP+5yMxxE-d4qeO3gbz2wnZGmMB7b7+eoF+pm=g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] arm64: dts: Add the arasan sdhc nodes in
 apm-storm.dtsi.
From: Suman Tripathi <stripathi@apm.com>
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Mark Langsdorf <mlangsdo@redhat.com>, Jon Masters <jcm@redhat.com>,
 anton@enomsg.org, linux-mmc@vger.kernel.org, chris@printf.net,
 patches <patches@apm.com>, Don Dutile <ddutile@redhat.com>,
 linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 28 January 2015 09:53:25 Suman Tripathi wrote:
>
> I added the iommus in the IOMMU AHBC patch. Anything wrong in that ?
> In the next version Also I will remove the IOMMU hacks from arasan
> driver

Hmm, I guess you have a required ordering between the patches either
way, which makes it hard to merge in a way that is bisectable.

You are correct that you should not merge a patch with the iommu
reference before adding the iommu device node, because it would
otherwise break building the mmc tree.

One more point is the binding for IOMMU needs to be in the same patch
in which the IOMMU support is added. So to provide the binding info of
the master node we require the sdhc nodes to be merged first.

Usually, the right answer is to merged the dts changes through the
arm-soc tree, and then you can just add the node for the sdhc device
after the one for the iommu device.

On Wed, Jan 28, 2015 at 6:16 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 28 January 2015 09:53:25 Suman Tripathi wrote:
>>
>> I added the iommus in the IOMMU AHBC patch. Anything wrong in that ?
>> In the next version Also I will remove the IOMMU hacks from arasan
>> driver
>
> Hmm, I guess you have a required ordering between the patches either
> way, which makes it hard to merge in a way that is bisectable.
>
> You are correct that you should not merge a patch with the iommu
> reference before adding the iommu device node, because it would
> otherwise break building the mmc tree.
>
> Usually, the right answer is to merged the dts changes through the
> arm-soc tree, and then you can just add the node for the sdhc device
> after the one for the iommu device.
>
>         Arnd



-- 
Thanks,
with regards,
Suman Tripathi
