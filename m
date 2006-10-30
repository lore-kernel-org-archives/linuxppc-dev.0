Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 86FBF67D1D
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 09:15:55 +1100 (EST)
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4D2631CD@zch01exm20.fsl.freescale.net>
References: <4879B0C6C249214CBE7AB04453F84E4D2631CD@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3C52C167-8CD5-4731-9F66-D8651E712DDD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] qe_lib: Remove immrbar_virt_to_phys() function
Date: Mon, 30 Oct 2006 16:15:49 -0600
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 30, 2006, at 12:22 AM, Li Yang-r58472 wrote:

>> -----Original Message-----
>> From: Paul Mackerras [mailto:paulus@samba.org]
>> Sent: Monday, October 30, 2006 11:22 AM
>> To: Li Yang-r58472
>> Cc: linuxppc-dev@ozlabs.org
>> Subject: Re: [PATCH] qe_lib: Remove immrbar_virt_to_phys() function
>>
>> Li Yang writes:
>>
>>> Remove private physical address mapping routine in qe_lib.  Users
>>> of qe_lib should use generic functions like iopa().
>>> The change also addresses a bug found by Timur Tabi that cmd_input
>>> got mapped in qe_issue_cmd().  It should be written to CECDR
>>> unmodified.
>>
>> Do you mean that the argument to qe_issue_cmd is a physical address?
>> It seems to me that the bug fix you mention is the main thing the
>> patch does, and the removal of immrvar_virt_to_phys is a cleanup on
>> the side that is made possible by the bugfix.
>
> The argument cmd_input should be offset to the MURAM base.  The  
> cleanup
> is inspired by the bugfix but not result of the bugfix.  There are  
> still
> other users of the immrbar_virt_to_phy() which can be replaced.  The
> bugfix can be covered by the work of removing all users of the  
> routine.
> Or the removal will be depending on the bugfix to complete its  
> work.  Do
> you suggest us to separate the patches?

I'm confused, if there are other users of immrbar_virt_to_phy() how  
can you get ride of it completely?

I would suggest just sending the bugfix so it can go in for 2.6.19  
and we can do the cleanup after that.

- kumar
