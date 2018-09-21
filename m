Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GnZd3GrRzF3Q8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 18:58:48 +1000 (AEST)
Subject: Re: [REVIEW][PATCH 7/9] signal/poewrpc: Specialize _exception_pkey
 for handling pkey exceptions
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
References: <878t3yitze.fsf@xmission.com>
 <20180918175850.4437-7-ebiederm@xmission.com>
 <20180921185429.4cda432e@canb.auug.org.au>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <b140e12e-e1fa-1878-16d0-531ffc821e6f@c-s.fr>
Date: Fri, 21 Sep 2018 10:58:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180921185429.4cda432e@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 21/09/2018 à 10:54, Stephen Rothwell a écrit :
> Hi Eric,
> 
> On Tue, 18 Sep 2018 19:58:48 +0200 "Eric W. Biederman" <ebiederm@xmission.com> wrote:
>>
>> Now that _exception no longer calls _exception_pkey it is no longer
>> necessary to handle any signal with any si_code.  All pkey exceptions
>> are SIGSEGV with paired with SEGV_PKUERR.  So just handle
>> that case and remove the now unnecessary parameters from _exception_pkey.
>>
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> Looks fine to me (small query below).
> 
> Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>

In the patch title, s/poewrpc/powerpc

> 
>>   	clear_siginfo(&info);
>> -	info.si_signo = signr;
>> -	info.si_code = code;
>> +	info.si_signo = SIGSEGV;
>> +	info.si_code = SEGV_PKUERR;
>>   	info.si_addr = (void __user *) addr;
>>   	info.si_pkey = key;
>>   
>> -	force_sig_info(signr, &info, current);
>> +	force_sig_info(info.si_signo, &info, current);
>                         ^^^^^^^^^^^^^
> Why not just SIGSEGV?
> 
