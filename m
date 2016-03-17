Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQlS10N5VzDq6T
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 21:47:45 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Thu, 17 Mar 2016 20:47:43 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6F36B2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 21:47:34 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2HAlQhH19792026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 21:47:34 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2HAl0nH012274
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 21:47:01 +1100
Subject: Re: [RFC PATCH v4 0/7] vfio-pci: Allow to mmap sub-page MMIO BARs and
 MSI-X table
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1457336918-3893-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <56E93ACC.7080403@linux.vnet.ibm.com> <20160316141013.GA21809@localhost>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org, bhelgaas@google.com, corbet@lwn.net,
 aik@ozlabs.ru, alex.williamson@redhat.com, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Message-ID: <56EA8B14.4070808@linux.vnet.ibm.com>
Date: Thu, 17 Mar 2016 18:46:44 +0800
MIME-Version: 1.0
In-Reply-To: <20160316141013.GA21809@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/3/16 22:10, Bjorn Helgaas wrote:
> On Wed, Mar 16, 2016 at 06:51:56PM +0800, Yongji Xie wrote:
>> Ping.
> This is mainly VFIO stuff, and Alex had some security concerns, so I'm
> not going to spend much time looking at this until he's satisfied.
>
> When I do, I'll be looking hard at the resource_alignment kernel
> parameter.  I'm opposed to kernel parameters in general because
> they're very difficult for users to use correctly, and they lead to
> kernel code paths that are rarely tested and hard to maintain.  So
> I'll be looking for an excuse to reject changes in that area.
>
> The changelog for 2/7 says it "replaces IORESOURCE_STARTALIGN with
> IORESOURCE_WINDOW."  But even a glance at the patch itself shows that
> IORESOURCE_WINDOW is *added* to some places, and it doesn't *replace*
> IORESOURCE_STARTALIGN.

There is a problem with my statement. I mean we can use
IORESOURCE_WINDOW to identify bridge resources instead of
IORESOURCE_STARTALIGN here.

> The changelog for 4/7 says:
>
>    This is because vfio will not allow to passthrough one BAR's mmio
>    page which may be shared with other BARs.  To solve this performance
>    issue ...
>
> with no mention at all of the actual *reason* vfio doesn't allow that
> passthrough.  If I understand correctly, that reason has to do with
> security, so your justification must be much stronger than "solving a
> performance issue."

OK. I will try to make my justification become stronger.

Thanks,
Yongji Xie
