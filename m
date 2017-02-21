Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSB5V2RcwzDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 17:52:46 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vSB5T6HDhz9s03
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 17:52:45 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1L6nHOk146443
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 01:52:44 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28r3phbpay-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 01:52:44 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 21 Feb 2017 16:52:41 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E595F2BB0059
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 17:52:38 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1L6qUvQ27263042
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 17:52:38 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1L6q6Yk032244
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 17:52:06 +1100
Subject: Re: [RFC PATCH 1/7] powerpc/book3s: Move machine check event
 structure to opal-api.h
To: Nicholas Piggin <npiggin@gmail.com>
References: <148764180622.19289.14009454092692029974.stgit@jupiter.in.ibm.com>
 <148764191593.19289.166429326262713768.stgit@jupiter.in.ibm.com>
 <20170221123520.594ad9df@roar.ozlabs.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, skiboot@lists.ozlabs.org
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Tue, 21 Feb 2017 12:21:47 +0530
MIME-Version: 1.0
In-Reply-To: <20170221123520.594ad9df@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <963fc07b-fba7-1508-8109-e55f84ca8320@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/21/2017 08:05 AM, Nicholas Piggin wrote:
> On Tue, 21 Feb 2017 07:21:56 +0530
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> 
>> +enum MCE_TlbErrorType {
>> +	MCE_TLB_ERROR_INDETERMINATE = 0,
>> +	MCE_TLB_ERROR_PARITY = 1,
>> +	MCE_TLB_ERROR_MULTIHIT = 2,
>> +	MCE_TLB_ERROR_TLBIEL_PROG_ERROR = 3,
>> +};
> 
> The new TLBIE error isn't really a TLB error as such. Not a hardware error.
> I added a new "user" type for it.
> 
> I don't think we can handle it just by flushing TLB because it can also be
> raised in response to invalid non-local tlbie. We could flush all TLBs maybe
> but I think also have to advance nip to return to.

ok got it.

> 
>> +
>> +enum MCE_NestErrorType {
>> +	MCE_NEST_ERROR_ABRT_IFETCH = 0,
>> +	MCE_NEST_ERROR_ABRT_IFETCH_TABLEWALK = 1,
>> +	MCE_NEST_ERROR_ABRT_LOAD = 2,
>> +	MCE_NEST_ERROR_ABRT_LOAD_TABLEWALK = 3,
>> +};
>> +
>> +enum MCE_CrespErrorType {
>> +	MCE_CRESP_ERROR_BAD_RADDR_IFETCH = 0,
>> +	MCE_CRESP_ERROR_BAD_RADDR_IFETCH_TABLEWALK = 1,
>> +	MCE_CRESP_ERROR_BAD_RADDR_LOAD = 2,
>> +	MCE_CRESP_ERROR_BAD_RADDR_LOAD_TABLEWALK = 3,
>> +};
>> +
>> +enum MCE_FspaceErrorType {
>> +	MCE_FSPACE_ERROR_IFETCH = 0,
>> +	MCE_FSPACE_ERROR_IFETCH_TABLEWALK = 1,
>> +	MCE_FSPACE_ERROR_RADDR_TRANSLATION = 2,
>> +	MCE_FSPACE_ERROR_RADDR_LOAD = 3,
>> +};
>> +
>> +enum MCE_AsyncErrorType {
>> +	MCE_ASYNC_ERROR_REAL_ADDR_STORE = 0,
>> +	MCE_ASYNC_ERROR_NEST_ABRT_STORE = 1,
>> +};
>> +
>> +struct OpalMachineCheckEvent {
> 
> Can we have more of a think about this structure and error types
> before making it an OPAL API?

Agree. I was just thinking how about we can just replace the entire
union as below:

	uint8_t 	specific_error_type;		/* 0x20 */
	uint8_t		effective_address_provided;	/* 0x21 */
	uint8_t		physical_address_provided;	/* 0x22 */
	uint8_t		reserved_1[5];			/* 0x23 */
	uint64_t	effective_address;		/* 0x28 */
	uint64_t	physical_address;		/* 0x30 */
	uint8_t		reserved_2[8];			/* 0x38 */
};

What do you say ? May increase few more bytes as reserved for future.

> 
> Errors don't always fit neatly into a simple classification like
> this. For example "async" is not really an error. It's a property
> of how the error is reported. The error is a timeout or real
> address error. And it's caused by a store. And initiated by nest
> or cResp... Other errors are caused by a table walk that was
> caused by a store, etc.
> 
> I shoehorned these async errors into realaddr/link types in my
> patch along with a different severity (i.e., not SYNC). But I
> think we can do a lot better with a clean slate for OPAL.

I see.

> 
> More general thing is, I wonder how much we need to know of the
> implementation details in this API? This still seems like it's
> unnecessarily split between OS and FW. I think it would be much
> nicer if we just return a set of things that the OS can usefully
> respond to and have firmware construct the detailed messages for
> logging.
> 
> That way we'll have much fewer new types of errors we don't know
> how to handle, and never have to report unknown error.

Makes sense. That would make linux MCE error printing much simpler and
we may never have to modify it to add new strings. We can probably add
char buffer to machine check struct or send it as separate string buffer.

Thanks,
-Mahesh.
