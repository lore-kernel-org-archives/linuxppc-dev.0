Return-Path: <john.stultz@linaro.org>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 111B62C007A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2012 04:16:10 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <john.stultz@linaro.org>;
 Tue, 21 Aug 2012 12:16:07 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id A4BAD3E4003D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2012 12:15:01 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q7LIEn4J131546
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2012 12:14:54 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q7LIG0Fw026837
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2012 12:16:00 -0600
Message-ID: <5033D00B.4060701@linaro.org>
Date: Tue, 21 Aug 2012 11:14:35 -0700
From: John Stultz <john.stultz@linaro.org>
MIME-Version: 1.0
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 4/8] time: Condense timekeeper.xtime into xtime_sec
References: <1342156917-25092-1-git-send-email-john.stultz@linaro.org>
 <1342156917-25092-5-git-send-email-john.stultz@linaro.org>
 <m2fw7ilhnm.fsf@igel.home> <503288ED.10306@linaro.org>
 <m2fw7h4ab5.fsf@igel.home> <503296C1.4070906@linaro.org>
 <m2boi549ed.fsf@igel.home> <5033029A.2030201@linaro.org>
 <m2d32kemyp.fsf@igel.home>
In-Reply-To: <m2d32kemyp.fsf@igel.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Prarit Bhargava <prarit@redhat.com>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Richard Cochran <richardcochran@gmail.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/21/2012 12:14 AM, Andreas Schwab wrote:
> John Stultz <john.stultz@linaro.org> writes:
>
>> @@ -115,6 +115,7 @@ static void tk_xtime_add(struct timekeeper *tk, const struct timespec *ts)
>>   {
>>   	tk->xtime_sec += ts->tv_sec;
>>   	tk->xtime_nsec += (u64)ts->tv_nsec << tk->shift;
>> +	tk_normalize_xtime(tk);
>>   }
> Yes, that does it.  Failure to normalize is always bad.

Great. Thanks for the testing and the bug report! I'll be sending out 
the patch to -tip later today.

thanks
-john
