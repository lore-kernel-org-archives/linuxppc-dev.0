Return-Path: <shuahkh@osg.samsung.com>
Received: from osg.samsung.com
 (ec2-52-27-115-49.us-west-2.compute.amazonaws.com [52.27.115.49])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wDW5D4fM8zDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 07:57:19 +1000 (AEST)
Subject: Re: [PATCH 3/8] selftests: futex: override clean in lib.mk to fix
 warnings
To: Darren Hart <dvhart@infradead.org>
References: <cover.1492815938.git.shuahkh@osg.samsung.com>
 <2ccc4e205a4e25e227e7a90c0037d9e6a6f99ed1.1492815938.git.shuahkh@osg.samsung.com>
 <20170427215437.GC29261@fury>
Cc: shuah@kernel.org, bamvor.zhangjian@linaro.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, viro@zeniv.linux.org.uk,
 emilio.lopez@collabora.co.uk, mingo@kernel.org, luto@kernel.org,
 dave.hansen@linux.intel.com, dsafonov@virtuozzo.com, rkrcmar@redhat.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 shuah Khan <shuahkh@osg.samsung.com>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <512c6179-00bd-180f-dff5-7b81d181ae81@osg.samsung.com>
Date: Thu, 27 Apr 2017 15:57:13 -0600
MIME-Version: 1.0
In-Reply-To: <20170427215437.GC29261@fury>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/27/2017 03:54 PM, Darren Hart wrote:
> On Fri, Apr 21, 2017 at 05:14:45PM -0600, Shuah Khan wrote:
>> Add override for lib.mk clean to fix the following warnings from clean
>> target run.
>>
>> Makefile:36: warning: overriding recipe for target 'clean'
>> ../lib.mk:55: warning: ignoring old recipe for target 'clean'
>>
>> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
>> ---
>>  tools/testing/selftests/futex/Makefile | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/futex/Makefile b/tools/testing/selftests/futex/Makefile
>> index c8095e6..e2fbb89 100644
>> --- a/tools/testing/selftests/futex/Makefile
>> +++ b/tools/testing/selftests/futex/Makefile
>> @@ -32,9 +32,10 @@ override define EMIT_TESTS
>>  	echo "./run.sh"
>>  endef
>>  
>> -clean:
>> +override define CLEAN
>>  	for DIR in $(SUBDIRS); do		\
>>  		BUILD_TARGET=$(OUTPUT)/$$DIR;	\
>>  		mkdir $$BUILD_TARGET  -p;	\
>>  		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;\
>>  	done
>> +endef
> 
> Taking the move of clean into lib.mk as a given,

Yeah I considered undoing that, and chose to fix the missed
issues instead.
> 
> Acked-by: Darren Hart (VMware) <dvhart@infradead.org>
> 

thanks,
-- Shuah
