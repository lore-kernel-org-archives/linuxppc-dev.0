Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zbGyq2S3kzF0y0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Feb 2018 18:57:38 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w167sZt3081848
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Feb 2018 02:57:35 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fy72334jn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Feb 2018 02:57:35 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 6 Feb 2018 02:57:34 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, neelegup@linux.vnet.ibm.com,
 stable@vger.kernel.org
Subject: Re: rtc-opal: Fix handling of firmware error codes, prevent busy loops
In-Reply-To: <20180206022646.GP3404@piout.net>
References: <1470102616-18346-1-git-send-email-stewart@linux.vnet.ibm.com>
 <20180206022646.GP3404@piout.net>
Date: Tue, 06 Feb 2018 18:57:25 +1100
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87r2pyv9cq.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexandre Belloni <alexandre.belloni@bootlin.com> writes:
> On 02/08/2016 at 11:50:16 +1000, Stewart Smith wrote:
>> According to the OPAL docs:
>> https://github.com/open-power/skiboot/blob/skiboot-5.2.5/doc/opal-api/opal-rtc-read-3.txt
>> https://github.com/open-power/skiboot/blob/skiboot-5.2.5/doc/opal-api/opal-rtc-write-4.txt
>> OPAL_HARDWARE may be returned from OPAL_RTC_READ or OPAL_RTC_WRITE and this
>> indicates either a transient or permanent error.
>> 
>> Prior to this patch, Linux was not dealing with OPAL_HARDWARE being a
>> permanent error particularly well, in that you could end up in a busy
>> loop.
>> 
>> This was not too hard to trigger on an AMI BMC based OpenPOWER machine
>> doing a continuous "ipmitool mc reset cold" to the BMC, the result of
>> that being that we'd get stuck in an infinite loop in opal_get_rtc_time.
>> 
>> We now retry a few times before returning the error higher up the stack.
>> 
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
>> ---
>>  drivers/rtc/rtc-opal.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>> 
>
> Just a note to let you know that this patch should have gone through my
> tree but it was not sent to linux-rtc or me.
>
> I guess what happened is that Michael cleaned up the Linux PPC patchwork
> queue.

Apologies for not sending there. My (18 month ago self) bad.

-- 
Stewart Smith
OPAL Architect, IBM.
