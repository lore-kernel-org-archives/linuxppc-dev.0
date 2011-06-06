Return-Path: <suzuki@in.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 57564B6FB6
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  6 Jun 2011 21:29:37 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p56BCrXe029207
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jun 2011 05:12:53 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	p56BTWDF055430
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jun 2011 05:29:32 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p565TUSm029964
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Jun 2011 23:29:31 -0600
Message-ID: <4DECBA16.7070300@in.ibm.com>
Date: Mon, 06 Jun 2011 16:59:26 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [RFC][PATCH] powerpc: Use the #address-cells information to
	parsememory/reg
References: <AE90C24D6B3A694183C094C60CF0A2F6D8AD73@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AD73@saturn3.aculab.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>,
	Simon Horman <horms@verge.net.au>,
	linux ppc dev <linuxppc-dev@lists.ozlabs.org>,
	Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/06/11 14:30, David Laight wrote:
>>> Changed the add_usable_mem_property() to accept FILE* fp instead of
> int fd,
>>> as most of the other users of read_memory_region_limits() deals with
> FILE*.
>>>
>>> Signed-off-by: Suzuki K. Poulose<suzuki@in.ibm.com>
>>
>> Could you please let me know your thoughts/comments about this patch ?
>
> Is the change to use 'FILE *' actually progress?
> I'd have thought that the randomly aligned read/lseek system calls
> that this allows to happen are not desirable for anything that
> isn't a true file.
I will revert the other users back to 'fd'
>
> I'd also suggest that the sizeof's should be applied to the
> actual type of the variable being read/written, not arbitrarily
> 'long' or 'int', and this probably ought to be some fixed size type.
I have used 'unsigned long'(for word sized values) or 'unsigned long long'
(for double words) just to make sure we get the right values. Is this OK ?

Thanks
Suzuki
