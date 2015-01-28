Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A892B1A0766
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 23:47:23 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH v1 2/2] arm64: dts: Add the arasan sdhc nodes in
 apm-storm.dtsi.
Date: Wed, 28 Jan 2015 13:46:27 +0100
Message-ID: <2323575.nqxsEzcHbG@wuerfel>
In-Reply-To: <CAOHikRAOVMQiOy_VrXmJU1e+8KBwOFSfX1uSKvfdbVG=Br2ocg@mail.gmail.com>
References: <1422379260-10139-1-git-send-email-stripathi@apm.com>
 <CAOHikRB4tSkJsMccqHRS8XYULaP+dS7KujeSLh+ZpTxDDOF5xQ@mail.gmail.com>
 <CAOHikRAOVMQiOy_VrXmJU1e+8KBwOFSfX1uSKvfdbVG=Br2ocg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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

Usually, the right answer is to merged the dts changes through the
arm-soc tree, and then you can just add the node for the sdhc device
after the one for the iommu device.

	Arnd
