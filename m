Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 784321A0E13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 07:37:18 +1000 (AEST)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Wed, 19 Aug 2015 22:37:13 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id EF35617D8059
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 22:38:45 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7JLb9oe34144364
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 21:37:09 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7JLb9GR030004
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 15:37:09 -0600
Message-ID: <55D4F702.4020503@linux.vnet.ibm.com>
Date: Wed, 19 Aug 2015 23:37:06 +0200
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.cz>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ben Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/hvsi: Fix endianness issues in the HVSI driver
References: <1438334990-11765-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6D1CB71D3E@AcuExch.aculab.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CB71D3E@AcuExch.aculab.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/08/2015 13:00, David Laight wrote:
> From: Laurent Dufour
>> Sent: 31 July 2015 10:30
>> This patch fixes several endianness issues detected when running the HVSI
>> driver in little endian mode.
>>
>> These issues are raised in little endian mode because the data exchanged in
>> memory between the kernel and the hypervisor has to be in big endian
>> format.
> ...
>> diff --git a/drivers/tty/hvc/hvsi.c b/drivers/tty/hvc/hvsi.c
>> index 41901997c0d6..a75146f600cb 100644
>> --- a/drivers/tty/hvc/hvsi.c
>> +++ b/drivers/tty/hvc/hvsi.c
>> @@ -240,9 +240,9 @@ static void hvsi_recv_control(struct hvsi_struct *hp, uint8_t *packet,
>>  {
>>  	struct hvsi_control *header = (struct hvsi_control *)packet;
>>
>> -	switch (header->verb) {
>> +	switch (be16_to_cpu(header->verb)) {
>>  		case VSV_MODEM_CTL_UPDATE:
>> -			if ((header->word & HVSI_TSCD) == 0) {
>> +			if ((be32_to_cpu(header->word) & HVSI_TSCD) == 0) {
> 
> It is generally best to byteswap constants.
> 
> 	David

Thanks David for your review.
Regarding the byte swapping of the constants, I'm wondering if this  the
best way here.
For instance, Benjamin wrote a similar patch to fix another endianness
issue (99fc1d91b8fc) and he doesn't convert the constant neither.
It think that byte swapping the constant value will impact more code,
and may not ease code reading.

Cheers,
Laurent.
