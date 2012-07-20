Return-Path: <sjenning@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1F3B42C0092
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jul 2012 00:04:06 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sjenning@linux.vnet.ibm.com>;
 Fri, 20 Jul 2012 10:03:45 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id C5721C9004C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 10:02:49 -0400 (EDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6KE2jkq351682
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 10:02:45 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6KE1RBo028773
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 08:01:29 -0600
Message-ID: <500964A7.1020702@linux.vnet.ibm.com>
Date: Fri, 20 Jul 2012 09:01:11 -0500
From: Seth Jennings <sjenning@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 3/4] powerpc/crypto: add 842 hardware compression driver
References: <1342708961-28587-1-git-send-email-sjenning@linux.vnet.ibm.com>
 <1342708961-28587-4-git-send-email-sjenning@linux.vnet.ibm.com>
 <1342762410.15356.7.camel@concordia>
In-Reply-To: <1342762410.15356.7.camel@concordia>
Content-Type: text/plain; charset=UTF-8
Cc: Robert Jennings <rcj@linux.vnet.ibm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Kent Yoder <key@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/20/2012 12:33 AM, Michael Ellerman wrote:
> On Thu, 2012-07-19 at 09:42 -0500, Seth Jennings wrote:
>> This patch adds the driver for interacting with the 842
>> compression accelerator on IBM Power7+ systems.
> 
> ...
> 
>> +struct nx842_slentry {
>> +	unsigned long ptr; /* Absolute address (use virt_to_abs()) */
>> /+	unsigned long len;
>> +};
> 
> These days virt_to_abs() is just __pa() - ie. convert to a real address.

Thanks, I'll make that change.

Is it a blocker to the code being pulled in though? I'm
hoping to get this in ASAP for the 3.6 merge window.  As
this isn't a functional defect (I assume __pa() and
virt_to_abs() still achieve the same result), can I get an
OK from you that this isn't a blocker to the code being
accepted?

I'll submit a patch later to make this change.

Thanks again!

Seth
