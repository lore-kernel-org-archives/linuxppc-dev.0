Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yQGBd6G4JzDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 11:51:21 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9U0mk4J022869
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Oct 2017 20:51:19 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dwevc68ea-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Oct 2017 20:51:18 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Sun, 29 Oct 2017 18:51:18 -0600
Date: Sun, 29 Oct 2017 17:51:06 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/16] Remove hash page table slot tracking from linux PTE
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20171027040833.3644-1-aneesh.kumar@linux.vnet.ibm.com>
 <20171027043430.GA27483@fergus.ozlabs.ibm.com>
 <adf2d270-29df-701f-206e-0d8a35084e47@linux.vnet.ibm.com>
 <20171028223532.GA5587@ram.oc3035372033.ibm.com>
 <20171029220417.GA3317@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171029220417.GA3317@fergus.ozlabs.ibm.com>
Message-Id: <20171030005106.GD5587@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 30, 2017 at 09:04:17AM +1100, Paul Mackerras wrote:
> On Sat, Oct 28, 2017 at 03:35:32PM -0700, Ram Pai wrote:
> > 
> > I like the idea of not tracking the slots at all. It is something the
> > guest should not be knowing or tracking.
> 
> Why do you say that?

'slot' is a internal mechanism used by the hash table to accelerate
mapping an address to a hash-page.  If the hash-table implementation
choose to use a different mechanism to accelerate the mapping, it can't
because that mechanism is baked into the logic of all the consumers.

RP
