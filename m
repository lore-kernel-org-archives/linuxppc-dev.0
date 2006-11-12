Return-Path: <brking@us.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EC8A367DD2
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Nov 2006 14:56:05 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAC3tvQe025613
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 22:55:58 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAC3tvRM231302
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 22:55:57 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAC3tv55024943
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 22:55:57 -0500
Message-ID: <45569B17.20405@us.ibm.com>
Date: Sat, 11 Nov 2006 21:55:03 -0600
From: Brian King <brking@us.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ipr SATA support is causing problems
References: <17748.25705.543922.486456@cargo.ozlabs.ibm.com>	<45549962.108@us.ibm.com>
	<17749.1504.630761.341652@cargo.ozlabs.ibm.com>	<4556631C.1070308@us.ibm.com>
	<1163292641.4982.249.camel@localhost.localdomain>
In-Reply-To: <1163292641.4982.249.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: James.Bottomley@SteelEye.com, linuxppc-dev@ozlabs.org, torvalds@osdl.org,
	Paul Mackerras <paulus@samba.org>, akpm@osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Sat, 2006-11-11 at 17:56 -0600, Brian King wrote:
>> Paul Mackerras wrote:
>>> How hard would it be to make the SATA bits conditionally compiled in,
>>> depending on CONFIG_ATA?
>> I took a look at doing this. It got a bit messy with a bunch of ifdefs,
>> then I realized that doing this would break module dependencies. If
>> ipr does not depend on CONFIG_ATA, then libata will not automatically
>> get loaded (or built into initrd's) when ipr is needed.
>>
>> The best way I can see to accomplish your desired goal is to do something
>> like the fusion driver did and separate out the sas bits from the scsi
>> bits and essentially end up with multiple ipr modules. Unfortunately,
>> this is not 2.6.19 material, but I could start working on it if you
>> thought it sounded like a reasonable direction.
> 
> Yeah, something like
> 
>                     /--- SATA sub-modules (depends on CONFIG_ATA)
>  - core IPR module /
>                    \
>                     \--- SAS sub-module (depends on CONFIG_SCSI)
>                      \ 
>                       \--- SCSI sub-module (depends on CONFIG_SCSI)
> 
> 
> Or do you need SAS and SATA to be one and only one ?

SAS and SATA need to be one and only one. Splitting them is where
the complication comes in. So that would mean we would have
something like:

                     /--- SCSI sub-module
  - core IPR module /
     (depends on    \
       CONFIG_SCSI)  \--- SAS/SATA sub-module (depends on CONFIG_ATA)


Brian

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
