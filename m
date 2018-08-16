Return-Path: <srs0=fute=k7=kernel.crashing.org=segher@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41rpyc3J6QzDqp5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 00:44:56 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41rpyc2Yy3z8wGN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 00:44:56 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41rpyb50phz9s3x
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2018 00:44:55 +1000 (AEST)
Date: Thu, 16 Aug 2018 09:44:36 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Ananth Narayan <ananth@in.ibm.com>
Subject: Re: [PATCH v7 4/9] powerpc/pseries: Define MCE error event section.
Message-ID: <20180816144435.GZ31204@gate.crashing.org>
References: <153365127532.14256.1965469477086140841.stgit@jupiter.in.ibm.com>
 <153365141396.14256.7147876868875454254.stgit@jupiter.in.ibm.com>
 <87r2j8apj1.fsf@concordia.ellerman.id.au>
 <13f8280f-02c1-7b00-0a40-a045bf6ee1f6@linux.vnet.ibm.com>
 <87lg97aqxc.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87lg97aqxc.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!

On Thu, Aug 16, 2018 at 02:14:39PM +1000, Michael Ellerman wrote:
> Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
> > On 08/08/2018 08:12 PM, Michael Ellerman wrote:
> >>> +			uint8_t	reserved_1[6];
> >>> +			__be64	effective_address;
> >>> +			__be64	logical_address;
> >>> +		} ue_error;
> >>> +		struct {
> >>> +			uint8_t	soft_err_type;
> >>> +			/* XXXXXXXX
> >>> +			 * X		1: Effective address provided.
> >>> +			 *  XXXXX	5: Reserved.
> >>> +			 *       XX	2: Type of SLB/ERAT/TLB error.
> >>> +			 */
> >>> +			uint8_t	reserved_1[6];
> >>> +			__be64	effective_address;
> >>> +			uint8_t	reserved_2[8];
> >>> +		} soft_error;
> >>> +	} u;
> >>> +};
> >>> +#pragma pack(pop)
> >> 
> >> Why not __packed ?
> >
> > Because when used __packed it added 1 byte extra padding between
> > reserved_1[6] and effective_address. That caused wrong effective address
> > to be printed on the console. Hence I switched to #pragma pack to force
> > 1 byte alignment for this structure alone.
> 
> OK, that's weird.

Yes, if that is true, then please open a GCC bugzilla report.


Segher
