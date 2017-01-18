Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v3D1g4w8nzDqHm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 15:06:47 +1100 (AEDT)
Message-ID: <1484712400.4967.0.camel@russell.cc>
Subject: Re: [PATCH] powerpc/eeh: Enable IO path on permanent error
From: Russell Currey <ruscur@russell.cc>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 18 Jan 2017 15:06:40 +1100
In-Reply-To: <1483659589-23208-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1483659589-23208-1-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-01-06 at 10:39 +1100, Gavin Shan wrote:
> We give up recovery on permanent error, simply shutdown the affected
> devices and remove them. If the devices can't be put into quiet state,
> they spew more traffic that is likely to cause another unexpected EEH
> error. This was observed on "p8dtu2u" machine:
> 
>    0002:00:00.0 PCI bridge: IBM Device 03dc
>    0002:01:00.0 Ethernet controller: Intel Corporation \
>                 Ethernet Controller X710/X557-AT 10GBASE-T (rev 02)
>    0002:01:00.1 Ethernet controller: Intel Corporation \
>                 Ethernet Controller X710/X557-AT 10GBASE-T (rev 02)
>    0002:01:00.2 Ethernet controller: Intel Corporation \
>                 Ethernet Controller X710/X557-AT 10GBASE-T (rev 02)
>    0002:01:00.3 Ethernet controller: Intel Corporation \
>                 Ethernet Controller X710/X557-AT 10GBASE-T (rev 02)
> 
> On P8 PowerNV platform, the IO path is frozen when shutdowning the
> devices, meaning the memory registers are inaccessible. It is why
> the devices can't be put into quiet state before removing them.
> This fixes the issue by enabling IO path prior to putting the devices
> into quiet state.
> 
> Link: https://github.com/open-power/supermicro-openpower/issues/419
> Reported-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---

(forgot to ack this)

Acked-by: Russell Currey <ruscur@russell.cc>
