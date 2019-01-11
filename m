Return-Path: <SRS0=2HDf=PT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BF7C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 13:11:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 619122084C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 13:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619122084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bjtw0mKmzDr4L
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 00:11:52 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bjs31bFDzDqng
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jan 2019 00:10:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43bjs30rhhz9s7h; Sat, 12 Jan 2019 00:10:15 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43bjs26R92z9s7T;
 Sat, 12 Jan 2019 00:10:14 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Lamparter <chunkeey@gmail.com>
Subject: Re: [1/2] powerpc/4xx/ocm: Fix phys_addr_t printf warnings
In-Reply-To: <1833028.0eqVQs4dtG@debian64>
References: <43V85g033hz9sCX@ozlabs.org> <3480116.KzcvcCly6l@debian64>
 <87ef9ntqy3.fsf@concordia.ellerman.id.au> <1833028.0eqVQs4dtG@debian64>
Date: Sat, 12 Jan 2019 00:10:11 +1100
Message-ID: <87va2ve3ws.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christian Lamparter <chunkeey@gmail.com> writes:
> On Tuesday, January 8, 2019 10:54:28 AM CET Michael Ellerman wrote:
>> Christian Lamparter <chunkeey@gmail.com> writes:
...
>> diff --git a/arch/powerpc/platforms/4xx/ocm.c b/arch/powerpc/platforms/4xx/ocm.c
>> index a1aaa1569d7c..f0e488d97567 100644
>> --- a/arch/powerpc/platforms/4xx/ocm.c
>> +++ b/arch/powerpc/platforms/4xx/ocm.c
>> @@ -237,12 +237,12 @@ static int ocm_debugfs_show(struct seq_file *m, void *v)
>>  			continue;
>>  
>>  		seq_printf(m, "PPC4XX OCM   : %d\n", ocm->index);
>> -		seq_printf(m, "PhysAddr     : %pa[p]\n", &(ocm->phys));
>> +		seq_printf(m, "PhysAddr     : %pa\n", &(ocm->phys));
>>  		seq_printf(m, "MemTotal     : %d Bytes\n", ocm->memtotal);
>>  		seq_printf(m, "MemTotal(NC) : %d Bytes\n", ocm->nc.memtotal);
>>  		seq_printf(m, "MemTotal(C)  : %d Bytes\n\n", ocm->c.memtotal);
>>  
>> -		seq_printf(m, "NC.PhysAddr  : %pa[p]\n", &(ocm->nc.phys));
>> +		seq_printf(m, "NC.PhysAddr  : %pa\n", &(ocm->nc.phys));
>>  		seq_printf(m, "NC.VirtAddr  : 0x%p\n", ocm->nc.virt);
>>  		seq_printf(m, "NC.MemTotal  : %d Bytes\n", ocm->nc.memtotal);
>>  		seq_printf(m, "NC.MemFree   : %d Bytes\n", ocm->nc.memfree);
>> @@ -252,7 +252,7 @@ static int ocm_debugfs_show(struct seq_file *m, void *v)
>>  							blk->size, blk->owner);
>>  		}
>>  
>> -		seq_printf(m, "\nC.PhysAddr   : %pa[p]\n", &(ocm->c.phys));
>> +		seq_printf(m, "\nC.PhysAddr   : %pa\n", &(ocm->c.phys));
>>  		seq_printf(m, "C.VirtAddr   : 0x%p\n", ocm->c.virt);
>>  		seq_printf(m, "C.MemTotal   : %d Bytes\n", ocm->c.memtotal);
>>  		seq_printf(m, "C.MemFree    : %d Bytes\n", ocm->c.memfree);
>
> Ok, with the patch applied it now looks like:
>
> |root@mbl:/sys/kernel/debug/ppc4xx_ocm# cat info 
> |PPC4XX OCM   : 1
> |PhysAddr     : 0x0000000400040000
> |MemTotal     : 32768 Bytes
> |MemTotal(NC) : 32768 Bytes
> |MemTotal(C)  : 0 Bytes
> |
> |NC.PhysAddr  : 0x0000000400040000
> |NC.VirtAddr  : 0x54f5bce2
> |NC.MemTotal  : 32768 Bytes
> |NC.MemFree   : 32768 Bytes
> |
> |C.PhysAddr   : 0x0000000000000000
> |C.VirtAddr   : 0x  (null)
> |C.MemTotal   : 0 Bytes
> |C.MemFree    : 0 Bytes
>
> ... just as expected. ;)

Thanks.

cheers
