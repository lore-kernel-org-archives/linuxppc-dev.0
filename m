Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D4E921A119C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Dec 2015 09:19:49 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Thu, 17 Dec 2015 15:19:47 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 03CDF19D8026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 15:07:51 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBHMJkCw23462104
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 15:19:46 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBHMJjZt031085
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 15:19:46 -0700
Subject: Re: [PATCH 2/6] cxlflash: Fix to avoid virtual LUN failover failure
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>
References: <1449787867-23015-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1449788029-23093-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Message-ID: <5673350F.5040501@linux.vnet.ibm.com>
Date: Thu, 17 Dec 2015 16:19:59 -0600
MIME-Version: 1.0
In-Reply-To: <1449788029-23093-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/10/2015 4:53 PM, Uma Krishnan wrote:
> From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
>
> Applications which use virtual LUN's that are backed by a physical LUN
> over both adapter ports may experience an I/O failure in the event of
> a link loss (e.g. cable pull).
>
> Virtual LUNs may be accessed through one or both ports of the adapter.
> This access is encoded in the translation entries that comprise the
> virtual LUN and used by the AFU for load-balancing I/O and handling
> failover scenarios. In a link loss scenario, even though the AFU is
> able to maintain connectivity to the LUN, it is up to the application
> to retry the failed I/O. When applications are unaware of the virtual
> LUN's underlying topology, they are unable to make a sound decision of
> when to retry an I/O and therefore are forced to make their reaction to
> a failed I/O absolute. The result is either a failure to retry I/O or
> increased latency for scenarios where a retry is pointless.
>
> To remedy this scenario, provide feedback back to the application on
> virtual LUN creation as to which ports the LUN may be accessed. LUN's
> spanning both ports are candidates for a retry in a presence of an I/O
> failure.
>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> ---

Reviewed-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
