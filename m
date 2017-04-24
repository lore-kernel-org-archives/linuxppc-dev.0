Return-Path: <shuah@kernel.org>
Received: from resqmta-po-03v.sys.comcast.net (resqmta-po-03v.sys.comcast.net
 [IPv6:2001:558:fe16:19:96:114:154:162])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBcW60YqBzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 05:54:41 +1000 (AEST)
Reply-To: shuah@kernel.org
Subject: Re: [PATCH 2/8] selftests: lib.mk: define CLEAN macro to allow
 Makefiles to override clean
References: <cover.1492815938.git.shuahkh@osg.samsung.com>
 <b39e21f8c47318d82be999aae310bdf6bcfc9bb9.1492815938.git.shuahkh@osg.samsung.com>
 <063D6719AE5E284EB5DD2968C1650D6DCFFD98E2@AcuExch.aculab.com>
To: David Laight <David.Laight@ACULAB.COM>,
 'Shuah Khan' <shuahkh@osg.samsung.com>,
 "bamvor.zhangjian@linaro.org" <bamvor.zhangjian@linaro.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "dvhart@infradead.org" <dvhart@infradead.org>
Cc: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
 "dsafonov@virtuozzo.com" <dsafonov@virtuozzo.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "emilio.lopez@collabora.co.uk" <emilio.lopez@collabora.co.uk>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "luto@kernel.org" <luto@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "mingo@kernel.org" <mingo@kernel.org>, Shuah Khan <shuah@kernel.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <8845c13f-eaeb-86a1-1ac8-d7c52e934ef4@kernel.org>
Date: Mon, 24 Apr 2017 13:46:23 -0600
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DCFFD98E2@AcuExch.aculab.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/24/2017 09:45 AM, David Laight wrote:
> From: Shuah Khan
>> Sent: 22 April 2017 00:15
>> Define CLEAN macro to allow Makefiles to override common clean target
>> in lib.mk. This will help fix the following failures:
>>
>> warning: overriding recipe for target 'clean'
>> ../lib.mk:55: warning: ignoring old recipe for target 'clean'
>>
>> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
>> ---
>>  tools/testing/selftests/lib.mk | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
>> index 775c589..959273c 100644
>> --- a/tools/testing/selftests/lib.mk
>> +++ b/tools/testing/selftests/lib.mk
>> @@ -51,8 +51,12 @@ endef
>>  emit_tests:
>>  	$(EMIT_TESTS)
>>
>> -clean:
>> +define CLEAN
>>  	$(RM) -r $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) $(EXTRA_CLEAN)
>> +endef
>> +
>> +clean:
>> +	$(CLEAN)
> 
> If might be easier to do something like:
> 
> ifneq($(NO_CLEAN),y)
> clean:
> 	$(RM) -r $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) $(EXTRA_CLEAN)
> endif
> 
> 	David
> 

I am not sure that it is easier. Defining a macro would work well
in this case to override and also works well with what we are doing
for other overrides we already have such as EMIT_TESTS.

thanks,
-- Shuah
