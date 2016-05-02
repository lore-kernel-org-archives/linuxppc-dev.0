Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qz1xw66W7zDqDq
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 May 2016 21:18:12 +1000 (AEST)
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qz1xw14R7z9sBm
 for <linuxppc-dev@ozlabs.org>; Mon,  2 May 2016 21:18:11 +1000 (AEST)
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 2 May 2016 16:48:09 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id AD53AE005E
 for <linuxppc-dev@ozlabs.org>; Mon,  2 May 2016 16:51:02 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u42BI8KW2490660
 for <linuxppc-dev@ozlabs.org>; Mon, 2 May 2016 16:48:08 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u42BI3CK019712
 for <linuxppc-dev@ozlabs.org>; Mon, 2 May 2016 16:48:03 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] selftests/powerpc: Fix subpage_prot test to return !0 on
 failure
In-Reply-To: <1462164869-16406-1-git-send-email-mpe@ellerman.id.au>
References: <1462164869-16406-1-git-send-email-mpe@ellerman.id.au>
Date: Mon, 02 May 2016 16:47:41 +0530
Message-ID: <87bn4ozp2i.fsf@skywalker.in.ibm.com>
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

Michael Ellerman <mpe@ellerman.id.au> writes:

> It's helpful for automated testing if the test returns error codes back
> to the calling program.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>


Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> ---
>  tools/testing/selftests/powerpc/mm/subpage_prot.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/powerpc/mm/subpage_prot.c b/tools/testing/selftests/powerpc/mm/subpage_prot.c
> index 440180ff8089..7ccdc96b977d 100644
> --- a/tools/testing/selftests/powerpc/mm/subpage_prot.c
> +++ b/tools/testing/selftests/powerpc/mm/subpage_prot.c
> @@ -207,14 +207,16 @@ int test_file(void)
>
>  int main(int argc, char *argv[])
>  {
> -	test_harness(test_anon, "subpage_prot_anon");
> +	int rc;
> +
> +	rc = test_harness(test_anon, "subpage_prot_anon");
> +	if (rc)
> +		return rc;
>
>  	if (argc > 1)
>  		file_name = argv[1];
>  	else
>  		file_name = "tempfile";
>
> -	test_harness(test_file, "subpage_prot_file");
> -
> -	return 0;
> +	return test_harness(test_file, "subpage_prot_file");
>  }
> -- 
> 2.5.0
