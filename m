Return-Path: <ben@somanetworks.com>
Received: from zimbra.somanetworks.com (dns.somanetworks.com [216.126.67.39])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 7CBAEB7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Sep 2009 10:09:51 +1000 (EST)
Message-ID: <4A9C664D.6010504@somanetworks.com>
Date: Mon, 31 Aug 2009 20:09:49 -0400
From: Benjamin Gamsa <ben@somanetworks.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: time jumps forward/backwards
References: <4A9C465D.4010801@somanetworks.com>	<19100.24755.889091.412993@cargo.ozlabs.ibm.com>
	<4A9C6446.2000202@somanetworks.com>
In-Reply-To: <4A9C6446.2000202@somanetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Gamsa wrote:
> Paul Mackerras wrote:
>> Ben Gamsa writes:
>>
>>> It appears to be the case that when the time on the system is around 
>>> the epoch (1970), that time will occasionally jump forward and then 
>>> backward by about 17592 seconds.  When it jumps forward, it always 
>>> jumps back a few milliseconds later.  However, it's not always easy 
>>> to catch these occurrences.  The delta is more specifically about 
>>> 17592186059 usec, give or take a few 10s of microseconds (most of the 
>>> time), despite the fact that the user-level program I have that is 
>>> testing it only checks every 10 milliseconds.
>>
>> I don't think the time code in the kernel is designed to handle
>> negative values, i.e., times before the epoch.  If you want it to do
>> that you'll have to check places like arch/powerpc/kernel/time.c,
>> kernel/time/timekeeping.c, arch/powerpc/include/asm/time.h, etc., and
>> make sure that it uses signed types where necessary and that the
>> arithmetic is correct.
>>
> 
> The time never goes negative.  It starts off at the epoch and moves 
> forward, but sometimes it jumps forward by 17952 seconds, and then 
> immediately jumps back.  But it never goes negative (or prior to 1970).
> 

One important thing I forgot to add is that ntpd is running on this 
system, but the ntp servers are not available.  I suspect the problem 
may be related to ntpd, even though I've seen the time jump even when I 
had ntpd stopped within gdb.  I've not yet been able to confirm if the 
problem still occurs when ntpd is never even started, although I will be 
testing that soon (the tests often require many hours to establish if 
there are no jumps).

	ben
