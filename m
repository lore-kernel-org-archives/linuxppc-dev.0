Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kp.nortel.com (zrtps0kp.nortel.com [47.140.192.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 573C7DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 04:53:25 +1100 (EST)
Message-ID: <49D4FB89.4070101@nortel.com>
Date: Thu, 02 Apr 2009 11:53:13 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: Resend: /proc/<pid>/maps offset output broken in 2.6.29
References: <49CA8501.1000000@nortel.com> <49D3F662.4050100@nortel.com>
	<1238659491.9041.133.camel@localhost>
	<Pine.LNX.4.64.0904021324070.16207@blonde.anvils>
In-Reply-To: <Pine.LNX.4.64.0904021324070.16207@blonde.anvils>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hugh Dickins wrote:
> On Thu, 2 Apr 2009, Michael Ellerman wrote:
>> On Wed, 2009-04-01 at 17:18 -0600, Chris Friesen wrote:
>>> Resending due to lack of response to original post.
>> Hi Chris,
>>
>> You'll probably get a more useful response on lkml. You CC'ed
>> linux-kernel-owner originally :)
> 
> Thanks.

Thanks from me too.  (Oops.)

>>> I was validating some code dealing with /proc/<pid>/maps on 2.6.29 and 
>>> was surprised when it failed.  It turns out that at least on my ppc64 G5 
>>> machine the offset value for the last entry is strange--it shows up as a 
>>> 64-bit value even though the process itself is only 32-bit.
>>>
>>> This behaviour also shows up in 2.6.25, but doesn't in 2.6.14.  I 
>>> haven't yet tested anything else in between.
>>>
>>> [cfriesen@localhost cfriesen]$ cat /proc/self/maps
>>> 00100000-00103000 r-xp 00100000 00:00 0         [vdso]
>>> 0fe70000-0ffbf000 r-xp 00000000 08:03 4312393   /lib/tls/libc-2.3.3.so
>>> 0ffbf000-0ffc0000 ---p 0014f000 08:03 4312393   /lib/tls/libc-2.3.3.so
>>> 0ffc0000-0ffc2000 r--p 00150000 08:03 4312393   /lib/tls/libc-2.3.3.so
>>> 0ffc2000-0ffc6000 rwxp 00152000 08:03 4312393   /lib/tls/libc-2.3.3.so
>>> 0ffc6000-0ffc8000 rwxp 0ffc6000 00:00 0
>>> 0ffd0000-0ffec000 r-xp 00000000 08:03 4309011   /lib/ld-2.3.3.so
>>> 0fff0000-0fff1000 r--p 00020000 08:03 4309011   /lib/ld-2.3.3.so
>>> 0fff1000-0fff2000 rwxp 00021000 08:03 4309011   /lib/ld-2.3.3.so
>>> 10000000-10004000 r-xp 00000000 08:03 917536    /bin/cat
>>> 10013000-10015000 rwxp 00003000 08:03 917536    /bin/cat
>>> 10015000-10036000 rwxp 10015000 00:00 0         [heap]
>>> f7deb000-f7feb000 r--p 00000000 08:03 2560322 
>>> /usr/lib/locale/locale-archive
>>> f7feb000-f7fec000 rw-p f7feb000 00:00 0
>>> ffe6d000-ffe82000 rw-p ffffffeb000 00:00 0      [stack]

> Chris isn't the first to be concerned by that: there's a patch in
> -mm which just shows 0 instead of anon vm_pgoff in /proc/<pid>/maps
> output.  That patch is on akpm's list for 2.6.30 merge, but I think
> hasn't gone to Linus yet: expect it in a later batch.

Alternately, what about just making the offset for the stack match the 
starting address of the VMA?  That way it would look the same as other 
anonymous areas, and as a bonus would look the same as previous 
releases.  Arguably, /proc/<pid>/maps should count as userspace-visible API.

Chris
