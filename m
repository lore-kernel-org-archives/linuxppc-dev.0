Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 56CF02C0091
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 13:09:16 +1100 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 20 Mar 2013 20:09:12 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id B283519D804A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 20:09:04 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2L297fq342076
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 20:09:07 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2L29718027276
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 20:09:07 -0600
Date: Thu, 21 Mar 2013 10:09:03 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 2/3] VFIO: VFIO_DEVICE_SET_ADDR_MAPPING command
Message-ID: <20130321020903.GA13178@shangw.(null)>
References: <1363375740.16793.12.camel@ul30vt.home>
 <20130316013417.GA3873@shangw.(null)>
 <1363412256.1244.20.camel@pasglop>
 <1363640474.24132.433.camel@bling.home>
 <20130319032410.GA22591@shangw.(null)>
 <1363666721.24132.472.camel@bling.home>
 <1363668309.18880.10.camel@pasglop>
 <1363805280.24132.529.camel@bling.home>
 <1363807906.17680.11.camel@pasglop>
 <1363808782.24132.534.camel@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363808782.24132.534.camel@bling.home>
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <shangw@linux.vnet.ibm.com>, kvm@vger.kernel.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 20, 2013 at 01:46:22PM -0600, Alex Williamson wrote:
>On Wed, 2013-03-20 at 20:31 +0100, Benjamin Herrenschmidt wrote:
>> On Wed, 2013-03-20 at 12:48 -0600, Alex Williamson wrote:

.../...

>> As for EEH, I will let Gavin describe in more details what he is doing,
>> though I wouldn't be surprised if so far he doesn't have a
>> non-accelerated path :-) Which indeed makes things oddball, granted ...
>> at least for now. I *think* what Gavin's doing right now is a
>> pass-through to the host EEH directly in the kernel, so without a slow
>> path...
>> 

Yes, I don't have non-accelerated path. I'm trying to describe what I'm
doing: On the host side, the interrupt will be triggered while detecting
frozen PE, which has been passed to guest. We won't send EEH event to
EEH core on host side and we're waiting for guest to be involved to handle
the EEH error. In guest, any access to config or MMIO of the frozen PE will
trigger EEH event and in turn, the guest utilizes existing (exactly same
to pSeries on phyp case) RTAS calls to recover the error. The RTAS calls is
being emulated in host kernel.

Part of the RTAS call arguments is PCI domain/bus/slot/function viewed from
guest perspective. That's different from that for same physical PCI device
in host side. So I used VFIO-PCI to do the mapping and maintain the information
in host kernel.

>> Gavin, it really boils down to that. In-kernel EEH for guests is a
>> KVMism that ends up not involving VFIO in any other way than
>> establishing the mapping, then arguably it could be done via a VM ioctl.
>> 
>> If there's more going through VFIO and shared state, then it should
>> probably go through VFIO-PCI.
>

Ben, you're right. I use VFIO for nothing other than doing address mapping.
So I will do the address mapping in VM IOCTL instead of in VFIO-PCI.

Thanks,
Gavin
