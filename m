Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42CF71A0018
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 23:11:56 +1000 (AEST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 9 Jul 2015 07:11:53 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 32C673E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 07:11:51 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t69DB6GK57999434
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jul 2015 06:11:06 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t69DAflg007385
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jul 2015 07:11:50 -0600
Date: Wed, 8 Jul 2015 15:09:44 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>, peterz@infradead.org
Subject: Re: [PATCH v4 4/7] powerpc/powernv: detect supported nest pmus and
 its events
Message-ID: <20150708220944.GB22635@us.ibm.com>
References: <1436360506-18805-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1436360506-18805-5-git-send-email-maddy@linux.vnet.ibm.com>
 <20150708220125.GA22635@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150708220125.GA22635@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sukadev Bhattiprolu [sukadev@linux.vnet.ibm.com] wrote:
| | @@ -50,6 +163,15 @@ static int nest_ima_dt_parser(void)
| |  		p8ni->vbase = (uint64_t) phys_to_virt(p8ni->pbase);
| |  	}
| | 
| | +	/* Look for supported Nest PMU units */
| | +	idx = 0;
| | +	for_each_node_by_type(dev, "nest-ima-unit") {
| | +		ret = nest_pmu_create(dev, idx);
| | +		if (ret)
| | +			return ret;
| | +		idx++;
| 
| idx not used?

Sorry, disregard this. Had my blinders on :-(
