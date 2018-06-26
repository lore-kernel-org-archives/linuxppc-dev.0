Return-Path: <breno.debian@gmail.com>
Received: from mail-qk0-f194.google.com (mail-qk0-f194.google.com
 [209.85.220.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41FRLP1NwhzF1GF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2018 23:13:17 +1000 (AEST)
Received: by mail-qk0-f194.google.com with SMTP id c131-v6so9441932qkb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2018 06:13:17 -0700 (PDT)
Subject: Re: [PATCH v2] selftests/powerpc: Fix strncpy usage
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
References: <1529535071-14555-1-git-send-email-leitao@debian.org>
 <1529962249-24774-1-git-send-email-leitao@debian.org>
 <87lgb286iq.fsf@concordia.ellerman.id.au>
From: Breno Leitao <leitao@debian.org>
Message-ID: <564b7724-c081-9c09-e500-b010c2117415@debian.org>
Date: Tue, 26 Jun 2018 10:13:07 -0300
MIME-Version: 1.0
In-Reply-To: <87lgb286iq.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 06/26/2018 02:24 AM, Michael Ellerman wrote:
> Breno Leitao <leitao@debian.org> writes:
> 
>> There is a buffer overflow in dscr_inherit_test.c test. In main(), strncpy()'s
>> third argument is the length of the source, not the size of the destination
>> buffer, which makes strncpy() behaves like strcpy(), causing a buffer overflow
>> if argv[0] is bigger than LEN_MAX (100).
>>
>> This patch allocates 'prog' according to the argv[0] length, avoiding LEN_MAX
>> restriction.
>>
>> CC: Segher Boessenkool <segher@kernel.crashing.org>
>> CC: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> Signed-off-by: Breno Leitao <leitao@debian.org>
>> ---
>>  tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c b/tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c
>> index 08a8b95e3bc1..ecac4900c7dd 100644
>> --- a/tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c
>> +++ b/tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c
>> @@ -19,7 +19,7 @@
>>   */
>>  #include "dscr.h"
>>  
>> -static char prog[LEN_MAX];
>> +static char *prog;
>>  
>>  static void do_exec(unsigned long parent_dscr)
>>  {
>> @@ -104,6 +104,13 @@ int main(int argc, char *argv[])
>>  		exit(1);
>>  	}
>>  
>> -	strncpy(prog, argv[0], strlen(argv[0]));
>> +	prog = malloc(strlen(argv[0]) + 1);
>> +	if (prog == NULL) {
>> +		fprintf(stderr, "Unable to allocate enough memory\n");
>> +		exit(1);
>> +	}
>> +
>> +	strcpy(prog, argv[0]);
> 
> Why do we need to copy it at all?

We do not. Pointing proj to argv[0], as you proposed, should be the best
solution for this problem.

Thanks!
