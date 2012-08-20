Return-Path: <john.stultz@linaro.org>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e5.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 873BF2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2012 05:58:36 +1000 (EST)
Received: from /spool/local
 by e5.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <john.stultz@linaro.org>;
 Mon, 20 Aug 2012 15:58:33 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 41E3D38C8047
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2012 15:58:08 -0400 (EDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q7KJw7nm171574
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2012 15:58:08 -0400
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q7KJvvdj029074
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2012 13:57:58 -0600
Message-ID: <503296C1.4070906@linaro.org>
Date: Mon, 20 Aug 2012 12:57:53 -0700
From: John Stultz <john.stultz@linaro.org>
MIME-Version: 1.0
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 4/8] time: Condense timekeeper.xtime into xtime_sec
References: <1342156917-25092-1-git-send-email-john.stultz@linaro.org>
 <1342156917-25092-5-git-send-email-john.stultz@linaro.org>
 <m2fw7ilhnm.fsf@igel.home> <503288ED.10306@linaro.org>
 <m2fw7h4ab5.fsf@igel.home>
In-Reply-To: <m2fw7h4ab5.fsf@igel.home>
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

On 08/20/2012 12:45 PM, Andreas Schwab wrote:
> John Stultz <john.stultz@linaro.org> writes:
>
>> I'm not very familiar w/ the iBook hardware, but does it use a
>> clocksource, or does it use arch_gettimeoffset()?
> clocksource: timebase mult[3640e38e] shift[24] registered
>
>> I suspect that the casting has avoided clipping some strange values from
>> the persistent clock.
> That's my guess as well.
>
>> Could you try with the following patch against Linus' HEAD? I suspect it
>> will let the box resume (although it will seem as though no time was
>> spent in resume) and then let me know what the JDB lines print out?
> JDB: suspend_time: 1345491706:0  resume_time: 1345491737:0
> JDB: Trying to add: 31:0
>
> (Looks reasonable.)
Huh.  Yea, that looks fine.  And without the 
__timekeeping_inject_sleeptime() call, the system resumed ok?

Thanks for the testing!  I'll keep looking here.
-john
