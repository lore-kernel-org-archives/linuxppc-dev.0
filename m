Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 1F9EDDDE0A
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 01:12:26 +1100 (EST)
Message-ID: <47288D4F.2090504@ru.mvista.com>
Date: Wed, 31 Oct 2007 17:12:31 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [POWERPC] Fix off-by-one error in setting decrementer on Book
 E
References: <18213.19469.827909.663373@cargo.ozlabs.ibm.com>	<47260FE5.5080107@ru.mvista.com>
	<18216.19826.611308.659235@cargo.ozlabs.ibm.com>
In-Reply-To: <18216.19826.611308.659235@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Paul Mackerras wrote:

> If I take out the removed lines in the rest of your patch, I get:

>>+        */
>>  #if defined(CONFIG_40x)
>>         mtspr(SPRN_PIT, val);
>>+#else
>>+#if !defined(CONFIG_BOOKE)
>>+       val = val ? val - 1 : 0;
>>+#endif
>>+#if defined(CONFIG_8xx_CPU6)
>>         set_dec_cpu6(val);
>>+#if defined(CONFIG_PPC_ISERIES)

> I think you're missing a #else here.

    You've cut off #endif's at the end.  But yes, you are correct -- I've lost 
it while pasting this hunk into mail. :-/

> Paul.

WBR, Sergei
