Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41czjT4Sw2zF0dl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2018 18:37:33 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6S8Sk7p124362
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2018 04:37:30 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kgmca1837-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2018 04:37:30 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Sat, 28 Jul 2018 09:37:29 +0100
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180720161541-mutt-send-email-mst@kernel.org>
 <8f51d2c6-cc0c-9e42-f0fd-a8a33acc8b83@linux.vnet.ibm.com>
 <20180723120511-mutt-send-email-mst@kernel.org>
 <4062dd48-2b5b-e454-e860-c6bfe321ebdc@linux.vnet.ibm.com>
 <20180727143008-mutt-send-email-mst@kernel.org>
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, aik@ozlabs.ru,
 jasowang@redhat.com, linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 paulus@samba.org, joe@perches.com, linuxppc-dev@lists.ozlabs.org,
 elfring@users.sourceforge.net, haren@linux.vnet.ibm.com,
 david@gibson.dropbear.id.au
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Sat, 28 Jul 2018 14:07:20 +0530
MIME-Version: 1.0
In-Reply-To: <20180727143008-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Message-Id: <986656ee-37e9-0d99-3d1f-a48466ffe0ed@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/27/2018 05:01 PM, Michael S. Tsirkin wrote:
> On Wed, Jul 25, 2018 at 08:56:23AM +0530, Anshuman Khandual wrote:
>> Results with and without the patches are similar.
> 
> Thanks! And another thing to try is virtio-net with
> a fast NIC backend (40G and up). Unfortunately
> at this point loopback tests stress the host
> scheduler too much.
> 

Sure. Will look around for a 40G NIC system. BTW I have been testing
virtio-net with a TAP device as back end.

ip tuntap add dev tap0 mode tap user $(whoami)
ip link set tap0 master virbr0
ip link set dev virbr0 up
ip link set dev tap0 up

which is exported into the guest as follows

-device virtio-net,netdev=network0,mac=52:55:00:d1:55:01 \
-netdev tap,id=network0,ifname=tap0,script=no,downscript=no \

But I have not run any network benchmarks on it though.
