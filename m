Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 48EEF2C009A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 11:31:07 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 23 Aug 2013 06:51:28 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id D2B30E004F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 07:01:31 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7N1WVdA46333980
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 07:02:32 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7N1V0QZ027626
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 07:01:00 +0530
Date: Fri, 23 Aug 2013 09:30:58 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 2/2] powerpc/iommu: check dev->iommu_group before remove
 a device from iommu_group
Message-ID: <20130823013058.GA7632@weiyang.vnet.ibm.com>
References: <1376647687-20550-3-git-send-email-weiyang@linux.vnet.ibm.com>
 <520DFBC8.4040509@ozlabs.ru>
 <20130819012945.GA8342@weiyang.vnet.ibm.com>
 <52117765.7010205@ozlabs.ru>
 <20130819015538.GB8342@weiyang.vnet.ibm.com>
 <5215BC76.10105@ozlabs.ru>
 <20130822075237.GA14479@weiyang.vnet.ibm.com>
 <1377185303.25163.13.camel@ul30vt.home>
 <20130822154107.GC7393@weiyang.vnet.ibm.com>
 <1377188240.25163.23.camel@ul30vt.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1377188240.25163.23.camel@ul30vt.home>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, paulus@au1.ibm.com, benh@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 22, 2013 at 10:17:20AM -0600, Alex Williamson wrote:
>On Thu, 2013-08-22 at 23:41 +0800, Wei Yang wrote:
>> >> 
>> >> Alex,
>> >> 
>> >> Sorry for not including you in the very beginning, which may spend you more
>> >> efforts to track previous mails in this thread.
>> >> 
>> >> Do you think it is reasonable to check the dev->iommu_group in
>> >> iommu_group_remove_device()? Or we can count on the bus notifier to check it?
>> >> 
>> >> Welcome your suggestions~
>> >
>> >I don't really see the point of patch 1/2. iommu_group_remove_device()
>> >is specifically to remove a device from an iommu_group, so why would you
>> >call it on a device that's not part of an iommu_group.  If you want to
>> >avoid testing dev->iommu_group, then implement the .remove_device
>> >callback rather than using the notifier.  Thanks,
>> >
>> 
>> You mean the .remove_device like intel_iommu_remove_device()? 
>> 
>> Hmm... this function didn't check the dev->iommu_group and just call
>> iommu_group_remove_device(). I see this guard is put in iommu_bus_notifier(), 
>> which will check dev->iommu_group before invoke .remove_device.
>> 
>> Let me explain the case to triger the problem a little. 
>> 
>> On some platform, like powernv, we implement another bus notifier when devices
>> are added or removed in the system. Like Alexey mentioned, he missed the check
>> for dev->iommu_group in the notifier before removing it from iommu_group. This
>> trigger the crash.
>> 
>> So do you think it is reasonable to guard the kernel in
>> iommu_group_remove_device(), or we give the platform developers the
>> responsibility to check the dev->iommu_group before calling it?
>
>I don't see it as we need either patch 1/2 or patch 2/2.  We absolutely
>need some form of patch 2/2.  Patch 1/2 isn't necessarily bad, but it
>facilitates sloppy usage.  The iommu driver shouldn't be calling
>iommu_group_remove_device() on arbitrary devices that may or may not be
>part of an iommu_group.  Perhaps patch 1/2 should be:
>
>if (WARN_ON(!group))
>	return;
>

Agree, this one sounds more reasonable. :-)

Since patch 2/2 is merged by Alexey, I will re-send patch 1/2 alone.

Thanks for your comments ~

>Thanks,
>
>Alex
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev

-- 
Richard Yang
Help you, Help me
