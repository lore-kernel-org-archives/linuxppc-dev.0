Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5004667A73
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Apr 2006 03:32:26 +1000 (EST)
In-Reply-To: <1144080994.4449.10.camel@localhost.localdomain>
References: <20060403014044.GA4704@krispykreme>
	<1144080994.4449.10.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1078253E-4B9E-4432-86E3-82B01A4B68D1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: _machine removal breaks kexec?
Date: Mon, 3 Apr 2006 12:32:39 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 3, 2006, at 11:16 AM, Benjamin Herrenschmidt wrote:

> On Mon, 2006-04-03 at 11:40 +1000, Anton Blanchard wrote:
>> Hi,
>>
>> It looks like the _machine removal broke kexec:
>>
>>  # kexec -l vmlinux
>>  /proc/device-tree/chosen/linux,platform: No such file or directory
>>
>> The kexec tools seem to want the linux,platform property:
>>
>>         /* if LPAR, no need to read any more from /chosen */
>>         if (platform != PLATFORM_PSERIES) {
>>                 closedir(cdir);
>>                 continue;
>>         }
>
> Damn.... the platform numbers are gone, we need to fix that. (And  
> nobody
> complained when I posted the patch twice over the past couple of  
> monthes
> btw).
>
> I suppose kexec needs to look for /rtas/hypertas or such ..

uugh, can we make kexec not depend on something that embedded systems  
would also have.

- k
