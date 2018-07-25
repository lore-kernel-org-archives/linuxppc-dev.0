Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41b0y722l6zDqnG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 13:26:38 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6P3OMiO030531
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 23:26:35 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kedwq639m-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 23:26:35 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 25 Jul 2018 04:26:33 +0100
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180720161541-mutt-send-email-mst@kernel.org>
 <8f51d2c6-cc0c-9e42-f0fd-a8a33acc8b83@linux.vnet.ibm.com>
 <20180723120511-mutt-send-email-mst@kernel.org>
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, aik@ozlabs.ru,
 jasowang@redhat.com, linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 paulus@samba.org, joe@perches.com, linuxppc-dev@lists.ozlabs.org,
 elfring@users.sourceforge.net, haren@linux.vnet.ibm.com,
 david@gibson.dropbear.id.au
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 25 Jul 2018 08:56:23 +0530
MIME-Version: 1.0
In-Reply-To: <20180723120511-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Message-Id: <4062dd48-2b5b-e454-e860-c6bfe321ebdc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/23/2018 02:38 PM, Michael S. Tsirkin wrote:
> On Mon, Jul 23, 2018 at 11:58:23AM +0530, Anshuman Khandual wrote:
>> On 07/20/2018 06:46 PM, Michael S. Tsirkin wrote:
>>> On Fri, Jul 20, 2018 at 09:29:37AM +0530, Anshuman Khandual wrote:
>>>> This patch series is the follow up on the discussions we had before about
>>>> the RFC titled [RFC,V2] virtio: Add platform specific DMA API translation
>>>> for virito devices (https://patchwork.kernel.org/patch/10417371/). There
>>>> were suggestions about doing away with two different paths of transactions
>>>> with the host/QEMU, first being the direct GPA and the other being the DMA
>>>> API based translations.
>>>>
>>>> First patch attempts to create a direct GPA mapping based DMA operations
>>>> structure called 'virtio_direct_dma_ops' with exact same implementation
>>>> of the direct GPA path which virtio core currently has but just wrapped in
>>>> a DMA API format. Virtio core must use 'virtio_direct_dma_ops' instead of
>>>> the arch default in absence of VIRTIO_F_IOMMU_PLATFORM flag to preserve the
>>>> existing semantics. The second patch does exactly that inside the function
>>>> virtio_finalize_features(). The third patch removes the default direct GPA
>>>> path from virtio core forcing it to use DMA API callbacks for all devices.
>>>> Now with that change, every device must have a DMA operations structure
>>>> associated with it. The fourth patch adds an additional hook which gives
>>>> the platform an opportunity to do yet another override if required. This
>>>> platform hook can be used on POWER Ultravisor based protected guests to
>>>> load up SWIOTLB DMA callbacks to do the required (as discussed previously
>>>> in the above mentioned thread how host is allowed to access only parts of
>>>> the guest GPA range) bounce buffering into the shared memory for all I/O
>>>> scatter gather buffers to be consumed on the host side.
>>>>
>>>> Please go through these patches and review whether this approach broadly
>>>> makes sense. I will appreciate suggestions, inputs, comments regarding
>>>> the patches or the approach in general. Thank you.
>>> I like how patches 1-3 look. Could you test performance
>>> with/without to see whether the extra indirection through
>>> use of DMA ops causes a measurable slow-down?
>>
>> I ran this simple DD command 10 times where /dev/vda is a virtio block
>> device of 10GB size.
>>
>> dd if=/dev/zero of=/dev/vda bs=8M count=1024 oflag=direct
>>
>> With and without patches bandwidth which has a bit wide range does not
>> look that different from each other.
>>
>> Without patches
>> ===============
>>
>> ---------- 1 ---------
>> 1024+0 records in
>> 1024+0 records out
>> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 1.95557 s, 4.4 GB/s
>> ---------- 2 ---------
>> 1024+0 records in
>> 1024+0 records out
>> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 2.05176 s, 4.2 GB/s
>> ---------- 3 ---------
>> 1024+0 records in
>> 1024+0 records out
>> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 1.88314 s, 4.6 GB/s
>> ---------- 4 ---------
>> 1024+0 records in
>> 1024+0 records out
>> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 1.84899 s, 4.6 GB/s
>> ---------- 5 ---------
>> 1024+0 records in
>> 1024+0 records out
>> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 5.37184 s, 1.6 GB/s
>> ---------- 6 ---------
>> 1024+0 records in
>> 1024+0 records out
>> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 1.9205 s, 4.5 GB/s
>> ---------- 7 ---------
>> 1024+0 records in
>> 1024+0 records out
>> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 6.85166 s, 1.3 GB/s
>> ---------- 8 ---------
>> 1024+0 records in
>> 1024+0 records out
>> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 1.74049 s, 4.9 GB/s
>> ---------- 9 ---------
>> 1024+0 records in
>> 1024+0 records out
>> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 6.31699 s, 1.4 GB/s
>> ---------- 10 ---------
>> 1024+0 records in
>> 1024+0 records out
>> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 2.47057 s, 3.5 GB/s
>>
>>
>> With patches
>> ============
>>
>> ---------- 1 ---------
>> 1024+0 records in
>> 1024+0 records out
>> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 2.25993 s, 3.8 GB/s
>> ---------- 2 ---------
>> 1024+0 records in
>> 1024+0 records out
>> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 1.82438 s, 4.7 GB/s
>> ---------- 3 ---------
>> 1024+0 records in
>> 1024+0 records out
>> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 1.93856 s, 4.4 GB/s
>> ---------- 4 ---------
>> 1024+0 records in
>> 1024+0 records out
>> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 1.83405 s, 4.7 GB/s
>> ---------- 5 ---------
>> 1024+0 records in
>> 1024+0 records out
>> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 7.50199 s, 1.1 GB/s
>> ---------- 6 ---------
>> 1024+0 records in
>> 1024+0 records out
>> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 2.28742 s, 3.8 GB/s
>> ---------- 7 ---------
>> 1024+0 records in
>> 1024+0 records out
>> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 5.74958 s, 1.5 GB/s
>> ---------- 8 ---------
>> 1024+0 records in
>> 1024+0 records out
>> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 1.99149 s, 4.3 GB/s
>> ---------- 9 ---------
>> 1024+0 records in
>> 1024+0 records out
>> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 5.67647 s, 1.5 GB/s
>> ---------- 10 ---------
>> 1024+0 records in
>> 1024+0 records out
>> 8589934592 bytes (8.6 GB, 8.0 GiB) copied, 2.93957 s, 2.9 GB/s
>>
>> Does this look okay ?
> 
> You want to test IOPS with lots of small writes and using
> raw ramdisk on host.

Hello Michael,

I have conducted the following experiments and here are the results.

TEST SETUP
==========

A virtio block disk is mounted on the guest as follows.


    <disk type='file' device='disk'>
      <driver name='qemu' type='raw' ioeventfd='off'/>
      <source file='/mnt/disk2.img'/>
      <target dev='vdb' bus='virtio'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x04' function='0x0'/>
    </disk>

In the host back end its an QEMU raw image on tmpfs file system.

disk:

-rw-r--r-- 1 libvirt-qemu kvm  5.0G Jul 24 06:26 disk2.img

mount:

size=21G on /mnt type tmpfs (rw,relatime,size=22020096k)

TEST CONFIG
===========

FIO (https://linux.die.net/man/1/fio) is being run with and without
the patches.

Read test config:

[Sequential]
direct=1
ioengine=libaio
runtime=5m
time_based
filename=/dev/vda
bs=4k
numjobs=16
rw=read
unlink=1
iodepth=256


Write test config:

[Sequential]
direct=1
ioengine=libaio
runtime=5m
time_based
filename=/dev/vda
bs=4k
numjobs=16
rw=write
unlink=1
iodepth=256

The virtio block device comes up as /dev/vda on the guest with

/sys/block/vda/queue/nr_requests=128

TEST RESULTS
============

Without the patches
-------------------

Read test:

Run status group 0 (all jobs):
   READ: bw=550MiB/s (577MB/s), 33.2MiB/s-35.6MiB/s (34.9MB/s-37.4MB/s), io=161GiB (173GB), run=300001-300009msec

Disk stats (read/write):
  vda: ios=42249926/0, merge=0/0, ticks=1499920/0, in_queue=35672384, util=100.00%


Write test:

Run status group 0 (all jobs):
  WRITE: bw=514MiB/s (539MB/s), 31.5MiB/s-34.6MiB/s (33.0MB/s-36.2MB/s), io=151GiB (162GB), run=300001-300009msec

Disk stats (read/write):
  vda: ios=29/39459261, merge=0/0, ticks=0/1570580, in_queue=35745992, util=100.00%

With the patches
----------------

Read test:

Run status group 0 (all jobs):
   READ: bw=572MiB/s (600MB/s), 35.0MiB/s-37.2MiB/s (36.7MB/s-38.0MB/s), io=168GiB (180GB), run=300001-300006msec

Disk stats (read/write):
  vda: ios=43917611/0, merge=0/0, ticks=1934268/0, in_queue=35531688, util=100.00%
  
Write test:

Run status group 0 (all jobs):
  WRITE: bw=546MiB/s (572MB/s), 33.7MiB/s-35.0MiB/s (35.3MB/s-36.7MB/s), io=160GiB (172GB), run=300001-300007msec

Disk stats (read/write):
  vda: ios=14/41893878, merge=0/0, ticks=8/2107816, in_queue=35535716, util=100.00%

Results with and without the patches are similar.
