Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (www.linutronix.de [62.245.132.108])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 85811B6FB0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jun 2011 23:53:19 +1000 (EST)
Message-ID: <4DE8E746.2080100@linutronix.de>
Date: Fri, 03 Jun 2011 15:53:10 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Suzuki Poulose <suzuki@in.ibm.com>
Subject: Re: [RFC][PATCH] Kexec support for PPC440x
References: <4DE345B0.8020505@in.ibm.com> <4DE50617.7090509@linutronix.de>
	<4DE72EFE.8080502@in.ibm.com> <4DE8CA76.2060303@in.ibm.com>
In-Reply-To: <4DE8CA76.2060303@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux ppc dev <linuxppc-dev@lists.ozlabs.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Suzuki Poulose wrote:
>>> The way you setup the 1:1 mapping should be close to what you are 
>>> doing on
>>> kernel entry.Isn't it possible to include the file here and in the entry
>>> code?
> 
>> I will make this change and resend the patch.
> 
> I took a look at the way we do it at kernel entry. It looks more cleaner 
> to leave
> it untouched. Especially, when we add the support for 47x in the future, 
> the code
>  will become more unreadable.
> 
> What do you think ?

So the entry code has one 256MiB mapping, you need 8 of those. Entry goes 
for TLB 63 and you need to be flexible and avoid TLB 63 :).
So after all you don't have that much in common with the entry code. If
you look at the FSL-book code then you will notice that I tried to share
some code.

I don't understand why you don't flip the address space bit. On fsl we
setup the tmp mapping in the "other address" space so we don't have two
mappings for the same address. The entry code could be doing this with STS
bit, I'm not sure.

If you want to keep your tiny mmu flip code instead of merging with the
entry code then please don't put it into a separate file. The only reason
why I did it, is to have the code once since I can't branch to it and I
wanted to share code.

> 
> Thanks
> 
> Suzuki

Sebastian
