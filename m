Return-Path: <masami.hiramatsu.pt@hitachi.com>
Received: from mailx.hitachi.co.jp (fallback.hitachi.co.jp [133.145.228.49])
 by lists.ozlabs.org (Postfix) with ESMTP id 6DFA01A0BEF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 22:54:12 +1100 (AEDT)
Received: from mail9.hitachi.co.jp (mail9.hitachi.co.jp [133.145.228.44])
 by mailx.hitachi.co.jp (Postfix) with ESMTP id 5FCA217707B7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 20:20:23 +0900 (JST)
Message-ID: <5502C7EF.8080007@hitachi.com>
Date: Fri, 13 Mar 2015 20:20:15 +0900
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Re: [PATCHv2 2/8] perf probe: Improve detection of file/function
 name in the probe pattern
References: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
 <d60cf320bc3d51ca8980e48bc31044cacba8a920.1418654436.git.naveen.n.rao@linux.vnet.ibm.com>
 <20150312202414.GD3550@kernel.org>
In-Reply-To: <20150312202414.GD3550@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(2015/03/13 5:24), Arnaldo Carvalho de Melo wrote:
> Em Mon, Dec 15, 2014 at 08:20:32PM +0530, Naveen N. Rao escreveu:
>> Currently, perf probe considers patterns including a '.' to be a file.
>> However, this causes problems on powerpc ABIv1 where all functions have
>> a leading '.':
>>
>>   $ perf probe -F | grep schedule_timeout_interruptible
>>   .schedule_timeout_interruptible
>>   $ perf probe .schedule_timeout_interruptible
>>   Semantic error :File always requires line number or lazy pattern.
>>     Error: Command Parse Error.
>>
>> Fix this by checking the probe pattern in more detail.
> 
> Masami, can I have your Acked-by or Reviewed-by?

As far as I can see, this is not enough for fixing that issue.
Could you fold the first half of [4/8] to this patch?
I also have some comments on it. See below.

>  
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> ---
>>  tools/perf/util/probe-event.c | 23 ++++++++++++++++++++---
>>  1 file changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
>> index 28eb141..9943ff3 100644
>> --- a/tools/perf/util/probe-event.c
>> +++ b/tools/perf/util/probe-event.c
>> @@ -999,6 +999,24 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
>>  		arg = tmp;
>>  	}
>>  
>> +	/*
>> +	 * Check arg is function or file name and copy it.
>> +	 *
>> +	 * We consider arg to be a file spec if and only if it satisfies
>> +	 * all of the below criteria::
>> +	 * - it does not include any of "+@%",
>> +	 * - it includes one of ":;", and
>> +	 * - it has a period '.' in the name.
>> +	 *
>> +	 * Otherwise, we consider arg to be a function specification.
>> +	 */
>> +	c = 0;

Oh please, don't reuse 'char c' for a boolean flag, you should
introduce new 'bool file_loc' etc.

>> +	if (!strpbrk(arg, "+@%") && (ptr = strpbrk(arg, ";:")) != NULL) {
>> +		/* This is a file spec if it includes a '.' before ; or : */
>> +		if (memchr(arg, '.', ptr-arg))
                                        ^^ add spaces around '-'.

Thank you,


>> +			c = 1;
>> +	}
>> +
>>  	ptr = strpbrk(arg, ";:+@%");
>>  	if (ptr) {
>>  		nc = *ptr;
>> @@ -1009,10 +1027,9 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
>>  	if (tmp == NULL)
>>  		return -ENOMEM;
>>  
>> -	/* Check arg is function or file and copy it */
>> -	if (strchr(tmp, '.'))	/* File */
>> +	if (c == 1)
>>  		pp->file = tmp;
>> -	else			/* Function */
>> +	else
>>  		pp->function = tmp;
>>  
>>  	/* Parse other options */
>> -- 
>> 2.1.3
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
