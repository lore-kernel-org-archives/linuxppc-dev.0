Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41kZZq2bxZzF3HG
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2018 21:06:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>,
 Gustavo Romero <gromero@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] selftests/powerpc: Avoid remaining process/threads
In-Reply-To: <1533307039-13744-1-git-send-email-leitao@debian.org>
References: <87bmajhh40.fsf@concordia.ellerman.id.au>
 <1533307039-13744-1-git-send-email-leitao@debian.org>
Date: Mon, 06 Aug 2018 21:06:10 +1000
Message-ID: <87bmafoiu5.fsf@concordia.ellerman.id.au>
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

> diff --git a/tools/testing/selftests/powerpc/harness.c b/tools/testing/selftests/powerpc/harness.c
> index 66d31de60b9a..06c51e8d8ccb 100644
> --- a/tools/testing/selftests/powerpc/harness.c
> +++ b/tools/testing/selftests/powerpc/harness.c
> @@ -85,13 +85,16 @@ int run_test(int (test_function)(void), char *name)
>  	return status;
>  }
>  
> -static void alarm_handler(int signum)
> +static void sig_handler(int signum)
>  {
> -	/* Jut wake us up from waitpid */
> +	if (signum == SIGINT)
> +		kill(-pid, SIGTERM);

I don't think we need to do that here, if we just return then we'll pop
out of the waitpid() and go via the normal path.

Can you test with the existing signal handler, but wired up to SIGINT?

cheers
