Return-Path: <awalls@md.metrocast.net>
Received: from proofpoint-cluster.metrocast.net
 (proofpoint-cluster.metrocast.net [65.175.128.136])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 95AD02C009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2013 08:19:19 +1100 (EST)
References: <1357657073-27352-1-git-send-email-yuanhan.liu@linux.intel.com>
 <1357657073-27352-6-git-send-email-yuanhan.liu@linux.intel.com>
 <20130108181645.GA7972@core.coreip.homeip.net>
In-Reply-To: <20130108181645.GA7972@core.coreip.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 5/5] kfifo: log based kfifo API
From: Andy Walls <awalls@md.metrocast.net>
Date: Tue, 08 Jan 2013 16:10:07 -0500
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Yuanhan Liu <yuanhan.liu@linux.intel.com>
Message-ID: <f1be90be-ad99-4dff-8332-804383adc5c8@email.android.com>
Cc: linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
 linux-sctp@vger.kernel.org, linux-mtd@lists.infradead.org,
 devel@driverdev.osuosl.org, linux-scsi@vger.kernel.org,
 libertas-dev@lists.infradead.org, linux-rdma@vger.kernel.org,
 Stefani Seibold <stefani@seibold.net>, linux-serial@vger.kernel.org,
 linux-pci@vger.kernel.org, open-iscsi@googlegroups.com,
 linux-media@vger.kernel.org, linux-input@vger.kernel.org,
 linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 dccp@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

>Hi Yuanhan,
>
>On Tue, Jan 08, 2013 at 10:57:53PM +0800, Yuanhan Liu wrote:
>> The current kfifo API take the kfifo size as input, while it rounds
>>  _down_ the size to power of 2 at __kfifo_alloc. This may introduce
>> potential issue.
>> 
>> Take the code at drivers/hid/hid-logitech-dj.c as example:
>> 
>> 	if (kfifo_alloc(&djrcv_dev->notif_fifo,
>>                        DJ_MAX_NUMBER_NOTIFICATIONS * sizeof(struct
>dj_report),
>>                        GFP_KERNEL)) {
>> 
>> Where, DJ_MAX_NUMBER_NOTIFICATIONS is 8, and sizeo of(struct
>dj_report)
>> is 15.
>> 
>> Which means it wants to allocate a kfifo buffer which can store 8
>> dj_report entries at once. The expected kfifo buffer size would be
>> 8 * 15 = 120 then. While, in the end, __kfifo_alloc will turn the
>> size to rounddown_power_of_2(120) =  64, and then allocate a buf
>> with 64 bytes, which I don't think this is the original author want.
>> 
>> With the new log API, we can do like following:
>> 
>> 	int kfifo_size_order = order_base_2(DJ_MAX_NUMBER_NOTIFICATIONS *
>> 					    sizeof(struct dj_report));
>> 
>> 	if (kfifo_alloc(&djrcv_dev->notif_fifo, kfifo_size_order,
>GFP_KERNEL)) {
>> 
>> This make sure we will allocate enough kfifo buffer for holding
>> DJ_MAX_NUMBER_NOTIFICATIONS dj_report entries.
>
>Why don't you simply change __kfifo_alloc to round the allocation up
>instead of down?
>
>Thanks.
>
>-- 
>Dmitry
>--
>To unsubscribe from this list: send the line "unsubscribe linux-media"
>in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hi Dmitry,

I agree.   I don't see the benefit in pushing up the change to a kfifo internal decision/problem to many different places in the kernel.

Regards,
Andy

 
