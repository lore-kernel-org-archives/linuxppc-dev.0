Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C9B4D2C00C7
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Oct 2013 05:03:49 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 3 Oct 2013 15:03:47 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 2B18738C804F
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Oct 2013 15:03:44 -0400 (EDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r93J3i8B7930178
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Oct 2013 19:03:44 GMT
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r93J3e8M028608
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Oct 2013 13:03:41 -0600
Date: Thu, 3 Oct 2013 12:03:25 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 5/9][v5] powerpc: implement is_instr_load_store().
Message-ID: <20131003190325.GB21561@us.ibm.com>
References: <1380672911-12812-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1380672911-12812-6-git-send-email-sukadev@linux.vnet.ibm.com>
 <20131003053519.GC17237@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131003053519.GC17237@concordia>
Cc: Michael Ellerman <michaele@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman [michael@ellerman.id.au] wrote:
| On Tue, Oct 01, 2013 at 05:15:06PM -0700, Sukadev Bhattiprolu wrote:
| > Implement is_instr_load_store() to detect whether a given instruction
| > is one of the fixed-point or floating-point load/store instructions.
| > This function will be used in a follow-on patch to save memory hierarchy
| > information of the load/store.
| 
| The search over the array is a bit of a pity, especially as the worst
| case penalises you when you haven't hit a load/store.

Agree. Will try this out.  This is certainly more efficient.

| 
| I think we can do better. If you look at the opcode maps, and in
| particular the extended table for opcode 31, you'll see there's a
| reasonable amount of structure.
| 
| The following is only valid for arch 2.06, ie. it will classify reserved
| opcodes as being load/store, but I think that's fine for the moment. If
| we need to use it somewhere in future we can update it. But we should
| add a big comment saying it's only valid in that case.
| 
| Anyway, I think the following logic is all we need for opcode 31:
| 
| bool is_load_store(int ext_opcode)

how about I call this is_load_store_2_06() and add a comment. Horrible
but minimizes chance of misuse.

| {
|         upper = ext_opcode >> 5;
|         lower = ext_opcode & 0x1f;
| 
|         /* Short circuit as many misses as we can */
|         if (lower < 3 || lower > 23)
|             return false;
| 
|         if (lower == 3)
|             if (upper >= 16)
|                 return true;
| 
|             return false;
| 
|         if (lower == 6)
|             if (upper <= 1)
|                 return true;
|             return false;
| 
|         if (lower == 7 || lower == 12)
|             return true;
| 
|         if (lower >= 20) /* && lower <= 23 (implicit) */
|             return true;
| 
|         return false;
| }
| 
| 
| Which is not pretty, but I think it's preferable to the full search over the
| array.
| 
| cheers
