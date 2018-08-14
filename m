Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41qK6x0sDTzF0Qs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2018 14:16:57 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Cc: Gustavo Romero <gromero@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] selftests/powerpc: Avoid remaining process/threads
In-Reply-To: <a4f9f03b-51dd-55d4-cfec-9ae48fbbd9d6@debian.org>
References: <87bmajhh40.fsf@concordia.ellerman.id.au>
 <1533307039-13744-1-git-send-email-leitao@debian.org>
 <87bmafoiu5.fsf@concordia.ellerman.id.au>
 <a4f9f03b-51dd-55d4-cfec-9ae48fbbd9d6@debian.org>
Date: Tue, 14 Aug 2018 14:16:56 +1000
Message-ID: <87a7pplgzr.fsf@concordia.ellerman.id.au>
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

Breno Leitao <leitao@debian.org> writes:

> Hello Michael,
>
> On 08/06/2018 08:06 AM, Michael Ellerman wrote:
>> Breno Leitao <leitao@debian.org> writes:
>> 
>>> diff --git a/tools/testing/selftests/powerpc/harness.c b/tools/testing/selftests/powerpc/harness.c
>>> index 66d31de60b9a..06c51e8d8ccb 100644
>>> --- a/tools/testing/selftests/powerpc/harness.c
>>> +++ b/tools/testing/selftests/powerpc/harness.c
>>> @@ -85,13 +85,16 @@ int run_test(int (test_function)(void), char *name)
>>>  	return status;
>>>  }
>>>  
>>> -static void alarm_handler(int signum)
>>> +static void sig_handler(int signum)
>>>  {
>>> -	/* Jut wake us up from waitpid */
>>> +	if (signum == SIGINT)
>>> +		kill(-pid, SIGTERM);
>> 
>> I don't think we need to do that here, if we just return then we'll pop
>> out of the waitpid() and go via the normal path.
>
> Correct, if we press ^C while the parent process is waiting at waitpid(),
> then waitpid() syscall will be interrupted (EINTR) and never restarted again
> (unless we set sa_flags = SA_RESTART), thus, the code will restart to execute
> the next instruction when the signal handler is done, as we had skipped
> waitpid().
>
> From a theoretical point of view, the user can press ^C before the process
> executes waitpid() syscall. In this case and the process will not 'skip' the
> waitpid(), which will continue to wait. We can clearly force this behavior
> putting a sleep(1) before waitpid() and pressing  ^C in the very first
> second, it will 'skip' the nanosleep() syscall instead of waitpid() which
> will be there, and the ^C will be ignored (thus not calling kill(-pid, SIGTERM)).

True.

Though that race also exists vs us registering the SIGINT handler, so
it's basically not solvable, the user can always press ^C before we're
ready.

cheers
