Return-Path: <shuahkh@osg.samsung.com>
Received: from osg.samsung.com
 (ec2-52-27-115-49.us-west-2.compute.amazonaws.com [52.27.115.49])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wC6163fBXzDqC2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 01:03:54 +1000 (AEST)
Subject: Re: [PATCH 8/8] selftests: x86: override clean in lib.mk to fix
 warnings
To: Michael Ellerman <mpe@ellerman.id.au>, shuah@kernel.org,
 bamvor.zhangjian@linaro.org, benh@kernel.crashing.org, paulus@samba.org,
 dvhart@infradead.org
References: <cover.1492815938.git.shuahkh@osg.samsung.com>
 <31b94c5cb9a8f71fd3888b648f32c0bd91e4a9bd.1492815938.git.shuahkh@osg.samsung.com>
 <87o9vpyp6h.fsf@concordia.ellerman.id.au>
Cc: viro@zeniv.linux.org.uk, emilio.lopez@collabora.co.uk, mingo@kernel.org,
 luto@kernel.org, dave.hansen@linux.intel.com, dsafonov@virtuozzo.com,
 rkrcmar@redhat.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Shuah Khan <shuahkh@osg.samsung.com>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <118fc070-61fa-b490-2d39-0e7910ec70d5@osg.samsung.com>
Date: Tue, 25 Apr 2017 09:03:51 -0600
MIME-Version: 1.0
In-Reply-To: <87o9vpyp6h.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/21/2017 11:41 PM, Michael Ellerman wrote:
> Shuah Khan <shuahkh@osg.samsung.com> writes:
> 
>> Add override for lib.mk clean to fix the following warnings from clean
>> target run.
>>
>> Makefile:44: warning: overriding recipe for target 'clean'
>> ../lib.mk:55: warning: ignoring old recipe for target 'clean'
>>
>> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
>> ---
>>  tools/testing/selftests/x86/Makefile | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
>> index 38e0a9c..4d27550 100644
>> --- a/tools/testing/selftests/x86/Makefile
>> +++ b/tools/testing/selftests/x86/Makefile
>> @@ -40,8 +40,9 @@ all_32: $(BINARIES_32)
>>  
>>  all_64: $(BINARIES_64)
>>  
>> -clean:
>> +override define CLEAN
>>  	$(RM) $(BINARIES_32) $(BINARIES_64)
>> +endef
> 
> Simpler as:
> 
> EXTRA_CLEAN := $(BINARIES_32) $(BINARIES_64)
> 

Will send v2 with this change.

thanks,
-- Shuah
