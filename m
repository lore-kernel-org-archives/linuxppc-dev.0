Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3st19W1fsvzDrbq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2016 00:26:23 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9ADP620141322
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 09:26:21 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2606y55d6j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 09:26:21 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Mon, 10 Oct 2016 09:26:19 -0400
Subject: Re: [PATCH v7 1/6] perf annotate: Add cross arch annotate support
To: Arnaldo Carvalho de Melo <acme@kernel.org>
References: <1474472876-2706-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1474472876-2706-2-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <20161005111928.GQ7143@kernel.org>
Cc: linux-kernel@vger.kernel.org, kim.phillips@arm.com,
 linuxppc-dev@lists.ozlabs.org, peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com, treeze.taeung@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com, markus@trippelsdorf.de,
 namhyung@kernel.org, pawel.moll@arm.com, chris.ryder@arm.com,
 jolsa@kernel.org, mhiramat@kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Mon, 10 Oct 2016 18:56:06 +0530
MIME-Version: 1.0
In-Reply-To: <20161005111928.GQ7143@kernel.org>
Content-Type: text/plain; charset=windows-1252
Message-Id: <57FB96EE.3040407@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Arnaldo,

Sorry for little late replies, I was off last week.

Please find my comments.

On Wednesday 05 October 2016 04:49 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Sep 21, 2016 at 09:17:51PM +0530, Ravi Bangoria escreveu:
>> Change current data structures and function to enable cross arch
>> annotate.
>>
>> Current perf implementation does not support cross arch annotate.
>> To make it truly cross arch, instruction table of all arch should
>> be present in perf binary. And use appropriate table based on arch
>> where perf.data was recorded.
...
>>  	tok = strchr(name, '>');
>>  	if (tok == NULL)
>> @@ -252,16 +253,12 @@ static int mov__parse(struct ins_operands *ops, struct map *map __maybe_unused)
>>  		return -1;
>>  
>>  	target = ++s;
>> -#ifdef __arm__
>> +
>>  	comment = strchr(s, ';');
>> -#else
>> -	comment = strchr(s, '#');
>> -#endif
>> +	if (comment == NULL)
>> +		comment = strchr(s, '#');
>>  
>> -	if (comment != NULL)
>> -		s = comment - 1;
>> -	else
>> -		s = strchr(s, '\0') - 1;
>> +	s = (comment != NULL) ? comment - 1 : strchr(s, '\0') - 1;
> Why have you touched the above 4 lines? The code you provided is
> equivalent, i.e. has no value for this patch you're working on, just a
> distraction for reviewers, please don't do that.

Sorry about that. I did this change to make code more compact but
yes, you are right, that should be done as separate patch.

-Ravi
