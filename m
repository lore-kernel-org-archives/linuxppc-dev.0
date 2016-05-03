Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzVnb5wpLzDrf4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:57:39 +1000 (AEST)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qzVnb4c34z9t44
 for <linuxppc-dev@ozlabs.org>; Tue,  3 May 2016 15:57:39 +1000 (AEST)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 3 May 2016 15:57:38 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2923B2CE8046
 for <linuxppc-dev@ozlabs.org>; Tue,  3 May 2016 15:57:35 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u435vRa44981172
 for <linuxppc-dev@ozlabs.org>; Tue, 3 May 2016 15:57:35 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u435v2sP009613
 for <linuxppc-dev@ozlabs.org>; Tue, 3 May 2016 15:57:02 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] selftests/powerpc: Fix subpage_prot test to return !0 on
 failure
In-Reply-To: <87bn4ozp2i.fsf@skywalker.in.ibm.com>
References: <1462164869-16406-1-git-send-email-mpe@ellerman.id.au>
 <87bn4ozp2i.fsf@skywalker.in.ibm.com>
Date: Tue, 03 May 2016 11:26:37 +0530
Message-ID: <8760uvznu2.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Michael Ellerman <mpe@ellerman.id.au> writes:
>
>> It's helpful for automated testing if the test returns error codes back
>> to the calling program.
>>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
>> ---
>>  tools/testing/selftests/powerpc/mm/subpage_prot.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/powerpc/mm/subpage_prot.c b/tools/testing/selftests/powerpc/mm/subpage_prot.c
>> index 440180ff8089..7ccdc96b977d 100644
>> --- a/tools/testing/selftests/powerpc/mm/subpage_prot.c
>> +++ b/tools/testing/selftests/powerpc/mm/subpage_prot.c
>> @@ -207,14 +207,16 @@ int test_file(void)
>>
>>  int main(int argc, char *argv[])
>>  {
>> -	test_harness(test_anon, "subpage_prot_anon");
>> +	int rc;
>> +
>> +	rc = test_harness(test_anon, "subpage_prot_anon");
>> +	if (rc)
>> +		return rc;
>>
>>  	if (argc > 1)
>>  		file_name = argv[1];
>>  	else
>>  		file_name = "tempfile";
>>
>> -	test_harness(test_file, "subpage_prot_file");
>> -
>> -	return 0;
>> +	return test_harness(test_file, "subpage_prot_file");
>>  }
>> -- 
>> 2.5.0

While doing this fix the error print ?

520175565: (4520111850): Failed at 0x0x3fffad4b0000 (p=13,sp=0,w=0), want=fault, got=pass !

diff --git a/tools/testing/selftests/powerpc/mm/subpage_prot.c b/tools/testing/selftests/powerpc/mm/subpage_prot.c
index 440180ff8089..5929866aa444 100644
--- a/tools/testing/selftests/powerpc/mm/subpage_prot.c
+++ b/tools/testing/selftests/powerpc/mm/subpage_prot.c
@@ -73,7 +73,7 @@ static inline void check_faulted(void *addr, long page, long subpage, int write)
 		want_fault |= (subpage == ((page + 1) % 16));
 
 	if (faulted != want_fault) {
-		printf("Failed at 0x%p (p=%ld,sp=%ld,w=%d), want=%s, got=%s !\n",
+		printf("Failed at %p (p=%ld,sp=%ld,w=%d), want=%s, got=%s !\n",
 		       addr, page, subpage, write,
 		       want_fault ? "fault" : "pass",
 		       faulted ? "fault" : "pass");
