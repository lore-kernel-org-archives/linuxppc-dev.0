Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 416B7DDF57
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 16:04:58 +1000 (EST)
Message-ID: <471EE082.3090204@pobox.com>
Date: Wed, 24 Oct 2007 02:04:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH] Use of_get_next_child() in k2_sata_proc_info()
References: <2576ec47fb43bd1f4464beb8b78adfa70bdde418.1193199877.git.michael@ellerman.id.au>
	<1193202117.2085.45.camel@pasglop>
In-Reply-To: <1193202117.2085.45.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2007-10-24 at 14:25 +1000, Michael Ellerman wrote:
>> k2_sata_proc_info() uses its own hand-rolled loop to check a nodes
>> children for a property, this is not safe WRT refcounting, so fix it
>> to use of_get_next_child().
>>
>> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> (Pending you test boot it on one of our G5s first !)
> 
>> ---
>>  drivers/ata/sata_svw.c |    5 ++++-
>>  1 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
>> index 12d613c..64c3812 100644
>> --- a/drivers/ata/sata_svw.c
>> +++ b/drivers/ata/sata_svw.c
>> @@ -289,7 +289,10 @@ static int k2_sata_proc_info(struct Scsi_Host *shost, char *page, char **start,
>>  
>>  	/* Match it to a port node */
>>  	index = (ap == ap->host->ports[0]) ? 0 : 1;
>> -	for (np = np->child; np != NULL; np = np->sibling) {
>> +
>> +	for (np = of_get_next_child(np, NULL);
>> +	     np != NULL;
>> +	     np = of_get_next_child(np, np)) {
>>  		const u32 *reg = of_get_property(np, "reg", NULL);

This sort of thing I would prefer to ACK (ACK!), and let it go upstream 
via the powerpc tree.

	Jeff
