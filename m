Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BFB492C00C3
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 20:39:08 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 16 Oct 2013 15:09:05 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id BB652125803F
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 15:09:30 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9G9cxY123789748
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 15:09:00 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9G9d0iV003489
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 15:09:01 +0530
Message-ID: <525E5E79.6010905@linux.vnet.ibm.com>
Date: Wed, 16 Oct 2013 15:08:01 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH 02/10][v6] powerpc/Power7: detect load/store instructions
References: <1381889202-16826-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1381889202-16826-3-git-send-email-sukadev@linux.vnet.ibm.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B738E@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B738E@saturn3.aculab.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Ellerman <michaele@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/16/2013 01:55 PM, David Laight wrote:
>> Implement instr_is_load_store_2_06() to detect whether a given instruction
>> is one of the fixed-point or floating-point load/store instructions in the
>> POWER Instruction Set Architecture v2.06.
> ...

The op code encoding is dependent on the ISA version ? Does the basic load
and store instructions change with newer ISA versions ? BTW we have got a
newer version for the ISA "PowerISA_V2.07_PUBLIC.pdf" here at power.org

https://www.power.org/documentation/power-isa-version-2-07/

Does not sound like a good idea to analyse the instructions with functions
names which specify ISA version number. Besides, this function does not
belong to specific processor or platform. It has to be bit generic.
 
>> +int instr_is_load_store_2_06(const unsigned int *instr)
>> +{
>> +	unsigned int op, upper, lower;
>> +
>> +	op = instr_opcode(*instr);
>> +
>> +	if ((op >= 32 && op <= 58) || (op == 61 || op == 62))
>> +		return true;
>> +
>> +	if (op != 31)
>> +		return false;
>> +
>> +	upper = op >> 5;
>> +	lower = op & 0x1f;
>> +
>> +	/* Short circuit as many misses as we can */
>> +	if (lower < 3 || lower > 23)
>> +		return false;
>> +
>> +	if (lower == 3) {
>> +		if (upper >= 16)
>> +			return true;
>> +
>> +		return false;
>> +	}
>> +
>> +	if (lower == 7 || lower == 12)
>> +		return true;
>> +
>> +	if (lower >= 20) /* && lower <= 23 (implicit) */
>> +		return true;
>> +
>> +	return false;
>> +}
> 
> I can't help feeling the code could do with some comments about
> which actual instructions are selected where.

Yeah, I agree. At least which category of load-store instructions are
getting selected in each case.
