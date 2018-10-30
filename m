Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660DDC2BC61
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 10:57:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A186920827
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 10:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mpi-sws.org header.i=@mpi-sws.org header.b="aRvRd7ro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A186920827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mpi-sws.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kpMr4lt2zF14d
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 21:57:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=mpi-sws.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mpi-sws.org header.i=@mpi-sws.org header.b="aRvRd7ro";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=mpi-sws.org
 (client-ip=139.19.86.40; helo=juno.mpi-klsb.mpg.de;
 envelope-from=msammler@mpi-sws.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=mpi-sws.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=mpi-sws.org header.i=@mpi-sws.org header.b="aRvRd7ro"; 
 dkim-atps=neutral
Received: from juno.mpi-klsb.mpg.de (srv-40-62.mpi-klsb.mpg.de [139.19.86.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kpKH5ywwzDrhl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 21:55:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mpi-sws.org;
 s=mail200803; 
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject;
 bh=1ZoaTKysAHaeARK7fp/QmBZViqd9HjVRnAYK4x6Yx94=; 
 b=aRvRd7roczSg0X+RbVYozyIz3oieYP/d3MdydOo1V6T5FBFR/yH3cg7XWeza4I8EVR8a9P4C/iNl5Lx0Wpx3XW0OuVt+i2ZDhTRdpuCAsrg1uMPYpOy6ltXgT8mM7GV03RQcdlFwVTg4qy7H0pTa4KghRHIkl4EN/zJjp9ZE1yM=;
Received: from sam.mpi-klsb.mpg.de ([139.19.86.26]:38624)
 by juno.mpi-klsb.mpg.de (envelope-from <msammler@mpi-sws.org>) 
 with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.84_2) id 1gHRg6-0004NR-6d; Tue, 30 Oct 2018 11:55:20 +0100
Received: from wks-40-211.mpi-sws.org ([139.19.168.107]:50190)
 by sam.mpi-klsb.mpg.de (envelope-from <msammler@mpi-sws.org>) 
 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.84_2) id 1gHRg6-0003Yv-0p; Tue, 30 Oct 2018 11:55:18 +0100
Subject: Re: [RFC PATCH] seccomp: Add protection keys into seccomp_data
To: Dave Hansen <dave.hansen@intel.com>, Jann Horn <jannh@google.com>
References: <20181029112343.27454-1-msammler@mpi-sws.org>
 <CAGXu5jJ2fFmEXfUzga3XBXcsHPuPWWf5zLeyn8+Z1oZVa8oTuQ@mail.gmail.com>
 <7d93080b-68bd-7563-bd3b-e7ee1545e367@intel.com>
 <CAG48ez1mY7Osdsc4iJ1JKq=C60wb9bQF=aHbi1fb=pb_V2XMJA@mail.gmail.com>
 <62e09400-0443-8db9-a389-ba4f4201226b@intel.com>
 <2fefcbfc-1d7e-dfe8-d49a-07824218d389@mpi-sws.org>
 <6c7cd491-ab12-b553-68cf-f66b2eaa25de@intel.com>
From: Michael Sammler <msammler@mpi-sws.org>
Message-ID: <257eca22-8ef4-2621-8a62-d65d611abf61@mpi-sws.org>
Date: Tue, 30 Oct 2018 11:55:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6c7cd491-ab12-b553-68cf-f66b2eaa25de@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-MPI-Local-Sender: true
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: wad@chromium.org, Kees Cook <keescook@chromium.org>,
 Linux API <linux-api@vger.kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linuxram@us.ibm.com,
 Andy Lutomirski <luto@amacapital.net>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/29/2018 11:33 PM, Dave Hansen wrote:
> But, that's really an implementation detail.  The effect on the ABI and
> how this might constrain future pkeys use is my bigger worry.
> 
> I'd also want to make sure that your specific use-case is compatible
> with all the oddities of pkeys, like the 'clone' and signal behavior.
> Some of that is spelled out here:
> 
> 	http://man7.org/linux/man-pages/man7/pkeys.7.html
> 

I think my specific use case is compatible with these oddities since the 
untrusted code is not allowed to install signal handlers or spawn 
threads himself but only through the trusted code, which ensures, that 
the PKRU has the correct value when control passes back to the untrusted 
code. But I agree that these oddities are something a programmer needs 
to take into account if he uses pkeys in general (and this patch adds 
new considerations to it if the program installs a seccomp filter and 
e.g. wants to do system calls from a signal handler).

> One thing that's a worry is that we have never said that you *can't*
> write to arbitrary permissions in PKRU.  I can totally see some really
> paranoid code saying, "I'm about to do something risky, so I'll turn off
> access to *all* pkeys", or " turn off all access except my current
> stack".  If they did that, they might also inadvertently disable access
> to certain seccomp-restricted syscalls.
> 
> We can fix that up by documenting restrictions like "code should never
> change the access rights of any pkey other than those that it
> allocated", but that doesn't help any old code (of which I hope there is
> relatively little).
> 

I can also see paranoid code wanting to do something like you describe 
and I think, that we should try to not forbid this behaviour. 
Documenting restrictions on code which writes to the PKRU as you 
describe would be one way to go, but this would disallow this paranoid 
use case if I understand it correctly because the code would not be 
allowed to disable access to all except of one pkey.

My idea would be to not put the blame on the code which writes to the 
PKRU but on the code which installs the seccomp filter based on the 
PKRU: It has to make sure, that it allows the system calls which the 
paranoid code should be allowed to do when the pkey of the paranoid code 
is the (only) enabled pkey. This could be ensured e.g. by the paranoid 
code providing the pkey it intends to use to the code which installs the 
seccomp filter. This of course means, that you need to know what you are 
doing, when you install a seccomp filter which depends on the PKRU, but 
I think this is already the case when you install a seccomp filter 
without this patch (but maybe someone with more seccomp experience than 
me can say better how much reasoning is needed to install a seccomp 
filter without and with this patch).

-- Michael
