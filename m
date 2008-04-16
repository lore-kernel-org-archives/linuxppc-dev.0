Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 87C92DE24E
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 10:51:01 +1000 (EST)
Message-Id: <70DB6F9F-A860-4986-9FB6-60FB00A55296@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18437.16961.768567.782611@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 12/12] [POWERPC] 85xx: Add support for relocatble kernel
	(and booting at non-zero)
Date: Tue, 15 Apr 2008 19:50:55 -0500
References: <1207824531-27168-1-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-2-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-3-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-4-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-5-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-6-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-7-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-8-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-9-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-10-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-11-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-12-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-13-git-send-email-galak@kernel.crashing.org>
	<18436.35348.316368.332336@cargo.ozlabs.ibm.com>
	<C2C3AFC1-7527-4571-8E21-3EB5904695DE@kernel.crashing.org>
	<18437.16961.768567.782611@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 15, 2008, at 7:03 PM, Paul Mackerras wrote:
> Kumar Gala writes:
>
>>> What happens if CONFIG_KERNEL_START != CONFIG_PAGE_OFFSET and the
>>> kernel is loaded at some address != CONFIG_PHYSICAL_START?
>>
>> Assuming its not a CONFIG_RELOCATABLE kernel than bad things.  Is
>> there some concern you have here?
>
> No, I meant if it is a CONFIG_RELOCATABLE kernel.

if CONFIG_RELOCATABLE is set, than PHYSICAL_START has no meaning  
(beyond being what we set paddr to for the PHDR).

Its ok if KERNEL_START != PAGE_OFFSET.  The key is that the physical  
address the kernel is loaded at meet the alignment requirements.   
(currently 256M, will relax in the future once we get a form of this  
in the tree).

> BTW, the various bits of discussion we've about this stuff would make
> good material for the patch description.

Agreed was thinking the same thing.  Suggestions on useful bits to add  
are welcome.

- k
