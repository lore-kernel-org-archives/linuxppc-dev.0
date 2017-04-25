Return-Path: <shuahkh@osg.samsung.com>
Received: from osg.samsung.com
 (ec2-52-27-115-49.us-west-2.compute.amazonaws.com [52.27.115.49])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wC60c1Y7fzDqJv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 01:03:28 +1000 (AEST)
Subject: Re: [PATCH 7/8] selftests: sync: override clean in lib.mk to fix
 warnings
To: Michael Ellerman <mpe@ellerman.id.au>, shuah@kernel.org,
 bamvor.zhangjian@linaro.org, benh@kernel.crashing.org, paulus@samba.org,
 dvhart@infradead.org
References: <cover.1492815938.git.shuahkh@osg.samsung.com>
 <dc66a97137df1b6a913463775466a96e0f3c13db.1492815938.git.shuahkh@osg.samsung.com>
 <87r30lyp75.fsf@concordia.ellerman.id.au>
Cc: viro@zeniv.linux.org.uk, emilio.lopez@collabora.co.uk, mingo@kernel.org,
 luto@kernel.org, dave.hansen@linux.intel.com, dsafonov@virtuozzo.com,
 rkrcmar@redhat.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, shuah Khan <shuahkh@osg.samsung.com>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <476527ab-aedc-c0b4-debb-2843ce1345d6@osg.samsung.com>
Date: Tue, 25 Apr 2017 09:03:24 -0600
MIME-Version: 1.0
In-Reply-To: <87r30lyp75.fsf@concordia.ellerman.id.au>
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
>> Makefile:24: warning: overriding recipe for target 'clean'
>> ../lib.mk:55: warning: ignoring old recipe for target 'clean'
>>
>> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
>> ---
>>  tools/testing/selftests/sync/Makefile | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/sync/Makefile b/tools/testing/selftests/sync/Makefile
>> index 87ac400..f7d250d 100644
>> --- a/tools/testing/selftests/sync/Makefile
>> +++ b/tools/testing/selftests/sync/Makefile
>> @@ -20,5 +20,6 @@ TESTS += sync_stress_merge.o
>>  
>>  sync_test: $(OBJS) $(TESTS)
>>  
>> -clean:
>> +override define CLEAN
>>  	$(RM) sync_test $(OBJS) $(TESTS)
>> +endef
> 
> EXTRA_CLEAN := sync_test $(OBJS) $(TESTS)
> 

Will send v2 with this change.

-- Shuah
