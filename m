Return-Path: <SRS0=E5N6=QB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D958C282C0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 07:02:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67E8E2184B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 07:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E8E2184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iram.es
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43m9281qrVzDqN9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 18:02:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=iram.es
 (client-ip=130.206.19.173; helo=mx02.puc.rediris.es;
 envelope-from=paubert@iram.es; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=iram.es
Received: from mx02.puc.rediris.es (outbound3sev.lav.puc.rediris.es
 [130.206.19.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43m9083l6MzDqLk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 18:00:40 +1100 (AEDT)
Received: from sim.rediris.es (mta-out04.sim.rediris.es [130.206.24.46])
 (user=smtp-out_iram mech=LOGIN bits=0)
 by mx02.puc.rediris.es  with ESMTP id x0P70JWe026096-x0P70JWg026096
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 25 Jan 2019 08:00:19 +0100
Received: from sim.rediris.es (localhost.localdomain [127.0.0.1])
 by sim.rediris.es (Postfix) with ESMTPS id 8A7A339566;
 Fri, 25 Jan 2019 08:00:18 +0100 (CET)
Received: from sim.rediris.es (localhost.localdomain [127.0.0.1])
 by sim.rediris.es (Postfix) with ESMTPS id 00F4B3957D;
 Fri, 25 Jan 2019 08:00:17 +0100 (CET)
Received: from lt-gp.iram.es (gra-fw.iram.es [150.214.244.1])
 by sim.rediris.es (Postfix) with ESMTPA id BC5BF39566;
 Fri, 25 Jan 2019 08:00:16 +0100 (CET)
Date: Fri, 25 Jan 2019 08:00:16 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v13 00/10] powerpc: Switch to CONFIG_THREAD_INFO_IN_TASK
Message-ID: <20190125070016.j2lmcz7aidcbhznp@lt-gp.iram.es>
References: <cover.1547195976.git.christophe.leroy@c-s.fr>
 <2e700e1c-5bd9-652e-b535-68a89dd703a1@c-s.fr>
 <87y37ax3ru.fsf@concordia.ellerman.id.au>
 <9b4dab64-6a6b-a599-4676-bf891473ada7@c-s.fr>
 <c5b86b5b-1f38-39bf-0458-3c6572b3b35c@c-s.fr>
 <89049465-643f-b383-82e2-360dc9660d09@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89049465-643f-b383-82e2-360dc9660d09@c-s.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
X-FEAS-AUTH-USER: smtp-out_iram
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
Cc: linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 24, 2019 at 04:58:41PM +0100, Christophe Leroy wrote:
> 
> 
> Le 24/01/2019 à 16:01, Christophe Leroy a écrit :
> > 
> > 
> > Le 24/01/2019 à 10:43, Christophe Leroy a écrit :
> > > 
> > > 
> > > On 01/24/2019 01:06 AM, Michael Ellerman wrote:
> > > > Christophe Leroy <christophe.leroy@c-s.fr> writes:
> > > > > Le 12/01/2019 à 10:55, Christophe Leroy a écrit :
> > > > > > The purpose of this serie is to activate
> > > > > > CONFIG_THREAD_INFO_IN_TASK which
> > > > > > moves the thread_info into task_struct.
> > > > > > 
> > > > > > Moving thread_info into task_struct has the following advantages:
> > > > > > - It protects thread_info from corruption in the case of stack
> > > > > > overflows.
> > > > > > - Its address is harder to determine if stack addresses are
> > > > > > leaked, making a number of attacks more difficult.
> > > > > 
> > > > > I ran null_syscall and context_switch benchmark selftests
> > > > > and the result
> > > > > is surprising. There is slight degradation in context_switch and a
> > > > > significant one on null_syscall:
> > > > > 
> > > > > Without the serie:
> > > > > 
> > > > > ~# chrt -f 98 ./context_switch --no-altivec --no-vector --no-fp
> > > > > 55542
> > > > > 55562
> > > > > 55564
> > > > > 55562
> > > > > 55568
> > > > > ...
> > > > > 
> > > > > ~# ./null_syscall
> > > > >      2546.71 ns     336.17 cycles
> > > > > 
> > > > > 
> > > > > With the serie:
> > > > > 
> > > > > ~# chrt -f 98 ./context_switch --no-altivec --no-vector --no-fp
> > > > > 55138
> > > > > 55142
> > > > > 55152
> > > > > 55144
> > > > > 55142
> > > > > 
> > > > > ~# ./null_syscall
> > > > >      3479.54 ns     459.30 cycles
> > > > > 
> > > > > So 0,8% less context switches per second and 37% more time
> > > > > for one syscall ?
> > > > > 
> > > > > Any idea ?
> > > > 
> > > > What platform is that on?
> > > 
> > > It is on the 8xx
> 
> On the 83xx, I have a slight improvment:
> 
> Without the serie:
> 
> root@vgoippro:~# ./null_syscall
>     921.44 ns     307.15 cycles
> 
> With the serie:
> 
> root@vgoippro:~# ./null_syscall
>     918.78 ns     306.26 cycles
> 

The 8xx has very low cache associativity, something like 2, right?

In this case it may be access patterns which change the number of
cache line transfers when you move things around. 

Try to move things around in main(), for example allocate a variable of
~1kB on the stack in the function that performs the null_syscalls (use 
the variable before and after the loop, to avoid clever compiler
optimizations).

	Gabriel


> Christophe
> 
> > > 
> > > > 
> > > > On 64-bit we have to turn one mtmsrd into two and that's obviously a
> > > > slow down. But I don't see that you've done anything similar in 32-bit
> > > > code.
> > > > 
> > > > I assume it's patch 8 that causes the slow down?
> > > 
> > > I have not digged into it yet, but why patch 8 ?
> > > 
> > 
> > The increase of null_syscall duration happens with patch 5 when we
> > activate CONFIG_THREAD_INFO_IN_TASK.
> > 
