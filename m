Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 619951A0BEC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 20:31:25 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 9 Apr 2015 16:01:23 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 41EA4125805C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 16:03:07 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t39AV40m42991858
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Apr 2015 16:01:05 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t39AV3rb017844
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Apr 2015 16:01:03 +0530
Message-ID: <552654E7.9050906@linux.vnet.ibm.com>
Date: Thu, 09 Apr 2015 16:01:03 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [V2, 06/12] selftests, powerpc: Add test for system wide DSCR
 default
References: <20150327120136.EF3431400DE@ozlabs.org>
In-Reply-To: <20150327120136.EF3431400DE@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Cc: mikey@neuling.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/27/2015 05:31 PM, Michael Ellerman wrote:
> On Tue, 2015-13-01 at 10:22:34 UTC, Anshuman Khandual wrote:
>> This patch adds a test case for the system wide DSCR default
>> value, which when changed through it's sysfs interface must
>> be visible to all threads reading DSCR either through the
>> privilege state SPR or the problem state SPR. The DSCR value
>> change should be immediate as well.
> 
> ...
> 
>> +
>> +/* Default DSCR access */
>> +unsigned long get_default_dscr(void)
>> +{
>> +	int fd = -1;
>> +	char buf[16];
>> +	unsigned long val;
>> +
>> +	if (fd == -1) {
>> +		fd = open(DSCR_DEFAULT, O_RDONLY);
>> +		if (fd == -1) {
>> +			perror("open() failed\n");
>> +			exit(1);
>> +		}
>> +	}
>> +	memset(buf, 0, sizeof(buf));
>> +	lseek(fd, 0, SEEK_SET);
>> +	read(fd, buf, sizeof(buf));
> 

Normally, I build the test cases like

$cd tools/testing/selftests/powerpc/
$make dscr

with these compiler flags "-Wall -O2 -flto -Wall -Werror" which
is still working for me. Then I figured out that the read and
write declaration in unistd.h header file has "_wur" in it.

extern ssize_t read (int __fd, void *__buf, size_t __nbytes) __wur;
extern ssize_t write (int __fd, const void *__buf, size_t __n) __wur;

Then some how the compiler (GCC 4.8.3) is not complaining about it.

> 
> This and the other tests are failing to build:
> 
>     In file included from dscr_default_test.c:16:0:
>     dscr.h: In function â€˜get_default_dscrâ€™:
>     dscr.h:93:6: error: ignoring return value of â€˜readâ€™, declared with attribute warn_unused_result [-Werror=unused-result]
>       read(fd, buf, sizeof(buf));
>           ^
>     dscr.h: In function â€˜set_default_dscrâ€™:
>     dscr.h:112:7: error: ignoring return value of â€˜writeâ€™, declared with attribute warn_unused_result [-Werror=unused-result]
>       write(fd, buf, strlen(buf));
>            ^
>     cc1: all warnings being treated as errors

Anyways, I can change the header file helper functions if you would like.
BTW, the patch series does not apply as it is and requires rebasing. Would
send out a new version of it.
