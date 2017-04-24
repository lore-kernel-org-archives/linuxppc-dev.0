Return-Path: <shuah@kernel.org>
Received: from resqmta-po-02v.sys.comcast.net (resqmta-po-02v.sys.comcast.net
 [IPv6:2001:558:fe16:19:96:114:154:161])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBcYm0HHDzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 05:56:59 +1000 (AEST)
Reply-To: shuah@kernel.org
Subject: Re: [PATCH 8/8] selftests: x86: override clean in lib.mk to fix
 warnings
References: <cover.1492815938.git.shuahkh@osg.samsung.com>
 <31b94c5cb9a8f71fd3888b648f32c0bd91e4a9bd.1492815938.git.shuahkh@osg.samsung.com>
 <87o9vpyp6h.fsf@concordia.ellerman.id.au>
 <063D6719AE5E284EB5DD2968C1650D6DCFFD9941@AcuExch.aculab.com>
To: David Laight <David.Laight@ACULAB.COM>,
 'Michael Ellerman' <mpe@ellerman.id.au>, Shuah Khan
 <shuahkh@osg.samsung.com>,
 "bamvor.zhangjian@linaro.org" <bamvor.zhangjian@linaro.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "paulus@samba.org" <paulus@samba.org>,
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
Message-ID: <83d77bfe-6219-950e-82e0-4601a8ed010c@kernel.org>
Date: Mon, 24 Apr 2017 13:48:41 -0600
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DCFFD9941@AcuExch.aculab.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/24/2017 09:57 AM, David Laight wrote:
> From: Linuxppc-dev Michael Ellerman
>> Shuah Khan <shuahkh@osg.samsung.com> writes:
>>
>>> Add override for lib.mk clean to fix the following warnings from clean
>>> target run.
>>>
>>> Makefile:44: warning: overriding recipe for target 'clean'
>>> ../lib.mk:55: warning: ignoring old recipe for target 'clean'
>>>
>>> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
>>> ---
>>>  tools/testing/selftests/x86/Makefile | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
>>> index 38e0a9c..4d27550 100644
>>> --- a/tools/testing/selftests/x86/Makefile
>>> +++ b/tools/testing/selftests/x86/Makefile
>>> @@ -40,8 +40,9 @@ all_32: $(BINARIES_32)
>>>
>>>  all_64: $(BINARIES_64)
>>>
>>> -clean:
>>> +override define CLEAN
>>>  	$(RM) $(BINARIES_32) $(BINARIES_64)
>>> +endef
>>
>> Simpler as:
>>
>> EXTRA_CLEAN := $(BINARIES_32) $(BINARIES_64)
> 
> Actually for builds that insist on crapping all over the source tree I've used:
> 
> clean:
> 	rm -rf `cat .cvsignore 2>/dev/null`
> 
> 	David

This will have to be done as a separate change. The warnings I am fixing
are related to common clean target in lib.mk and the need to override.

thanks,
-- Shuah
